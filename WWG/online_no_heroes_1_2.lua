require 'herorealms'
require 'decks'
require 'stdlib'
require 'timeoutai'
require 'hardai_2'
require 'aggressiveai'

function setupGame(g)
    standardSetup(g, {
        description = "Custom no heroes game",
        playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(),  createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
        players = {
            {
                id = plid1,
                startDraw = 3,
                name = "Player 1",
                avatar="assassin",
                health = 50,
                cards = {
                    deck = { -- orc deck still in progress
                        { qty=2, card=dagger_carddef() },
                        { qty=8, card=gold_carddef() },
                    },
                    buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
                        fatigueCount(40, 1, "FatigueP1")
                    }
                }
            },
            {
                id = plid2,
                startDraw = 5,
                name = "Player 2",
                avatar="assassin",
                health = 50,
                cards = {
                    deck = {
                        { qty=2, card=dagger_carddef() },
                        { qty=8, card=gold_carddef() },
                    },
                    buffs = {
                        drawCardsCountAtTurnEndDef(5),
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
