require 'herorealms'
require 'decks'
require 'stdlib'
require 'timeoutai'
require 'hardai_2'
require 'aggressiveai'


-- These changes were taken from ideas shared by DaKAtSesMeow on the RR Discord.


function ranger_snake_pet_carddef()
	return createChampionDef({
		id="ranger_snake_pet",
		name="Snake Pet",
		acquireCost=0,
		health=1,
		isGuard=false,
		abilities = {
			createAbility({
				id = "snake_pet_main",
				trigger = uiTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = drawCardsEffect(1).seq(
					pushTargetedEffect({
						desc = "Stun target guard",
						min = 0,
						max = 1,
						validTargets = selectLoc(loc(oppPid, inPlayPloc)).where(isGuard()),
						targetEffect = stunTarget()
					})
				)
			})
		},
		layout = createLayout({
			name = "Snake Pet",
			art = "art/T_Angry_Skeleton",
			frame = "frames/Ranger_CardFrame",
			text = "<sprite name=\"expend\">: Draw a card. Then stun target Guard.",
			health = 1,
			isGuard = false
		})
	})
end

function ranger_headshot_carddef()
	return createSkillDef({
		id = "ranger_headshot",
		name = "Headshot",
		abilities = {
			createAbility({
				id = "headshot_main",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Headshot",
					art = "icons/ranger_headshot",
					text = "<sprite name=\"scrap\">: Stun target Champion."
				}),
				effect = pushTargetedEffect({
					desc = "Stun target Champion",
					min = 0,
					max = 1,
					validTargets = selectLoc(loc(oppPid, inPlayPloc)).where(isCardStunnable()),
					targetEffect = stunTarget()
				}),
				cost = sacrificeSelfCost
			})
		},
		layout = createLayout({
			name = "Headshot",
			art = "icons/ranger_headshot",
			text = "<sprite name=\"scrap\">: Stun target Champion."
		})
	})
end

function ranger_quickshot_carddef()
	return createSkillDef({
		id = "ranger_quickshot",
		name = "Quickshot",
		abilities = {
			createAbility({
				id = "quickshot_main",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Quickshot",
					art = "icons/ranger_quickshot",
					text = "<sprite name=\"scrap\">: Stun target Champion. Put an arrow from your discard to your hand."
				}),
				effect = pushTargetedEffect({
					desc = "Stun target Champion",
					min = 0,
					max = 1,
					validTargets = selectLoc(loc(oppPid, inPlayPloc)).where(isCardStunnable()),
					targetEffect = stunTarget()
				}).seq(pushTargetedEffect({
					desc = "Put an arrow from your discard to your hand.",
					min = 0,
					max = 1,
					validTargets = selectLoc(loc(currentPid, discardPloc)).where(isCardType(arrowType)),
					targetEffect = moveTarget(currentHandLoc)
				})),
				cost = sacrificeSelfCost
			})
		},
		layout = createLayout({
			name = "Quickshot",
			art = "icons/ranger_quickshot",
			text = "<sprite name=\"scrap\">: Stun target Champion. Put an arrow from your discard to your hand."
		})
	})
end

function ranger_twin_shot_carddef()
	return createSkillDef({
		id = "ranger_twin_shot",
		name = "Twin Shot",
		abilities = {
			createAbility({
				id = "twin_shot_main",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Twin Shot",
					art = "icons/ranger_twin_shot",
					text = "<sprite name=\"scrap\">: Stun target Champion. Draw a card."
				}),
				effect = pushTargetedEffect({
					desc = "Stun target Champion",
					min = 0,
					max = 1,
					validTargets = selectLoc(loc(oppPid, inPlayPloc)).where(isCardStunnable()),
					targetEffect = stunTarget()
				}).seq(drawCardsEffect(1)),
				cost = sacrificeSelfCost
			})
		},
		layout = createLayout({
			name = "Twin Shot",
			art = "icons/ranger_twin_shot",
			text = "<sprite name=\"scrap\">: Stun target Champion. Draw a card."
		})
	})
end

function ranger_snapshot_carddef()
	return createSkillDef({
		id = "ranger_snapshot",
		name = "Snapshot",
		abilities = {
			createAbility({
				id = "snapshot_main",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Snapshot",
					art = "icons/ranger_snapshot",
					text = "<sprite name=\"scrap\">: Stun target Champion. Put up to two arrows from your discard to your hand."
				}),
				effect = pushTargetedEffect({
					desc = "Stun target Champion",
					min = 0,
					max = 1,
					validTargets = selectLoc(loc(oppPid, inPlayPloc)).where(isCardStunnable()),
					targetEffect = stunTarget()
				}).seq(pushTargetedEffect({
					desc = "Put up to two arrows from your discard to your hand.",
					min = 0,
					max = 2,
					validTargets = selectLoc(loc(currentPid, discardPloc)).where(isCardType(arrowType)),
					targetEffect = moveTarget(currentHandLoc)
				})),
				cost = sacrificeSelfCost
			})
		},
		layout = createLayout({
			name = "Snapshot",
			art = "icons/ranger_snapshot",
			text = "<sprite name=\"scrap\">: Stun target Champion. Put up to two arrows from your discard to your hand."
		})
	})
end

function ranger_longshot_carddef()
	return createSkillDef({
		id = "ranger_longshot",
		name = "Longshot",
		abilities = {
			createAbility({
				id = "longshot_main",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Longshot",
					art = "icons/ranger_longshot",
					text = "<sprite name=\"scrap\">: Stun target Champion. Put an arrow from your discard to your hand. Draw a card."
				}),
				effect = pushTargetedEffect({
					desc = "Stun target Champion",
					min = 0,
					max = 1,
					validTargets = selectLoc(loc(oppPid, inPlayPloc)).where(isCardStunnable()),
					targetEffect = stunTarget().seq(drawCardsEffect(1))
				}).seq(pushTargetedEffect({
					desc = "Put an arrow from your discard to your hand.",
					min = 0,
					max = 1,
					validTargets = selectLoc(loc(currentPid, discardPloc)).where(isCardType(arrowType)),
					targetEffect = moveTarget(currentHandLoc)
				})),
				cost = sacrificeSelfCost
			})
		},
		layout = createLayout({
			name = "Longshot",
			art = "icons/ranger_longshot",
			text = "<sprite name=\"scrap\">: Stun target Champion. Put an arrow from your discard to your hand. Draw a card."
		})
	})
end

function ranger_triple_shot_carddef()
	return createSkillDef({
		id = "ranger_tripleshot",
		name = "Triple Shot",
		abilities = {
			createAbility({
				id = "tripleshot_main",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Triple Shot",
					art = "icons/ranger_triple_shot",
					text = "<sprite name=\"scrap\">: Stun up to two target Champions. Draw a card."
				}),
				effect = pushTargetedEffect({
					desc = "Stun up to two target Champions",
					min = 0,
					max = 2,
					validTargets = selectLoc(loc(oppPid, inPlayPloc)).where(isCardStunnable()),
					targetEffect = stunTarget().seq(drawCardsEffect(1))
				}),
				cost = sacrificeSelfCost
			})
		},
		layout = createLayout({
			name = "Triple Shot",
			art = "icons/ranger_triple_shot",
			text = "<sprite name=\"scrap\">: Stun up to two target Champions.  Draw a card."
		})
	})
end

function setupGame(g)
    standardSetup(g, {
        description = "Rebalanced ranger game",
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
    meta.name = "userkaffe_ranger_rebalance"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "D:/HRLS/Hero-Realms-Lua-Scripts/Community/userkaffe_ranger_rebalance.lua"
     meta.features = {
}

end