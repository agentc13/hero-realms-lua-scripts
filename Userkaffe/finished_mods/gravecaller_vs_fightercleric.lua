require 'herorealms'
require 'decks'
require 'stdlib'
require 'timeoutai'
require 'hardai_2'
require 'aggressiveai'

-- utilities

function sacrificeCardsEffect(num)
	return pushTargetedEffect({
		desc = "Sacrifice up to " .. tostring(num) .. " cards from your hand or discard pile.",
		min = 0,
		max = num,
		validTargets = selectLoc(currentHandLoc).union(selectLoc(currentDiscardLoc)),
		targetEffect = moveTarget(12)
	})
end

-- end utilities
-- re-implement cards with sacrifice effects

function fire_gem_carddef()
	return createDef({
		id = "fire_gem",
		name = "Fire Gem",
		acquireCost = 2,
		types = { itemType, gemType },
		layout = loadLayoutTexture("Textures/fire_gem"),
		abilities = {
			createAbility({
				id = "fireGemMain",
				trigger = autoTrigger,
				effect = gainGoldEffect(2)
			}),
			createAbility({
				id = "fireGemScrap",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = loadLayoutTexture("Textures/fire_gem"),
				effect = gainCombatEffect(3).seq(moveTarget(12).apply(selectSource()))
			})
		},
		cardEffectAbilities = {},
		cardTypeLabel = "Item",
		playLocation = castPloc
	})
end

function word_of_power_carddef()
	return createActionDef({
		id = "word_of_power",
		name = "Word of Power",
		acquireCost = 6,
		layout = loadLayoutTexture("Textures/word_of_power"),
		factions = {imperialFaction},
		abilities = {
			createAbility({
				id = "wopMain",
				trigger = autoTrigger,
				effect = drawCardsEffect(2)
			}),
			createAbility({
				id = "wop_ally",
				allyFactions = {imperialFaction},
				effect = gainHealthEffect(5),
				trigger = autoTrigger,
				tags = {allyTag}
			}),
			createAbility({
				id = "wop_scrap",
				effect = gainCombatEffect(5).seq(moveTarget(12).apply(selectSource())),
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = loadLayoutTexture("Textures/word_of_power")
			})
		}
	})
end

function fire_bomb_carddef()
	return createActionDef({
		id = "fire_bomb",
		name = "Fire Bomb",
		acquireCost = 8,
		layout = loadLayoutTexture("Textures/fire_bomb"),
		factions = {guildFaction},
		abilities = {
			createAbility({
				id = "fbMain",
				trigger = autoTrigger,
				effect = gainCombatEffect(8).seq(pushTargetedEffect({
					desc = "Stun target Champion.",
					min = 0,
					max = 1,
					validTargets = selectLoc(loc(oppPid, inPlayPloc)).where(isCardStunnable()),
					targetEffect = stunTarget().seq(drawCardsEffect(1))
				}))
			}),
			createAbility({
				id = "fbSac",
				trigger = uiTrigger,
				effect = gainCombatEffect(5).seq(moveTarget(12).apply(selectSource())),
				promptType = showPrompt,
				layout = loadLayoutTexture("Textures/fire_bomb")
			})
		}
	})
end

function nature_s_bounty_carddef()
	return createActionDef({
		id = "nature_s_bounty",
		name = "Nature's Bounty",
		acquireCost = 4,
		layout = loadLayoutTexture("Textures/nature_s_bounty"),
		factions = {wildFaction},
		abilities = {
			createAbility({
				id = "naturesBountyMain",
				trigger = autoTrigger,
				effect = gainGoldEffect(4)
			}),
			createAbility({
				id = "naturesBountyAlly",
				trigger = autoTrigger,
				allyFactions = {wildFaction},
				effect = oppDiscardEffect(1)
			}),
			createAbility({
				id = "naturesBountySacrifice",
				trigger = uiTrigger,
				effect = gainCombatEffect(4).seq(moveTarget(12).apply(selectSource())),
				promptType = showPrompt,
				layout = loadLayoutTexture("Textures/nature_s_bounty")
			})
		}
	})
end

