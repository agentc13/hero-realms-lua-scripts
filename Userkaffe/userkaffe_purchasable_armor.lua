require 'herorealms'
require 'decks'
require 'stdlib'
require 'timeoutai'
require 'hardai_2'
require 'aggressiveai'


function purchasable_armor_carddef()
	local cardLayout = createLayout({
		name = "Purchasable Armor",
		art = "icons/dark_sign",
		cost = 1,
		frame = "frames/HR_CardFrame_Item_Generic",
		text = "Purchase to get armor."
	})
	
	return createActionDef({
		id = "purchasable_armor",
		name = "Purchasable Armor",
		acquireCost = 1,
		layout = cardLayout,
		abilities = {},
		cardEffectAbilities = {
			createCardEffectAbility({
				trigger = postSelfAcquiredCardTrigger,
				effect = createCardEffect(ranger_sureshot_bracer_carddef(), currentSkillsLoc).seq(sacrificeTarget().apply(selectSource()))
			})
		},
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
		centerRow = { "purchasable_armor" },
        players = {
            {
                id = plid1,
                startDraw = 3,
                name = "Player 1",
                avatar="assassin",
                health = 50,
                cards = {
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
