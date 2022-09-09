--[[
Paladin Custom Class

Starting Cards 
Longsword (from Fighter - 3 dmg)(weapon)
Spiked Mace (from Cleric - 2 dmg, 1g)(weapon)
Warhammer (2 dmg or 2 heal, both if another wapon is in play)(weapon)
Squire (2 Guard, 1g or 1 heal) (champion)
Gold x 5 (item)
Ruby x 1 (item)

Level 3 Skill
Smite (+1 dmg to a weapon in hand or play, up to double base dmg)

Level 3 Ability
Zealous Oath (Draw 1, You may stun one of your champions in play, gain combat equal to it's defense)
]]
require "herorealms"
require "decks"
require "stdlib"
require "stdcards"
require "hardai"
require "mediumai"
require "easyai"

function setupGame(g)
    registerCards(
        g,
        {
            orc_guardian_carddef()
        }
    )
    standardSetup(
        g,
        {
            description = "Custom Paladin Class",
            playerOrder = {plid1, plid2},
            ai = createHardAi(),
            randomOrder = true,
            opponents = {{plid1, plid2}},
            noTradeDeck = false,
            noFireGems = false,
            players = {
                {
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
                    avatar = "assassin",
                    health = 50,
                    maxHealth = 50,
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

function endGame(g)
end