function wolf_form_carddef()
	return createActionDef({
		id = "wolf_form",
		name = "Wolf Form",
		acquireCost = 5,
		layout = loadLayoutTexture("Textures/wolf_form"),
		factions = {wildFaction},
		abilities = {
			createAbility({
				id = "wolfFormMain",
				trigger = autoTrigger,
				effect = gainCombatEffect(8).seq(oppDiscardEffect(1))
			}),
			createAbility({
				id = "wolfFormSacrifice",
				trigger = uiTrigger,
				effect = oppDiscardEffect(1).seq(moveTarget(12).apply(selectSource())),
				promptType = showPrompt,
				layout = loadLayoutTexture("Textures/wolf_form")
			})
		}
	})
end

function death_touch_carddef()
	return createActionDef({
		id = "death_touch",
		name = "Death Touch",
		acquireCost = 1,
		layout = loadLayoutTexture("Textures/death_touch"),
		factions = {necrosFaction},
		abilities = {
			createAbility({
				id = "deathTouchMain",
				trigger = autoTrigger,
				effect = gainCombatEffect(2).seq(sacrificeCardsEffect(1))
			}),
			createAbility({
				id = "deathTouchAlly",
				allyFactions = {necrosFaction},
				trigger = autoTrigger,
				effect = gainCombatEffect(2)
			})
		}
	})
end

function the_rot_carddef()
	return createActionDef({
		id = "the_rot",
		name = "The Rot",
		acquireCost = 3,
		layout = loadLayoutTexture("Textures/the_rot"),
		factions = {necrosFaction},
		abilities = {
			createAbility({
				id = "theRotMain",
				trigger = autoTrigger,
				effect = gainCombatEffect(4).seq(sacrificeCardsEffect(1))
			}),
			createAbility({
				id = "rotAlly",
				allyFactions = {necrosFaction},
				trigger = uiTrigger,
				effect = gainCombatEffect(3)
			})
		}
	})
end

function influence_carddef()
	return createActionDef({
		id = "influence",
		name = "Influence",
		acquireCost = 2,
		layout = loadLayoutTexture("Textures/influence"),
		factions = {necrosFaction},
		abilities = {
			createAbility({
				id = "influenceMain",
				trigger = autoTrigger,
				effect = gainGoldEffect(3)
			}),
			createAbility({
				id = "influenceSacrifice",
				trigger = uiTrigger,
				effect = gainCombatEffect(3).seq(moveTarget(12).apply(selectSource())),
				promptType = showPrompt,
				layout = loadLayoutTexture("Textures/influence")
			})
		}
	})
end

function lys__the_unseen_carddef()
	return createChampionDef({
		id = "lys__the_unseen",
		name = "Lys the Unseen",
		acquireCost = 6,
		health = 5,
		isGuard = true,
		layout = loadLayoutTexture("Textures/lys__the_unseen"),
		factions = {necrosFaction},
		abilities = {
			createAbility({
				id = "lysMain",
				trigger = uiTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = gainCombatEffect(2).seq(pushTargetedEffect({
					desc = "Sacrifice a card from your hand or discard pile. If you do, gain 2 combat.",
					min = 0,
					max = 1,
					validTargets = selectLoc(currentHandLoc).union(selectLoc(currentDiscardLoc)),
					targetEffect = moveTarget(12).seq(gainCombatEffect(selectTargets().count().multiply(2)))
				}))
			})
		}
	})
end

function krythos__master_vampire_carddef()
	return createChampionDef({
		id = "krythos__master_vampire",
		name = "Krythos, Master Vampire",
		acquireCost = 7,
		health = 6,
		isGuard = false,
		layout = loadLayoutTexture("Textures/krythos__master_vampire"),
		factions = {necrosFaction},
		abilities = {
			createAbility({
				id = "krythosMain",
				trigger = uiTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = gainCombatEffect(3).seq(pushTargetedEffect({
					desc = "Sacrifice a card from your hand or discard pile. If you do, gain 3 combat.",
					min = 0,
					max = 1,
					validTargets = selectLoc(currentHandLoc).union(selectLoc(currentDiscardLoc)),
					targetEffect = moveTarget(12).seq(gainCombatEffect(selectTargets().count().multiply(3)))
				}))
			})
		}
	})
