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
		cardTypeLabel = "Skill",
		types = { skillType },
        abilities = {
			createAbility({
				id = "siphonLifeActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Siphon Life",
					art = "art/T_Life_Force",
					text = "<size=400%><line-height=0%><voffset=-0.6em> <pos=-95%><sprite name=\"expend_2\"></size><line-height=100%> \n <voffset=1.8em><size=90%><pos=10%>You gain 1<sprite name=\"health\"> and\n<pos=10%>target opponent\n<pos=10%>loses 1<sprite name=\"health\">.\n<pos=10%>This also affects\n<pos=10%>maximum health."
				}),
				effect = gainMaxHealthEffect(currentPid, 1).seq(gainHealthEffect(1)).seq(hitOpponentEffect(1)).seq(gainMaxHealthEffect(oppPid, -1)),
				cost = goldCost(2)
			})
		},
		layout = createLayout({
			name = "Siphon Life",
			art = "art/T_Life_Force",
			text = "<size=400%><line-height=0%><voffset=-0.6em> <pos=-95%><sprite name=\"expend_2\"></size><line-height=100%> \n <voffset=1.8em><size=90%><pos=10%>You gain 1<sprite name=\"health\"> and\n<pos=10%>target opponent\n<pos=10%>loses 1<sprite name=\"health\">.\n<pos=10%>This also affects\n<pos=10%>maximum health."
		}),
		layoutPath= "art/T_Life_Force"
	})
end		

function piercing_screech_def()
	return createDef({
		id = "piercing_screech",
		name = "Piercing Screech",
		acquireCost = 0,
		cardTypeLabel = "Ability",
		playLocation = skillsPloc,
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "piercingScreechActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Piercing Screech",
					art = "art/T_Flesh_Ripper",
					text = "<voffset=1em><space=-1.5em><voffset=-1.3em><size=300%><sprite name=\"scrap\"></size></voffset><pos=30%> <voffset=1.0em><line-height=40><space=-3.0em><space=1.0em>Target opponent\n<space=1.0em>discards\n<space=1.0em>two cards.</voffset></voffset>"
				}),
				effect = oppDiscardEffect(2),
				cost = sacrificeSelfCost
			})
		},
		layout = createLayout({
			name = "Piercing Screech",
			art = "art/T_Flesh_Ripper",
			text = "<voffset=1em><space=-1.5em><voffset=-1.3em><size=300%><sprite name=\"scrap\"></size></voffset><pos=30%> <voffset=1.0em><line-height=40><space=-3.0em><space=1.0em>Target opponent\n<space=1.0em>discards\n<space=1.0em>two cards.</voffset></voffset>"
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
					min = 1,
					max = 1,
					validTargets = selectLoc(loc(oppPid, inPlayPloc)).where(isCardStunnable()).where(isCardExpended().invert()),
					targetEffect = expendTarget()
				}))
			})
		}
	})
end

function witch_cauldron_carddef()
	local cardLayout = createLayout({
		name = "Witch's Cauldron",
		art = "art/T_Confused_Apparition",
		frame = "frames/HR_CardFrame_Item_Generic",
		cardTypeLabel = "Item",
		text = "<size=150%><sprite name=\"gold_1\"> <sprite name=\"health_3\"><size=80%><br>You may stun one of your champions. If you do, draw a card."
	})
	
	return createDef({
		id = "witch_cauldron",
		name = "Witch's Cauldron",
		acquireCost = 0,
		cardTypeLabel = "Item",
		types = { itemType },
		layout = cardLayout,
		playLocation = castPloc,
		abilities = {
			createAbility({
				id = "cauldronMain",
				trigger = autoTrigger,
				effect = gainGoldEffect(1).seq(gainHealthEffect(3))
			}),
			createAbility({
				id = "cauldronStun",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = cardLayout,
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
                avatar="chanting_cultist",
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
						drawCardsCountAtTurnEndDef(5),
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

-- Created by Userkaffe




function setupMeta(meta)
    meta.name = "userkaffe_witch_class"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/xTheC/Desktop/Git Repositories/hero-realms-lua-scripts/Userkaffe/finished_mods/userkaffe_witch_class.lua"
     meta.features = {
}

end