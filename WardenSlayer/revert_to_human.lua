require 'herorealms'
require 'decks'
require 'stdlib'
require 'timeoutai'
require 'hardai_2'
require 'aggressiveai'

-- Created by WardenSlayer
-- this script is a template for how to remove all ancestry content from a character at the start of the game.

--Aliases
--=======================================================================================================
local function revertToHuman()
    local ef = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardType(elfType)).count().gte(1),
                    gainMaxHealthEffect(currentPid, 8),
                    nullEffect()
                ).seq(ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardType(orcType)).count().gte(1),
                        gainMaxHealthEffect(currentPid, 4),
                        nullEffect()
                        )
                ).seq(ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardType(ogreType)).count().gte(1),
                        gainMaxHealthEffect(currentPid, -10),
                        nullEffect()
                        )
                ).seq(ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardType(dwarfType)).count().gte(1),
                        gainMaxHealthEffect(currentPid, -6),
                        nullEffect()
                        )
                ).seq(ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardType(smallfolkType)).count().gte(1),
                        gainMaxHealthEffect(currentPid, 15),
                        nullEffect()
                        )
                ).seq(ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardType(halfDemonType)).count().gte(1),
                        gainMaxHealthEffect(currentPid, -5),
                        nullEffect()
                        )
                ).seq(healPlayerEffect(currentPid, getPlayerMaxHealth(currentPid)))
    local ef2 = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, skillsPloc))
                    .union(selectLoc(loc(currentPid, deckPloc)))
                    .union(selectLoc(loc(currentPid, handPloc)))
                    .union(selectLoc(loc(currentPid, buffsPloc)))
                        .where(isCardType(ogreType)
                        .Or(isCardType(orcType))
                        .Or(isCardType(elfType)
                        .Or(isCardType(dwarfType)
                        .Or(isCardType(smallfolkType))
                        --Hide is a hidden buff so you need to handle it seperately
                        .Or(isCardName("smallfolk_hide_buff"))
                        .Or(isCardType(halfDemonType))))))
        --
        return createGlobalBuff({
            id="revert_to_human",
            name = "Revert to Human",
            abilities = {
                createAbility({
                    id="revert_health",
                    trigger = autoTrigger,
                    effect = ef,
                }),
                createAbility({
                    id="revert_loadout",
                    trigger = autoTrigger,
                    effect = ef2,
                }),
                createAbility({
                    id="cleanup_aside",
                    trigger = endOfTurnTrigger,
                    effect = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc))).seq(gainHealthEffect(999)),
                    cost = sacrificeSelfCost
                }),
            },     
        })
    end

function setupGame(g)
	registerCards(g, {
	})

    standardSetup(g, {
        description = "Revert to Humans!<br>Created by WardenSlayer.",
        playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(),  createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
        players = {
            {
                id = plid1,
                --isAi = true,
                startDraw = 0,
				init = {
                    fromEnv = plid1
                },
                cards = {
					buffs = {
                        revertToHuman(),
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
						fatigueCount(40, 1, "FatigueP1"),
					}
                }
            },
            {
                id = plid2,
                --isAi = true,
                startDraw = 0,
				init = {
                    fromEnv = plid2
                },
                cards = {
					buffs = {
                        revertToHuman(),
						drawCardsCountAtTurnEndDef(5),
						discardCardsAtTurnStartDef(),
						fatigueCount(40, 1, "FatigueP2"),
					}
                }
            },            
        }
    })
end

function endGame(g)
end

function setupMeta(meta)
    meta.name = "humans"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/xTheC/Desktop/Git Repositories/hero-realms-lua-scripts/WardenSlayer/Ancestries/revert_to_human.lua"
     meta.features = {
}

end