end

function tyrannor__the_devourer_carddef()
	return createChampionDef({
		id = "tyrannor__the_devourer",
		name = "Tyrannor, the Devourer",
		acquireCost = 8,
		health = 6,
		isGuard = true,
		layout = loadLayoutTexture("Textures/tyrannor__the_devourer"),
		factions = {necrosFaction},
		abilities = {
			createAbility({
				id = "tyrannorMain",
				trigger = uiTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = gainCombatEffect(4).seq(sacrificeCardsEffect(2))
			}),
			createAbility({
				id = "tyrannorAlly",
				trigger = uiTrigger,
				allyFactions = {necrosFaction},
				effect = drawCardsEffect(1)
			})
		}
	})
end

function dark_reward_carddef()
	return createActionDef({
		id = "dark_reward",
		name = "Dark Reward",
		acquireCost = 5,
		layout = loadLayoutTexture("Textures/dark_reward"),
		factions = {necrosFaction},
		abilities = {
			createAbility({
				id = "darkRewardMain",
				trigger = autoTrigger,
				effect = gainGoldEffect(3).seq(sacrificeCardsEffect(1))
			}),
			createAbility({
				id = "darkRewardAlly",
				allyFactions = {necrosFaction},
				trigger = autoTrigger,
				effect = gainCombatEffect(6)
			})
		}
	})
end

function life_drain_carddef()
	return createActionDef({
		id = "life_drain",
		name = "Life Drain",
		acquireCost = 6,
		layout = loadLayoutTexture("Textures/life_drain"),
		factions = {necrosFaction},
		abilities = {
			createAbility({
				id = "lifeDrainMain",
				trigger = autoTrigger,
				effect = gainCombatEffect(8).seq(sacrificeCardsEffect(1))
			}),
			createAbility({
				id = "lifeDrainAlly",
				allyFactions = {necrosFaction},
				trigger = uiTrigger,
				effect = drawCardsEffect(1)
			})
		}
	})
end

function fighter_jagged_spear_carddef()
	local faceLayout = layoutCard({
		title = "Jagged Spear",
		art = "icons/fighter_shoulder_bash_OLD",
		text = "Deal 4 damage to target opponent."
	})
	local removalLayout = layoutCard({
		title = "Jagged Spear",
		art = "icons/fighter_shoulder_bash_OLD",
		text = "Deal 4 damage to target non-Guard."
	})

	return createActionDef({
		id = "fighter_jagged_spear",
		name = "Jagged Spear",
		acquireCost = 0,
		layout = loadLayoutTexture("Textures/fighter_jagged_spear"),
		factions = {necrosFaction},
		abilities = {
			createAbility({
				id = "jaggedMain",
				trigger = autoTrigger,
				effect = gainCombatEffect(4)
			}),
			createAbility({
				id = "jaggedSacrifice",
				trigger = uiTrigger,
				effect = pushChoiceEffect({
					choices = {
						{
							effect = hitOpponentEffect(4).seq(moveTarget(12).apply(selectSource())),
							layout = faceLayout
						},
						{
							effect = pushTargetedEffect({
								desc = "Deal 4 damage to target non-guard.",
								min = 1,
								max = 1,
								validTargets = selectLoc(loc(oppPid, inPlayPloc)).where(isGuard().invert()),
								targetEffect = damageTarget(4).seq(moveTarget(12).apply(selectSource()))
							}),
							layout = removalLayout
						}
					}
				})
			})
		}
	})
end

--TODO: override silverskull amulet
--TODO: override thief's sacrificial dagger

