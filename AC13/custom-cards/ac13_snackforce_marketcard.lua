require "herorealms"
require "decks"
require "stdlib"
require "stdcards"
require "hardai"
require "mediumai"
require "easyai"

function snackforce_carddef()
    local cardLayout =
        createLayout(
        {
            name = "Snackforce",
            art = "art/T_Feisty_Orcling",
            frame = "frames/HR_CardFrame_Action_Necros",
            cost = 2,
            text = '<size=200%><sprite name="gold_1">   <sprite name="health_3">'
        }
    )

    return createActionDef(
        {
            id = "snackforce",
            name = "Snackforce",
            types = {actionType},
            acquireCost = 2,
            abilities = {
                createAbility(
                    {
                        id = "snackforce",
                        trigger = autoTrigger,
                        effect = gainGoldEffect(1).seq(gainHealthEffect(3))
                    }
                )
            },
            layout = cardLayout
        }
    )
end

function setupGame(g)
    registerCards(
        g,
        {
            snackforce_carddef()
        }
    )

    standardSetup(
        g,
        {
            description = "Snackforce Test",
            playerOrder = {plid1, plid2},
            ai = createHardAi(),
            randomOrder = true,
            opponents = {{plid1, plid2}},
            centerRow = {"snackforce", "fire_bomb", "grak__storm_giant", "tyrannor__the_devourer", "domination"},
            tradeDeckExceptions = {
                {qty = 2, cardId = "snackforce"}
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
                            fatigueCount(40, 1, "FatigueP1")
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
                            {qty = 2, card = dagger_carddef()},
                            {qty = 8, card = gold_carddef()}
                        },
                        buffs = {
                            drawCardsAtTurnEndDef(),
                            discardCardsAtTurnStartDef(),
                            fatigueCount(40, 1, "FatigueP2")
                        }
                    }
                }
            }
        }
    )
end

function endGame(g)
end

function setupMeta(meta)
    meta.name = "ac13_snackforce_market_card"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "D:/HRLS/Hero-Realms-Lua-Scripts/AC13/ac13_snackforce_market_card.lua"
    meta.features = {}
end
