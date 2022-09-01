require 'herorealms'
require 'decks'
require 'stdlib'
require 'timeoutai'
require 'hardai_2'
require 'aggressiveai'

-- this script allows you to play as 'witch' custom class

function siphon_life_def()
	return createSkillDef({
		id = "siphon_life",
		name = "Siphon Life",
		abilities = {
			createAbility({
				id = "siphonLifeActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Siphon Life",
					art = "art/T_The_Rot",
					text = "<size=150%><sprite name=\"expend\">,<size=130%><sprite name=\"gold_2\">:<br><size=80%>You gain 1<sprite name=\"health\"> and your opponent loses 1<sprite name=\"health\">.<br>This also affects maximum health."
				}),
				effect = gainMaxHealthEffect(currentPid, 1).seq(gainHealthEffect(1)).seq(hitOpponentEffect(1)).seq(gainMaxHealthEffect(oppPid, -1)),
				cost = goldCost(2)
			})
		},
		layout = createLayout({
			name = "Siphon Life",
			art = "art/T_The_Rot",
			text = "<size=150%><sprite name=\"expend\">,<size=130%><sprite name=\"gold_2\">:<br><size=80%>You gain 1<sprite name=\"health\"> and your opponent loses 1<sprite name=\"health\">.<br>This also affects maximum health."
		}),
		layoutPath= "art/T_The_Rot"
	})
end		

function piercing_screech_def()
	return createSkillDef({
		id = "piercing_screech",
		name = "Piercing Screech",
		abilities = {
			createAbility({
				id = "piercingScreechActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Piercing Screech",
					art = "art/T_Flesh_Ripper",
					text = "<size=150%><sprite name=\"scrap\">:<br><size=120%>Target opponent discards two cards."
				}),
				effect = oppDiscardEffect(2),
				cost = sacrificeSelfCost
			})
		},
		layout = createLayout({
			name = "Piercing Screech",
			art = "art/T_Flesh_Ripper",
			text = "<size=150%><sprite name=\"scrap\">:<br><size=120%>Target opponent discards two cards."
		}),
		layoutPath= "art/T_Flesh_Ripper"
	})
end	

function witch_flash_freeze_carddef()
	local cardLayout = createLayout({
		name = "Flash Freeze",
		art = "icons/ranger_fast_track",
		frame = "frames/Wizard_CardFrame",
		text = "<size=180%><sprite name=\"combat_1\"><size=100%><br>Expend target champion."
	})
	
	return createActionDef({
		id = "witch_flash_freeze",
		name = "Flash Freeze",
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "flashFreezeMain",
				trigger = autoTrigger,
				effect = gainCombatEffect(1).seq(pushTargetedEffect({
					desc = "Expend target Champion",
					min = 0,
					max = 1,
					validTargets = selectLoc(loc(oppPid, inPlayPloc)).where(isCardStunnable()),
					targetEffect = expendTarget()
				}))
			})
		}
	})
end

function witch_cauldron_carddef()
	local cardLayout = createLayout({
		name = "Witch's Cauldron",
		art = "art/T_Maurader",
		frame = "frames/Wizard_CardFrame",
		text = "<size=150%><sprite name=\"gold_1\"> <sprite name=\"health_2\"><size=80%><br>You may stun one of your champions. If you do, draw a card."
	})
	
	return createActionDef({
		id = "witch_cauldron",
		name = "Witch's Cauldron",
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "cauldronMain",
				trigger = autoTrigger,
				effect = gainGoldEffect(1).seq(gainHealthEffect(2))
			}),
			createAbility({
				id = "cauldronStun",
				trigger = uiTrigger,
				effect = pushTargetedEffect({
					desc = "Stun a friendly champion.",
					min = 1,
					max = 1,
					validTargets = selectLoc(loc(currentPid, inPlayPloc)),
					targetEffect = stunTarget().seq(drawCardsEffect(1))
				}),
				check = selectLoc(currentInPlayLoc).count().gte(1)
			})
		}
	})
end

function setupGame(g)
	registerCards(g, {
		witch_flash_freeze_carddef(),
		witch_cauldron_carddef(),
		siphon_life_def(),
		piercing_screech_def()
	})

    standardSetup(g, {
        description = "Witch Class game. Created by Userkaffe.",
        playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(),  createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
        players = {
            {
                id = plid1,
                startDraw = 3,
                name = "Witch",
                avatar="assassin",
                health = 45,
                cards = {
					deck = {
                      { qty=2, card=witch_flash_freeze_carddef() },
					  { qty=1, card=wizard_cat_familiar_carddef() },
					  { qty=1, card=cleric_everburning_candle_carddef() },
					  { qty=1, card=witch_cauldron_carddef() },
					  { qty=5, card=gold_carddef() }
					},
					skills = {
						{ qty=1, card=siphon_life_def() },
						{ qty=1, card=piercing_screech_def() }
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

-- Created by Userkaffe



function setupMeta(meta)
    meta.name = "userkaffe_witch_class"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "D:/HRLS/Hero-Realms-Lua-Scripts/Community/userkaffe_witch_class.lua"
     meta.features = {
}

end