-- end of re-implements
-- custom skills and cards
function burial_rites_def()
	return createSkillDef({
		id = "burial_rites",
		name = "Burial Rites",
		cardTypeLabel = "Skill",
		types = { skillType },
        abilities = {
			createAbility({
				id = "burialRitesActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Burial Rites",
					art = "art/T_Weak_Skeleton",
					text = "<size=400%><line-height=0%><voffset=-0.6em> <pos=-95%><sprite name=\"expend_2\"></size><line-height=100%> \n <voffset=1.8em><size=120%><pos=10%><sprite name=\"health_2\">\n<size=90%>Sacrifice a card\nin your hand\n or discard pile."
				}),
				effect = gainHealthEffect(2).seq(sacrificeCardsEffect(1)),
				cost = goldCost(2)
			})
		},
		layout = createLayout({
			name = "Burial Rites",
			art = "art/T_Weak_Skeleton",
			text = "<size=400%><line-height=0%><voffset=-0.6em> <pos=-95%><sprite name=\"expend_2\"></size><line-height=100%> \n <voffset=1.8em><size=120%><pos=10%><sprite name=\"health_2\">\n<size=90%>Sacrifice a card\nin your hand\n or discard pile."
		}),
		layoutPath= "art/T_Weak_Skeleton"
	})
end

function bless_and_bash_def()
	return createSkillDef({
		id = "bless_and_bash",
		name = "Bless & Bash",
		cardTypeLabel = "Skill",
		types = { skillType },
        abilities = {
			createAbility({
				id = "blessAndBashActivate",
				trigger = autoTrigger, --The AI does not know how to use the ability, so I'll force their hand.
				--promptType = showPrompt, --The AI does not need this :D
				layout = createLayout({
					name = "Bless & Bash",
					art = "icons/fighter_knock_down_OLD",
					text = "<size=400%><line-height=0%><voffset=-0.6em> <pos=-95%><sprite name=\"expend_2\"></size><line-height=100%> \n <voffset=1.8em><size=120%><pos=10%><sprite name=\"combat_2\"> <sprite name=\"health_3\">\n<size=90%>Your champions\ngain +1<sprite name=\"shield\"> until\nyour next turn."
				}),
				effect = gainCombatEffect(2).seq(gainHealthEffect(3)).seq(grantHealthTarget(1, {startOfOwnerTurnExpiry, leavesPlayExpiry}).apply(selectLoc(currentInPlayLoc))),
				cost = goldCost(2),
				check = selectLoc(currentInPlayLoc).count().gte(3).Or(getPlayerHealth(oppPid).lte(2)) -- Stop the AI from wasting their money unnecessarily
			})
		},
		layout = createLayout({
			name = "Bless & Bash",
			art = "icons/fighter_knock_down_OLD",
			text = "<size=400%><line-height=0%><voffset=-0.6em> <pos=-95%><sprite name=\"expend_2\"></size><line-height=100%> \n <voffset=1.8em><size=120%><pos=10%><sprite name=\"combat_2\"> <sprite name=\"health_3\">\n<size=90%>Your champions\ngain +1<sprite name=\"shield\"> until\nyour next turn."
		}),
		layoutPath= "icons/fighter_knock_down_OLD"
	})
end

function smashing_resurrection_def()
	return createDef({
		id = "smashing_resurrection",
		name = "Smashing Resurrection",
		acquireCost = 0,
		cardTypeLabel = "Ability",
		playLocation = skillsPloc,
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "smashingResActivate",
				trigger = autoTrigger, -- Forces the AI to use the ability
				--promptType = showPrompt,
				layout = createLayout({
					name = "Smashing Resurrection",
					art = "icons/fighter_knock_back",
			text = "<voffset=1em><space=-11.0em><voffset=-4.0em><size=200%><sprite name=\"scrap\"></size></voffset><pos=30%> <voffset=1.0em><line-height=40><space=-5.0em><space=1.0em><size=160%><line-height=100%>\n<sprite name=\"combat_8\"><size=80%><line-height=100%>\nReturn a champion\nthat was stunned\nthis game\nfrom your discard pile\nto your hand.</voffset></voffset>"
				}),
				effect = gainCombatEffect(8).seq(pushTargetedEffect({
					desc = "Return a champion that was stunned this game to your hand.",
					min = 1,
					max = 1,
					validTargets = selectLoc(currentDiscardLoc).where(isCardChampion()).where(isCardFaction(102)),
					targetEffect = moveTarget(0)
				})),
				cost = sacrificeSelfCost,
				check = selectLoc(currentDiscardLoc).where(isCardChampion()).where(isCardFaction(102)).where(getCardCost().gte(4)).count().gte(1) -- Stop the AI from firing blanks. The AI will res if there is a target of cost 4 or greater available.
			}),
			createAbility({
				id = "smashResSlotPlacer",
				trigger = endOfTurnTrigger,
				effect = addSlotToTarget(createFactionsSlot({102}, {neverExpiry})).apply(selectLoc(currentInPlayLoc))
			})
		},
		layout = createLayout({
			name = "Smashing Resurrection",
			art = "icons/fighter_knock_back",
			text = "<voffset=1em><space=-11.0em><voffset=-4.0em><size=200%><sprite name=\"scrap\"></size></voffset><pos=30%> <voffset=1.0em><line-height=40><space=-5.0em><space=1.0em><size=160%><line-height=100%>\n<sprite name=\"combat_8\"><size=80%><line-height=100%>\nReturn a champion\nthat was stunned\nlast turn\nfrom your discard pile\nto your hand.</voffset></voffset>"
			}),
		layoutPath= "icons/fighter_knock_back"
	})
