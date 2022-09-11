require "herorealms"
require "decks"
require "stdlib"
require "stdcards"
require "hardai"
require "mediumai"
require "easyai"

function fighter_hand_scythe_carddef()
    return createActionDef(
        {
            id = "fighter_hand_scythe",
            name = "Hand Scythe",
            types = {weaponType, noStealType, fighterType, itemType, meleeWeaponType, scytheType},
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "fighter_hand_scythe",
                        trigger = autoTrigger,
                        effect = gainGoldEffect(2).seq(
                            pushTargetedEffect(
                                {
                                    desc = "Deal 3 damage to an opposing guard.",
                                    min = 1,
                                    max = 1,
                                    validTargets = selectLoc(loc(oppPid, inPlayPloc)).where(isCardStunnable()),
                                    targetEffect = damageTarget(3)
                                }
                            )
                        )
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Hand Scythe",
                    art = "art/T_Flesh_Ripper",
                    frame = "frames/Warrior_CardFrame",
                    text = '<size=50%><i>Replaces: Gold</i></size><br><size=170%><sprite name="gold_2"></size> <br><size=75%>Deal 3 damage to an opposing guard.</size>'
                }
            )
        }
    )
end

function setupGame(g)
    standardSetup(
        g,
        {
            description = "Hand Scythe Test", -- script description - displayed in in-game menu
            playerOrder = {plid1, plid2}, -- order in which players take turns
            ai = createHardAi(), -- sets AI for ai players
            -- randomOrder = true, -- if true, randomizes players order
            opponents = {{plid1, plid2}}, -- pairs of opponents
            players = {
                -- array of players
                {
                    id = plid1, -- sets up id for the player. options are plid1, plid2, plid3, plid4
                    startDraw = 3, -- sets how many cards player draws at the start of the game. If not set, first player will draw 3, second player - 5
                    init = {
                        -- sets how hero get initialized
                        fromEnv = plid1 -- takes hero data from the selection (VS AI or Online)
                    },
                    cards = {
                        -- cards allows to add any cards to any of hero location at the start of the game
                        buffs = {
                            drawCardsAtTurnEndDef(),
                            discardCardsAtTurnStartDef(),
                            fatigueCount(40, 1, "FatigueP1")
                        },
                        deck = {
                            fighter_hand_scythe_carddef()
                        }
                    }
                },
                {
                    id = plid2,
                    isAi = true,
                    startDraw = 5,
                    name = "Sackforce",
                    avatar = "tentacles",
                    health = 50,
                    cards = {
                        deck = {
                            {qty = 1, card = tentacle_carddef()},
                            {qty = 1, card = tentacle_whip_carddef()},
                            {qty = 3, card = elixir_of_fortune_carddef()},
                            {qty = 5, card = gold_male_dark_carddef()}
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

function endGame(g) -- more info on this later
end

function setupMeta(meta)
    meta.name = "ac13_hand_scythe_test"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/timot/OneDrive/Documents/Hero-Realms-Lua-Scripts/AC13/ac13_hand_scythe_test.lua"
    meta.features = {}
end
