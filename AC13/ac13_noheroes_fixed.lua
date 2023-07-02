require "herorealms"
require "decks"
require "stdlib"
require "timeoutai"
require "hardai_2"
require "aggressiveai"

-- Same as base Hero Realms game in physical. This is based on the example from WWG, but I edited it to have the correct starting decks to match the physical game.

function setupGame(g)
    standardSetup(
        g,
        {
            description = "No Heroes",
            playerOrder = {plid1, plid2},
            ai = ai.CreateKillSwitchAi(createAggressiveAI(), createHardAi2()),
            timeoutAi = createTimeoutAi(),
            opponents = {{plid1, plid2}},
            players = {
                {
                    id = plid1,
                    startDraw = 3,
                    name = "Player 1",
                    avatar = "ogre",
                    health = 50,
                    maxHealth=300,
                    cards = {
                        deck = {
                            {qty = 1, card = dagger_carddef()},
                            {qty = 1, card = shortsword_carddef()},
                            {qty = 1, card = ruby_carddef()},
                            {qty = 7, card = gold_carddef()}
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
                    isAi = true,
                    startDraw = 5,
                    name = "Player 2",
                    avatar = "skeleton",
                    health = 50,
                    maxHealth=300,
                    cards = {
                        deck = {
                            {qty = 1, card = dagger_carddef()},
                            {qty = 1, card = shortsword_carddef()},
                            {qty = 1, card = ruby_carddef()},
                            {qty = 7, card = gold_carddef()}
                        },
                        buffs = {
                            drawCardsCountAtTurnEndDef(5),
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