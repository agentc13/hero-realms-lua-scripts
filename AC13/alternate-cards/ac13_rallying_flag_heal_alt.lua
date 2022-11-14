require "herorealms"
require "decks"
require "stdlib"
require "stdcards"
require "hardai"
require "mediumai"
require "easyai"

function fighter_rallying_flag_carddef()
    return createActionDef(
        {
            id = "fighter_rallying_flag",
            name = "Rallying Flag",
            types = {actionType, noStealType},
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "fighter_rallying_flag",
                        trigger = autoTrigger,
                        effect = gainGoldEffect(1).seq(gainHealthEffect(3))
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Rallying Flag",
                    art = "art/T_Fighter_Rallying_Flag.png",
                    frame = "frames/Warrior_CardFrame",
                    text = '<size=200%><sprite name="gold_1">   <sprite name="health_3">'
                }
            )
        }
    )
end

function setupGame(g)
    standardSetup(
        g,
        {
            description = "Rallying Flag Alt",
            playerOrder = {plid1, plid2},
            ai = ai.CreateKillSwitchAi(createAggressiveAI(), createHardAi2()),
            timeoutAi = createTimeoutAi(),
            opponents = {{plid1, plid2}},
            players = {
                {
                    id = plid1,
                    startDraw = 3,
                    init = {
                        -- sets how hero get initialized
                        fromEnv = plid1 -- takes hero data from the selection (VS AI or Online)
                    },
                    cards = {
                        -- cards allows to add any cards to any of hero location at the start of the game
                        deck = {
                            {qty = 1, card = fighter_rallying_flag_carddef()},
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
                    avatar = "skeleton",
                    health = 50,
                    cards = {
                        deck = {
                            {qty = 1, card = dagger_carddef()},
                            {qty = 1, card = shortsword_carddef()},
                            {qty = 1, card = ruby_carddef()},
                            {qty = 7, card = gold_carddef()}
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


function setupMeta(meta)
    meta.name = "ac13_rallying_flag_heal_alt"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/timot/OneDrive/Documents/Hero-Realms-Lua-Scripts/AC13/alternate-cards/ac13_rallying_flag_heal_alt.lua"
     meta.features = {
}

end