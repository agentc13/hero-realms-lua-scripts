require 'herorealms'
require 'decks'
require 'stdlib'
require 'timeoutai'
require 'hardai_2'
require 'aggressiveai'

-- simple script with hardcoded decks and no skills/abilities

function purchasable_armor_carddef()
	local cardLayout = createLayout({
		name = "Shining Breastplate",
		art = "icons/cleric_shining_breastplate",
		cost = 1,
		frame = "frames/Cleric_armor_frame",
		text = "Target Champion gets +1 <sprite name=\"shield\"> permanently."
	})
	
	return createDef({
		id = "purchasable_armor",
		name = "Purchasable Armor",
		acquireCost = 1,
		layout = cardLayout,
		abilities = {
			createAbility({
                id = "cleric_shining_breastplate",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
                effect = pushTargetedEffect(
                {
                        desc = "Choose a champion to get +1 defense (permanent)",
                        validTargets =  s.CurrentPlayer(CardLocEnum.InPlay),
                        min = 1,
                        max = 1,
                        targetEffect = grantHealthTarget(1, { SlotExpireEnum.Never }, nullEffect(), "shield"),
                        tags = {toughestTag}                        
                    }
                ),
                cost = expendCost,
                check = selectLoc(currentInPlayLoc).where(isCardChampion()).count().gte(1)
            })
		},
		cardEffectAbilities = {
			createCardEffectAbility({
				trigger = postSelfAcquiredCardTrigger,
				effect = playTarget().apply(selectSource())
			})
		},
		types = {},
		layout = cardLayout,
		cardTypeLabel = "Magic Armor",
		playLocation = inPlayPloc
	})
end

function setupGame(g)
	registerCards(g, {
		purchasable_armor_carddef()
	})

    standardSetup(g, {
        description = "Custom no heroes game",
        playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(),  createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
		centerRow = { "purchasable_armor", "tithe_priest", "tithe_priest", "tithe_priest", "tithe_priest" },
        players = {
            {
                id = plid1,
                startDraw = 3,
                name = "Player 1",
                avatar="assassin",
                health = 50,
                cards = {
					hand = {
						{ qty=1, card=rasmus__the_smuggler_carddef() }
					},
                    deck = { -- orc deck still in progress
                        { qty=2, card=dagger_carddef() },
                        { qty=8, card=gold_carddef() },
                    },
                    buffs = {
                        drawCardsAtTurnEndDef(),
                        discardCardsAtTurnStartDef(),
                        fatigueCount(40, 1, "FatigueP1")
                    }
                }
            },
            {
                id = plid2,
				isAi = true, 
                startDraw = 5,
                name = "Player 2",
                avatar="assassin",
                health = 50,
                cards = {
                    deck = {
                        { qty=2, card=dagger_carddef() },
                        { qty=8, card=gold_carddef() },
                    },
                    buffs = {
                        drawCardsAtTurnEndDef(),
                        discardCardsAtTurnStartDef(),
                        fatigueCount(40, 1, "FatigueP2")
                    }
                }
            }            
        }
    })
end

function endGame(g)
end
