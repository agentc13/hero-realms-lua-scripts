require 'herorealms'
require 'decks'
require 'stdlib'
require 'stdcards'
require 'hardai'
require 'mediumai'
require 'easyai'


-- still working on ally functions and market row scrap. The abilities/text are wip for now.
function trpldubz_carddef()
    local cardLayout = createLayout({
        name = "TrplDubz",
        art = "",
        frame = "frames/Warrior_CardFrame",
        cost = 3,
        text = (
            "<size=300%><line-height=0%><voffset=-.8em> <pos=-75%><sprite name=\"requiresHealth_25\"></size><line-height=80%> \n <voffset=1.8em><size=80%> If you have played a weapon this turn \n Draw 1 then \n discard 1,  or \n Gain 2 <sprite name=\"health\"> </size>"
            ),
    })

    return createMagicArmorDef({
        id = "orc_pauldrons",
        name = "Orc Pauldrons",
        layout = cardLayout,
        layoutPath = "icons/battle_cry",
        abilities = {
            createCardEffect({
                id = "acquire_armor",
                effect = acquireTarget(0, currentSkillsLoc)
            }),
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
                check = selectLoc(currentCastLoc).where(isCardType(weaponType)).count()
                    .gte(1),
                cost = expendCost,
                tags = { draw1Tag, gainHealthTag, gainHealth2Tag },
            })
        }
    })
end



function setupGame(g)
        registerCards(g, {
        orc_pauldrons_carddef()
    })

    standardSetup(g, {
        description = "TrplDubz Test",
        playerOrder = { plid1, plid2 },
        ai = createHardAi(),
        randomOrder = true,
        opponents = { { plid1, plid2 } },
        centerRow = { "orc_pauldrons", "fire_bomb", "grak__storm_giant", "tyrannor__the_devourer", "domination" },
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
                        { qty = 2, card = dagger_carddef() },
                        { qty = 8, card = gold_carddef() },
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
    meta.name = "ac13_trpldubz_companion_wip"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/timot/OneDrive/Documents/Hero-Realms-Lua-Scripts/AC13/ac13_trpldubz_companion_wip.lua"
     meta.features = {
}

end