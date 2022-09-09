require 'herorealms'
require 'decks'
require 'stdlib'
require 'timeoutai'
require 'hardai_2'
require 'aggressiveai'

-- empty template to start creating a project
-- the should be no weirdshit going on, just a standard vs ai game.

function setupGame(g)
    standardSetup(g, {
        description = "Empty template",
        playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(),  createHardAi2()),
        timeoutAi = createTimeoutAi(),
		randomOrder = true;
        opponents = { { plid1, plid2 } },
        players = {
            {
                id = plid1,
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
                init = {
                    fromEnv = plid2
                },
                cards = {
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
    meta.name = "example_double_health_without_rubies"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Program Files (x86)/Steam/steamapps/common/Hero Realms/hr_Data/hassu/example_double_health_without_rubies.lua"
     meta.features = {
}

end