-- This is the base script we will edit for the stream.  You can write this from scratch, or use this template for your own game. We will modify this and remove a couple things for our game.

require 'herorealms'
require 'decks'
require 'stdlib'
require 'stdcards'
require 'hardai'
require 'mediumai'
require 'easyai'

-- Add custom cards here.

function setupGame(g)
    registerCards(g, {
     -- Add custom cards here.    
    })

    standardSetup(g, {
        description = "Custom DblDubz Stream Game",
        playerOrder = { plid1, plid2 },
        ai = createHardAi(),
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
                        -- Replace these cards with the starter card for the class Goldx6, follower_a, follwer_b, prayer beads, and ruby. 
                        { qty = 2, card = dagger_carddef() },
                        { qty = 8, card = gold_carddef() },
                    },
                    --[[ Add starting skill, ability and armor here.  Commented out for now. 
                    skills = {

                    },]]
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
                        -- Replace these with AI starting cards
                        { qty = 2, card = dagger_carddef() },
                        { qty = 8, card = gold_carddef() },
                    },
                                        --[[ Add starting skill, ability and armor here.  Commented out for now. 
                    skills = {

                    },]]
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

function setupMeta(meta)
    meta.name = "DblDubz_stream"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "Y:/Projects/hero-realms-lua-scripts/snippets/DblDubz_stream.lua"
     meta.features = {
}

end