end

function the_call_def()
	return createDef({
		id = "the_call",
		name = "The Call",
		acquireCost = 0,
		cardTypeLabel = "Ability",
		playLocation = skillsPloc,
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "theCallActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "The Call",
					art = "art/T_Angry_Skeleton",
					text = "<voffset=1em><space=-1.5em><voffset=-1.3em><size=200%><sprite name=\"scrap\"></size></voffset><pos=30%> <voffset=1.0em><line-height=40><space=-3.0em><space=1.0em><size=80%><line-height=100%>Play all cards\nthat were\nsacrificed\nthis game.</voffset></voffset>"
				}),
				effect = playTarget().apply(s.currentPlayer(12).union(s.oppPlayer(12)).where(isCardAction().Or(isCardChampion()).Or(isCardType(itemType)))),
				cost = sacrificeSelfCost
			})
		},
		layout = createLayout({
			name = "The Call",
			art = "art/T_Angry_Skeleton",
					text = "<voffset=1em><space=-1.5em><voffset=-1.3em><size=200%><sprite name=\"scrap\"></size></voffset><pos=30%> <voffset=1.0em><line-height=40><space=-3.0em><space=1.0em><size=80%><line-height=100%>Play all cards\nthat were\nsacrificed\nthis game.</voffset></voffset>"
		}),
		layoutPath= "art/T_Angry_Skeleton"
	})
end

function reaper_s_scythe_carddef()
	local cardLayout = createLayout({
		name = "Reaper's Scythe",
		art = "icons/fighter_crushing_blow_OLD",
		frame = "frames/Wizard_CardFrame",
		text = "<size=180%><sprite name=\"combat_2\"><size=100%><br>Sacrifice a card in the Trade Row."
	})
	
	return createActionDef({
		id = "reaper_s_scythe",
		name = "Reaper's Scythe",
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "reaperScytheMain",
				trigger = autoTrigger,
				effect = gainCombatEffect(2).seq(pushTargetedEffect({
					desc = "Sacrifice a card in the Trade Row.",
					min = 1,
					max = 1,
					validTargets = selectLoc(centerRowLoc),
					targetEffect = moveTarget(12)
				}))
			})
		}
	})
end

function haphazard_resurrection_carddef()
	local cardLayout = createLayout({
		name = "Haphazard Resurrection",
		art = "art/T_Evangelize",
		frame = "frames/HR_CardFrame_Item_Generic",
		cardTypeLabel = "Action",
		text = "<size=150%><sprite name=\"health_2\"><size=80%><br>You may acquire a random card sacrificed this game without paying its cost."
	})
	
	return createActionDef({
		id = "haphazard_resurrection",
		name = "Haphazard Resurrection",
		acquireCost = 0,
		cardTypeLabel = "Action",
		layout = cardLayout,
		playLocation = castPloc,
		abilities = {
			createAbility({
				id = "haphazardResurrectionMain",
				trigger = autoTrigger,
				effect = gainHealthEffect(2)
			}),
			createAbility({
				id = "haphazardResurrectionFetch",
				trigger = uiTrigger,
				effect = randomTarget(const(1), moveTarget(1)).apply(s.currentPlayer(12).union(s.oppPlayer(12)).where(isCardAction().Or(isCardChampion()).Or(isCardType(itemType)))),
				promptType = showPrompt,
				layout = cardLayout
				--TODO: Make non-undoable
			})
		}
	})
