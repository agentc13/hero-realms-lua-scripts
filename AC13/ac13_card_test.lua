require "herorealms"
require "decks"
require "stdlib"
require "stdcards"
require "hardai"
require "mediumai"
require "easyai"

function paladin_crusader_carddef()
    return createChampionDef(
        {
            id = "paladin_Crusader",
            name = "Crusader",
            acquireCost = 0,
            health = 2,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "Crusader_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = pushChoiceEffect(
                            {
                                choices = {
                                    {
                                        effect = gainGoldEffect(1),
                                        layout = layoutCard(
                                            {
                                                title = "Crusader",
                                                art = "avatars/man_at_arms",
                                                text = ("{1 gold}")
                                            }
                                        ),
                                        tags = {gainGoldTag}
                                    },
                                    {
                                        effect = gainHealthEffect(1),
                                        layout = layoutCard(
                                            {
                                                title = "Crusader",
                                                art = "avatars/man_at_arms",
                                                text = ("{1 health}")
                                            }
                                        ),
                                        tags = {gainHealthTag}
                                    }
                                }
                            }
                        )
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Crusader",
                    art = "avatars/man_at_arms",
                    frame = "frames/Cleric_CardFrame",
                    text = "<size=250%><pos=-5%><sprite name=\"expend\"></pos></size><size=175%><pos=25%><voffset=.2em><sprite name=\"combat_1\"> or <sprite name=\"health_1\"></size></voffset>",
                    health = 2,
                    isGuard = true
                }
            )
        }
    )
end


function setupGame(g)
    standardSetup(
        g,
        {
            description = "Card Test", -- script description - displayed in in-game menu
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
                            paladin_crusader_carddef()
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
    meta.name = "ac13_card_test"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/timot/OneDrive/Documents/Hero-Realms-Lua-Scripts/AC13/ac13_card_test.lua"
     meta.features = {
}

end