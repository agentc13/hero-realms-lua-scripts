require 'herorealms'
require 'decks'
require 'stdlib'
require 'timeoutai'
require 'hardai_2'
require 'aggressiveai'

function doubleHealthBuffDef() --given to the starting player, triggers at the start of the game
    local ef = gainMaxHealthEffect(currentPid, getPlayerMaxHealth(currentPid))
        .seq(healPlayerEffect(currentPid, getPlayerMaxHealth(currentPid)))
        .seq(gainMaxHealthEffect(oppPid, getPlayerMaxHealth(oppPid)))
        .seq(healPlayerEffect(oppPid, getPlayerMaxHealth(oppPid)))
        .seq(sacrificeSelf())

    return createGlobalBuff({
        id="double_health_buff",
        name = "Double health",
        abilities = {
            createAbility({
                id="double_health_effect",
                trigger = startOfGameTrigger,
                effect = ef
            })
        }
    })
end

function setupGame(g)
    standardSetup(g, {
        description = "Online double health game",
        playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(),  createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
        players = {
            {
                id = plid1,
                startDraw = 3,
                init = {
                    fromEnv = plid1
                },
                cards = {
                    buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        doubleHealthBuffDef(),
                        discardCardsAtTurnStartDef(),
                        fatigueCount(40, 1, "FatigueP1")
                    }
                }
            },
            {
                id = plid2,
                startDraw = 5,
                init = {
                    fromEnv = plid2
                },
                cards = {
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