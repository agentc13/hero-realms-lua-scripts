require "herorealms"
require "decks"
require "stdlib"
require "stdcards"
require "hardai"
require "mediumai"
require "easyai"

function afterlife_carddef()
    local cardLayout =
        createLayout(
        {
            name = "Afterlife",
            art = "art/T_Feisty_Orcling",
            frame = "frames/HR_CardFrame_Action_Necros",
            cost = 3,
            text = '<size=200%><sprite name="gold_2"></size>\n<size=60%> Necros Ally: You may put a champion from your discard pile to the top of your deck.</size>'
        }
    )

    return createActionDef(
        {
            id = "afterlife",
            name = "Afterlife",
            types = {actionType},
            factions = {necrosFaction},
            acquireCost = 3,
            abilities = {
                createAbility(
                    {
                        id = "afterlife_main",
                        trigger = autoTrigger,
                        effect = gainGoldEffect(2),
                    }
                ),
                createAbility(
                    {
                        id = "afterlife_faction",
                        allyFactions = {necrosFaction},
                        effect = pushTargetedEffect ({
                                desc = "Put a champion from your discard pile to the top of your deck.",
                                validTargets = selectLoc(loc(currentPid,discardPloc)).where(isCardChampion()),
                                min = 0,
                                max = 1,
                                targetEffect = moveTarget(currentDeckLoc),
                    }),
                        trigger = uiTrigger,
                        tags = {allyTag},
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
            afterlife_carddef()
        }
    )

    standardSetup(
        g,
        {
            description = "Afterlife Test",
            playerOrder = {plid1, plid2},
            ai = createHardAi(),
            randomOrder = true,
            opponents = {{plid1, plid2}},
            centerRow = {"afterlife", "fire_bomb", "grak__storm_giant", "tyrannor__the_devourer", "domination"},
            tradeDeckExceptions = {
                {qty = 2, cardId = "afterlife"}
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
    meta.name = "ks_afterlife_wip"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "Z:/Projects/hero-realms-lua-scripts/AC13/ks_afterlife_wip.lua"
     meta.features = {
}

end