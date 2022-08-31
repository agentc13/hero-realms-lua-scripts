require 'herorealms'
require 'decks'
require 'stdlib'
require 'timeoutai'
require 'hardai_2'
require 'aggressiveai'

-- Same as base Hero Realms game in physical. This is based on the example from WWG, but I edited it to have the correct starting decks to match the physical game.

function setupGame(g)
    standardSetup(g, {
        description = "No Heroes",
        playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(), createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
        players = {
            {
                id = plid1,
                startDraw = 3,
                name = "Player 1",
                avatar = "avatars/cristov_s_recruits",
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
                name = "Player 2",
                avatar = "avatars/origins_shoulder_bash",
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


function setupMeta(meta)
    meta.name = "ac13_noheroes_fixed"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/timot/OneDrive/Documents/Hero-Realms-Lua-Scripts/AC13/ac13_noheroes_fixed.lua"
     meta.features = {
}

end