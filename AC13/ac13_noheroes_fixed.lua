require 'herorealms'
require 'decks'
require 'stdlib'
require 'timeoutai'
require 'hardai_2'
require 'aggressiveai'

-- Same as base Hero Realms game in physical. This is based on the example from WWG, but I edited it to have the correct starting decks to match the physical game.

function setupGame(g)
    standardSetup(g, {
        description = "Vanilla (No Heroes)",
        playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(), createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
        players = {
            {
                id = plid1,
                startDraw = 3,
                init = {
                    fromEnv = plid1
                },
                health = 50,
                cards = {
                    deck = {
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
                init = {
                    fromEnv = plid2
                },
                health = 50,
                cards = {
                    deck = {
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


