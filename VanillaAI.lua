require 'herorealms'
require 'decks'
require 'stdlib'
require 'timeoutai'
require 'hardai_2'
require 'aggressiveai'

-- simple script with hardcoded decks and no skills/abilities

function setupGame(g)
    standardSetup(g, {
        description = "Custom no heroes game",
        playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(), createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
        players = {
            {
                id = plid1,
                startDraw = 3,
                name = "Player 1",
                avatar = "assassin",
                health = 50,
                cards = {
                    deck = { -- orc deck still in progress
                        { qty = 1, card = dagger_carddef() },
                        { qty = 1, card = shortsword_carddef() },
                        { qty = 1, card = ruby_carddef() },
                        { qty = 7, card = gold_carddef() },
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
                avatar = "assassin",
                health = 50,
                cards = {
                    deck = { -- orc deck still in progress
                        { qty = 1, card = dagger_carddef() },
                        { qty = 1, card = shortsword_carddef() },
                        { qty = 1, card = ruby_carddef() },
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
    meta.name = "VanillaAI"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/timot/HR scripts/VanillaAI.lua"
     meta.features = {
}

end