end

function underworld_smuggling_carddef()
	local cardLayout = createLayout({
		name = "Underworld Smuggling",
		art = "art/T_Maroon",
		frame = "frames/Thief_CardFrame",
		cardTypeLabel = "Action",
		text = "<size=80%>You may acquire one of the cards sacrificed this game to your hand.\n(You still have to pay its cost.)"
	})
	
	return createActionDef({
		id = "underworld_smuggling",
		name = "Underworld Smuggling",
		acquireCost = 0,
		cardTypeLabel = "Action",
		layout = cardLayout,
		playLocation = castPloc,
		abilities = {
			createAbility({
				id = "underworldSmugglingMain",
				trigger = autoTrigger,
				effect = moveTarget(9).apply(s.currentPlayer(12).union(s.oppPlayer(12)).where(isCardAction().Or(isCardChampion()).Or(isCardType(itemType)))).seq(pushTargetedEffect({
					desc = "Acquire a card to your hand.",
					min = 0,
					max = 1,
					validTargets = s.currentPlayer(9).where(getCardCost().lte(getPlayerGold(currentPid))),
					targetEffect = acquireTarget(0, 0).seq(moveTarget(12).apply(s.currentPlayer(9)))
				}))
			})
		}
	})
end

function throwing_mace_carddef()
	local cardLayout = createLayout({
		name = "Throwing Mace",
		art = "art/Gorg__Orc_Shaman",
		frame = "frames/Cleric_CardFrame",
		cardTypeLabel = "Item",
		text = "<size=160%><sprite name=\"combat_2\">  <sprite name=\"gold_1\">\n<size=80%>If you have 7 or more combat, draw a card."
	})
	
	return createActionDef({
		id = "throwing_mace",
		name = "Throwing Mace",
		acquireCost = 0,
		cardTypeLabel = "Item",
		layout = cardLayout,
		playLocation = CastPloc,
		abilities = {
			createAbility({
				id = "throwingMaceMain",
				trigger = autoTrigger,
				effect = gainCombatEffect(2).seq(gainGoldEffect(1))
			}),
			createAbility({
				id = "throwingMaceConditional",
				trigger = autoTrigger,
				effect = drawCardsEffect(1),
				check = s.getPlayerCombat(currentPid).gte(7)
			})
		}
	})
end

function prayer_longswords_carddef()
	local cardLayout = createLayout({
		name = "Prayer Longswords",
		art = "art/T_Devotion",
		frame = "frames/Cleric_CardFrame",
		cardTypeLabel = "Item",
		text = "<size=150%><sprite name=\"gold_2\"> OR <sprite name=\"combat_3\">\n<size=80%>Choose both if you have two or more champions in play."
	})
	
	local goldLayout = layoutCard({
		title = "Prayer Longswords",
		art = "art/T_Devotion",
		text = "<size=200%><sprite name=\"gold_2\">"
	})
	
	local combatLayout = layoutCard({
		title = "Prayer Longswords",
		art = "art/T_Devotion",
		text = "<size=200%> <sprite name=\"combat_3\">"
	})
	
	return createActionDef({
		id = "prayer_longswords",
		name = "Prayer Longswords",
		acquireCost = 0,
		cardTypeLabel = "Item",
		layout = cardLayout,
		playLocation = CastPloc,
		abilities = {
			createAbility({
				id = "prayerLongswordMain",
				trigger = autoTrigger,
				effect = pushChoiceEffect({
					choices = {
						{
							effect = addSlotToTarget(createFactionsSlot({100}, {endOfTurnExpiry})).apply(selectSource()),
							layout = goldLayout,
							tags = {}
						},
						{
							effect = addSlotToTarget(createFactionsSlot({101}, {endOfTurnExpiry})).apply(selectSource()),
							layout = combatLayout,
							tags = {}
						}
					}
				})
			}),
			createAbility({
				id = "prayerLongswordsGold",
				trigger = autoTrigger,
				effect = gainGoldEffect(2),
				check = (selectSource().where(isCardFaction(100)).count().gte(1)).Or(selectLoc(currentInPlayLoc).count().gte(2))
			}),
			createAbility({
				id = "prayerLongswordsCombat",
				trigger = autoTrigger,
				effect = gainCombatEffect(3),
				check = (selectSource().where(isCardFaction(101)).count().gte(1)).Or(selectLoc(currentInPlayLoc).count().gte(2))
			})
		}
	})
