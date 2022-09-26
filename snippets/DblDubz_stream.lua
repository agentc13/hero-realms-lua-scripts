require 'herorealms'
require 'decks'
require 'stdlib'
require 'stdcards'
require 'hardai'
require 'mediumai'
require 'easyai'



function setupGame(g)
    registerCards(g, {
        
    })

    standardSetup(g, {
        description = "Custom DblDubz Stream Game",
        playerOrder = { plid1, plid2 },
        ai = createHardAi(),
        randomOrder = true,
        opponents = { { plid1, plid2 } },
        noTradeDeck = false,
        noFireGems = false,
        players = {
            {
                id = plid1,
                name = "DeebleDoobz",
                avatar = "wolf_shaman",
                health = 55,
                maxHealth = 55,
                cards = {
                    deck = {
                        { qty = 2, card = dagger_carddef() },
                        { qty = 8, card = gold_carddef() },
                    },
                    buffs = {
                        drawCardsAtTurnEndDef(),
                        discardCardsAtTurnStartDef(),
                        fatigueCount(40, 1, "FatigueP2")
                    }
                }
            },
            {
                id = plid2,
                isAi = true,
                name = "AC13",
                avatar = "the_wolf_tribe",
                health = 55,
                maxHealth = 55,
                cards = {
                    deck = {
                        { qty = 2, card = dagger_carddef() },
                        { qty = 8, card = gold_carddef() },
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

-- more info on this later
function endGame(g)
end