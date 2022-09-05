require 'herorealms'
require 'decks'
require 'stdlib'
require 'stdcards'
require 'hardai'
require 'mediumai'
require 'easyai'




-- purchasable armor

function purchasable_armor_carddef()
	local cardLayout = createLayout({
		name = "Orc Pauldrons",
        art = "icons/battle_cry",
		cost = 5,
		frame = "frames/HR_CardFrame_Item_Generic",
        text = (
            "<size=300%><line-height=0%><voffset=-.8em> <pos=-75%><sprite name=\"requiresHealth_20\"></size><line-height=80%> \n <voffset=1.8em><size=80%> If you have dealt 5 <sprite name=\"combat\"> to an opponent this turn. \n  Gain 2 <sprite name=\"health\"> \n or Draw 1 \n then discard 1 </size>"
            ),
	})
	
	return createActionDef({
		id = "orc_pauldrons_armor",
		name = "Orc Pauldrons",
		acquireCost = 5,
		layout = cardLayout,
		abilities = {},
		cardEffectAbilities = {
			createCardEffectAbility({
				trigger = postSelfAcquiredCardTrigger,
				effect = createCardEffect(orc_pauldrons_carddef(), currentSkillsLoc).seq(sacrificeTarget().apply(selectSource()))
			})
		},
	})
end

-- end purchasable armor

-- orc pauldrons armor card

function orc_pauldrons_carddef()
    local cardLayout = createLayout({
        name = "Orc Pauldrons",
        art = "icons/battle_cry",
        frame = "frames/Warrior_CardFrame",
        text = (
            "<size=300%><line-height=0%><voffset=-.8em> <pos=-75%><sprite name=\"requiresHealth_20\"></size><line-height=80%> \n <voffset=1.8em><size=80%> If you have dealt 5 <sprite name=\"combat\"> to an opponent this turn. \n  Gain 2 <sprite name=\"health\"> \n or Draw 1 \n then discard 1 </size>"
            ),
    })

    return createMagicArmorDef({
        id = "orc_pauldrons",
        name = "Orc Pauldrons",
        layout = cardLayout,
        layoutPath = "icons/battle_cry",
        abilities = {
            createAbility({
                id = "orc_pauldrons",
                layout = cardLayout,
                effect = pushChoiceEffect({
                    choices = {
                        {
                            effect = drawCardsEffect(1).seq(
                                pushTargetedEffect({
                                    desc = "Discard a card",
                                    min = 1,
                                    max = 1,
                                    validTargets = selectLoc(currentHandLoc),
                                    targetEffect = discardTarget()
                                })),
                            layout = layoutCard({
                                title = "Orc Pauldrons",
                                art = "icons/battle_cry",
                                text = ("Draw 1 then discard 1."),
                            }),
                            tags = { draw1Tag }

                        },
                        {
                            effect = gainHealthEffect(2),
                            layout = layoutCard({
                                title = "Orc Pauldrons",
                                art = "icons/battle_cry",
                                text = ("{2 health}"),
                            }),
                            tags = { gainHealth2Tag }
                        }
                    }
                }),
                trigger = uiTrigger,
                check = minDamageTakenOpp(5).And(minHealthCurrent(20)),
                cost = expendCost,
                tags = { draw1Tag, gainHealthTag, gainHealth2Tag },
            })
        }
    })
end

-- end orc pauldrons armor card

function setupGame(g)
    registerCards(g, { 
    purchasable_armor_carddef(),
    orc_pauldrons_carddef()
})

standardSetup(g, {
    description = "Purchasable Orc Pauldrons Armor Test",
    playerOrder = { plid1, plid2 },
    ai = createHardAi(),
    randomOrder = true,
    opponents = { { plid1, plid2 } },
    centerRow = { "orc_pauldrons_armor", "fire_bomb", "grak__storm_giant", "tyrannor__the_devourer", "domination" },
    tradeDeckExceptions = {
        { qty = 0, cardId = "fire_bomb" },
        { qty = 0, cardId = "grak__storm_giant" },
        { qty = 0, cardId = "tyrannor__the_devourer" },
        { qty = 0, cardId = "domination" },
    },
    noTradeDeck = false,
    noFireGems = false,
    players = {
        {
            id = plid1,
            init = {
                fromEnv = plid1
            },
            cards = {
                buffs = {
                    drawCardsAtTurnEndDef(),
                    discardCardsAtTurnStartDef(),
                    fatigueCount(40, 1, "FatigueP1"),
                }
            }
        },
        {
            id = plid2,
            isAi = true,
            name = "AI",
            avatar = "skeleton",
            health = 50,
            cards = {
                deck = {
                    { qty = 1, card = shortsword_carddef() },
                    { qty = 1, card = ruby_carddef() },
                    { qty = 1, card = dagger_carddef() },
                    { qty = 7, card = gold_carddef() },
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

function setupMeta(meta)
    meta.name = "ac13_orc_pauldrons_purchasable"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/timot/OneDrive/Documents/Hero-Realms-Lua-Scripts/AC13/ac13_orc_pauldrons_purchasable.lua"
     meta.features = {
}

end