end

function shield_bearing_follower_carddef()
	local cardLayout = createLayout({
		name = "Shield-Bearing Follower",
		art = "avatars/cristov_s_recruits",
		frame = "frames/Warrior_CardFrame",
		cardTypeLabel = "Champion",
		health = 3,
		isGuard = true,
		text = "<size=200%><sprite name=\"expend\">:    <sprite name=\"combat_1\">"
	})
	
	return createChampionDef({
		id = "shield_bearing_follower",
		name = "Shield-Bearing Follower",
		acquireCost = 0,
		health = 3,
		isGuard = true,
		cardTypeLabel = "Champion",
		layout = cardLayout,
		playLocation = inPlayPloc,
		abilities = {
			createAbility({
				id = "shieldBearingFollowerMain",
				trigger = autoTrigger,
				effect = gainCombatEffect(1),
				cost = expendCost,
				activations = multipleActivations
			})
		}
	})
end

function extraDrawBuffDef()
	--Causes player with the buff to play with one extra card each turn.
    return createGlobalBuff({
        id="extra_draw_buff",
        name = "Extra Draw",
        abilities = {
            createAbility({
                id="extra_draw_effect",
                trigger = endOfTurnTrigger,
                effect = drawCardsEffect(1)
            })
        }
    })
end

function setupGame(g)
	registerCards(g, {
		haphazard_resurrection_carddef(),
		underworld_smuggling_carddef(),
		reaper_s_scythe_carddef(),
		shield_bearing_follower_carddef(),
		throwing_mace_carddef(),
		prayer_longswords_carddef(),
		burial_rites_def(),
		bless_and_bash_def(),
		the_call_def()
	})

    standardSetup(g, {
        description = "Gravecaller Class game. Created by Userkaffe.",
        playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(),  createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
        players = {
            {
                id = plid1,
                startDraw = 5,
                name = "Gravecaller",
                avatar="necromancers",
                health = 50,
                cards = {
					hand = {
					},
					deck = {
                      { qty=1, card=haphazard_resurrection_carddef() },
					  { qty=1, card=underworld_smuggling_carddef() },
					  { qty=1, card=ruby_carddef() },
					  { qty=2, card=reaper_s_scythe_carddef() },
					  { qty=5, card=dagger_carddef() },
					  { qty=5, card=gold_carddef() }
					},
					skills = {
						{ qty=1, card=burial_rites_def() },
						{ qty=1, card=the_call_def() }
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
				name = "Fighter-Cleric",
				avatar = "Inquisition",
				health = 115,
                cards = {
					deck = {
						{ qty=2, card=shield_bearing_follower_carddef() },
						{ qty=1, card=throwing_mace_carddef() },
						{ qty=1, card=prayer_longswords_carddef() },
						{ qty=1, card=fighter_jagged_spear_carddef() },
						{ qty=1, card=cleric_redeemed_ruinos_carddef() },
						{ qty=1, card=ruby_carddef() },
						{ qty=5, card=gold_carddef() },
					},
					skills = {
						{ qty=1, card=bless_and_bash_def() },
						{ qty=1, card=smashing_resurrection_def() }
					},
                    buffs = {
                        drawCardsAtTurnEndDef(),
                        discardCardsAtTurnStartDef(),
                        fatigueCount(40, 1, "FatigueP2"),
                    }
                }
            }            
        }
    })
end

function endGame(g)
end

-- Created by Userkaffe
