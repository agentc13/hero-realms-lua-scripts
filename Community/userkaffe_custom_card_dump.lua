require 'herorealms'
require 'decks'
require 'stdlib'
require 'stdcards'
require 'hardai'
require 'mediumai'
require 'easyai'

-- existing cards can be completely overridden within script
-- just create a function with same name as original card has
-- and it would be replaced for your hero
function cleric_shining_breastplate_carddef()
    local cardLayout = createLayout({
        name = "Shining Breastplate",
        art = "icons/cleric_shining_breastplate",
        frame = "frames/Cleric_armor_frame",
        text = "Champion gets +1 defense permanently\n(requires 40 health)"
    })

    return createMagicArmorDef({
        id = "cleric_shining_breastplate",
        name = "Shining Breastplate of Hope",
        types = {clericType, magicArmorType, treasureType, chestType},
        layout = cardLayout,
        layoutPath = "icons/cleric_shining_breastplate",
        abilities = {
            createAbility( {
                id = "cleric_shining_breastplate",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
                effect = pushTargetedEffect(
                    {
                        desc = "Choose a champion to get +1 defense (permanent)",
                        validTargets =  s.CurrentPlayer(CardLocEnum.InPlay),
                        min = 1,
                        max = 1,
                        targetEffect = grantHealthTarget(1, { SlotExpireEnum.Never }, nullEffect(), "shield"),
                        tags = {toughestTag}
                    }
                ),
                cost = AbilityCosts.Expend,
                check = minHealthCurrent(40).And(selectLoc(currentInPlayLoc).where(isCardChampion()).count().gte(1))
            })
        }
    })
end

function clue_def()
	return createSkillDef({
		id = "clue",
		name = "Clue",
		abilities = {
			createAbility({
				id = "clue_ability",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Clue",
					art = "art/dark_sign",
					text = "<sprite name=\"scrap\"> Pay <sprite name=\"gold_3\"> in order to draw a card."
				}),
				effect = drawCardsEffect(1),
				cost = combineCosts({ goldCost(3), sacrificeSelfCost })
			}),
			--this ability is not related to standard clue functionality. This is related to secondary ability of the Champion 'Judge Tulgrul'.
			createAbility({
				id = "judge_tulgrul_area",
				trigger = onSacrificeTrigger,
				effect = grantHealthTarget(1, { SlotExpireEnum.StartOfOwnerTurn }).apply(selectLoc(currentInPlayLoc)),
				check = selectLoc(currentInPlayLoc).where(isCardName("judge_tulgrul")).count().gte(1)
			})
		},
		layout = createLayout({
			name = "Clue",
			art = "art/dark_sign",
			text = "<sprite name=\"scrap\"> Pay <sprite name=\"gold_2\"> in order to draw a card."
		}),
		layoutPath= "art/dark_sign"
	})
end			

function fire_gem_carddef()
	return createActionDef({
		id="fire_gem",
		name="Life Gem",
		types={ itemType, gemType, currencyType },
		acquireCost=2,
		abilities= {
			createAbility({
				id="life_gem_money",
				trigger= autoTrigger,
				effect= gainGoldEffect(2)
			}),
			createAbility({
				id="life_gem_life",
				trigger= uiTrigger,
				cost= sacrificeSelfCost,
				promptType= showPrompt,
				effect= gainHealthEffect(4),
				layout = createLayout({
					name = "Life Gem",
					art = "icons/wizard_spellcaster_gloves",
					frame = "frames/HR_CardFrame_Item_Generic",
					text = "<line-height=175><voffset=0><pos=-125><size=200%><sprite name=\"scrap\"></pos><pos=0><sprite name=\"health_4\"></size></pos></voffset>"
				})
			})
		},
		layout = createLayout({
			name = "Life Gem",
			art = "icons/wizard_spellcaster_gloves",
			frame = "frames/HR_CardFrame_Item_Generic",
			cost = 2,
			text = "<line-height=175><size=180%><voffset=-125><pos=0><sprite name=\"gold_2\"></voffset></size><br><voffset=25><pos=0>________________________</voffset><br><voffset=130><pos=-125><size=180%><sprite name=\"scrap\"><pos=0><sprite name=\"health_4\"></size></voffset>"
		})
	})
end

function imperial_investigator_carddef()
	return createChampionDef({
		id="imperial_investigator",
		name="Imperial Investigator",
		acquireCost=2,
		health=3,
		isGuard=false,
		abilities = {
			createAbility({
				id = "create_clue",
				trigger = uiTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = createCardEffect(clue_def(), currentSkillsLoc)
			})
		},
		layout = createLayout({
			name = "Imperial Investigator",
			art = "art/T_Evangelize",
			frame = "frames/HR_CardFrame_Champion_Imperial",
			cost = 2,
			text = "<voffset=0.5em><size=180%><sprite name=\"expend\"></size>   Create a Clue.</voffset>",
			health = 3,
			isGuard = false
		})
	})
end

function security_search_carddef()
	local cardLayout = createLayout({
		name = "Security Search",
		art = "art/T_Bounty_Collection",
		frame = "frames/HR_CardFrame_Action_Imperial",
		cost = 2,
		text = "Gain<br><sprite name=\"combat_1\">\"Fire Staff\"<br>and<br><sprite name=\"gold_2\">/<sprite name=\"health_5\">\"Prayer Beads\"<br>to your hand."
	})
	
	return createActionDef({
		id = "security_search",
		name = "Security Search",
		acquireCost = 2,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "securitySearchMain",
				trigger = autoTrigger,
				effect = createCardEffect(wizard_fire_staff_carddef(), currentHandLoc).seq(createCardEffect(cleric_prayer_beads_carddef(), currentHandLoc))
			})
		}
	})
end

function mobilization_carddef()
	local cardLayout = createLayout({
		name = "Mobilization",
		art = "art/T_Street_Thug",
		frame = "frames/HR_CardFrame_Action_Imperial",
		cost = 3,
		text = "Gain one to your hand:<br><sprite name=\"combat_1\">/4<sprite name=\"shield\"> Militia <br>OR<br> <sprite name=\"gold_1\">/4<sprite name=\"shield\"> Peasant.>"
	})
	
	local militiaLayout = layoutCard({
		title = "Militia",
		art = "art/T_Recruit",
		health = 4,
		isGuard = false,
		text = "<size=200%><space=-2em><voffset=-4><sprite name=\"expend\"></voffset><space=1em><sprite name=\"combat_1\"></size>"
	})
	
	local peasantLayout = layoutCard({
		title = "Peasant",
		art = "art/T_Taxation",
		health = 4,
		isGuard = false,
		text = "<size=200%><space=-2em><voffset=-4><sprite name=\"expend\"></voffset><space=1em><sprite name=\"gold_1\"></size>"
	})
	
	return createActionDef({
		id = "mobilization",
		name = "Mobilization",
		acquireCost = 3,
		layout = cardLayout,
		abilities = ({
			createAbility({
				id = "mobilization_main",
				trigger = autoTrigger,
				effect =  pushChoiceEffect({
					choices={
						{
							effect = createCardEffect(militia_carddef(), currentHandLoc),                    
							layout = militiaLayout,
							tags = {gold1Tag}
				
						},
						{
							effect = createCardEffect(peasant_carddef(), currentHandLoc),                  
							layout = peasantLayout,
							tags = {gainHealth2Tag}
						}
					}
				}),
				tags = { "militiaTag", "peasantTag" },
			})
		})
	})
end

function militia_carddef()
	local cardLayout = createLayout({
		name = "Militia",
		art = "art/T_Recruit",
		frame = "frames/Coop_Campaign_CardFrame",
		health = 4,
		isGuard = false,
		text = "<size=200%><space=-2em><voffset=-4><sprite name=\"expend\"></voffset><space=1em><sprite name=\"combat_1\"></size>"
	})
	
	return createChampionDef({
		id = "militia",
		name = "Militia",
		acquireCost = 0,
		health = 4,
		isGuard = false,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "militia_attack",
				trigger = autoTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = gainCombatEffect(1)
			})
		}
	})
end

function peasant_carddef()
	local cardLayout = createLayout({
		name = "Peasant",
		art = "art/T_Taxation",
		frame = "frames/Coop_Campaign_CardFrame",
		health = 4,
		isGuard = false,
		text = "<size=200%><space=-2em><voffset=-4><sprite name=\"expend\"></voffset><space=1em><sprite name=\"gold_1\"></size>"
	})
	
	return createChampionDef({
		id = "peasant",
		name = "Peasant",
		acquireCost = 0,
		health = 4,
		isGuard = false,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "peasant_gather",
				trigger = autoTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = gainGoldEffect(1)
			})
		}
	})
end

function palace_guard_carddef()
	local cardLayout = createLayout({
		name = "Palace Guard",
		art = "avatars/man_at_arms",
		frame = "frames/HR_CardFrame_Champion_Imperial",
		cost = 7,
		health = 8,
		isGuard = true,
		text = "<size=200%><space=-1.0em><voffset=-4><sprite name=\"expend\"></voffset><space=0.6em><sprite name=\"combat_2\"> <sprite name=\"health_2\"><size=100%><br>+1 <sprite name=\"combat\"> per action you have in play.</size>"
	})
	
	return createChampionDef({
        id="palace_guard",
        name="Palace Guard",
        acquireCost=7,
        health = 8,
        isGuard = true,
        abilities = {
            createAbility({
                id="palace_guard_attack",
                trigger = uiTrigger,
				cost = expendCost,
				activations = multipleActivations,
                effect = gainCombatEffect(selectLoc(currentCastLoc).where(isCardAction()).count().add(2)).seq(gainHealthEffect(2))
            })
        },
        layout = cardLayout
    })
end

function resupply_carddef()
	local cardLayout = createLayout({
		name = "Resupply",
		art = "T_Devotion",
		frame = "frames/HR_CardFrame_Action_Imperial",
		cost = 1,
		text = "<size=180%><sprite name=\"gold_1\"> <sprite name=\"combat_2\"> <sprite name=\"health_3\"><br></size>__________________<br><size=80%><sprite name=\"imperial\">: Expend<br>target champion."
	})
	
	return createActionDef({
		id = "resupply",
		name = "Resupply",
		acquireCost = 1,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "resupply_main",
				trigger = autoTrigger,
				effect = gainGoldEffect(1).seq(gainCombatEffect(2)).seq(gainHealthEffect(3))
			})
			--TODO: {Ally} => Prepare target champion
		}
	})
end

function warehouse_carddef()
	local cardLayout = createLayout({
		name = "Warehouse",
		art = "T_Devotion",
		frame = "frames/HR_CardFrame_Action_Imperial",
		cost = 3,
		text = "<size=80%>Draw a card<br>OR<br>Put three cards from with no cost from your discard to your hand."
	})
	
	local drawLayout = layoutCard({
		title = "Draw",
		art = "art/T_Recruit",
		text = "Draw a card."
	})
	
	local salvageLayout = layoutCard({
		title = "Salvage",
		art = "art/T_Recruit",
		text = "Put up to three cards with no cost from your discard to your hand."
	})
	
	return createActionDef({
		id = "warehouse",
		name = "Warehouse",
		acquireCost = 3,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "warehouse_main",
				trigger = autoTrigger,
				effect =  pushChoiceEffect({
					choices={
						{
							effect = drawCardsEffect(1),                    
							layout = drawLayout,
							tags = {gold1Tag}
				
						},
						{
							effect = pushTargetedEffect({
								desc = "Return up to two cards with no cost to hand.",
								min = 0,
								max = 3,
								validTargets = selectLoc(loc(currentPid, discardPloc)).where(getCardCost().lte(1)),
								targetEffect = moveTarget(currentHandLoc)
							}),
							layout = salvageLayout,
							tags = {gainHealth2Tag}
						}
					}
				}),
				tags = { "militiaTag", "peasantTag" },
			})
		}
	})
end

function shady_bishop_carddef()
	local cardLayout = createLayout({
		name = "Civil Servant",
		art = "icon/cleric_bless_the_flock",
		frame = "frames/HR_CardFrame_Champion_Imperial",
		cost = 4,
		health = 5,
		isGuard = false,
		text = "<pos=-50><size=180%><sprite name=\"expend\">   <sprite name=\"gold_2\"> <sprite name=\"health_2\">"
	})
	
	return createChampionDef({
		id = "shady_bishop",
		name = "Civil Servant",
		acquireCost = 4,
		health = 5,
		isGuard = false,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "shady_bishop_main",
				trigger = autoTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = gainHealthEffect(2).seq(gainGoldEffect(2))
			})
			--TODO: {Imperial} => 'Cursed!'
		}
	})
end

function written_complaint_carddef()
	local cardLayout = createLayout({
		name = "Written Complaint",
		art = "art/T_Confused_Apparition",
		frame = "frames/HR_CardFrame_Item_Generic",
		text = "<size=200%><sprite name=\"combat_1\">"
	})
	
	return createActionDef({
		id = "written_complaint",
		name = "Written Complaint",
		acquireCost = 0,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "writtenComplaintMain",
				trigger = autoTrigger,
				effect = gainCombatEffect(1)
			})
		}
	})
end

function bureaucracy_carddef()
	local cardLayout = createLayout({
		name = "Bureaucracy",
		art = "art/T_Devotion",
		frame = "frames/HR_CardFrame_Action_Imperial",
		cost = 5,
		text = "Add three<br>\"Complaints(<sprite name=\"combat_1\">)\"<br>to your opponents discard."
	})
	
	return createActionDef({
		id = "bureaucracy",
		name = "Bureaucracy",
		acquireCost = 5,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "bureaucracyMain",
				trigger = autoTrigger,
				effect = createCardEffect(written_complaint_carddef(), loc(oppPid, discardPloc)).seq(createCardEffect(written_complaint_carddef(), loc(oppPid, discardPloc))).seq(createCardEffect(written_complaint_carddef(), loc(oppPid, discardPloc)))
			})
			--TODO: ally
		}
	})
end

function cardinal_krythos_carddef()
	local cardLayout = createLayout({
		name = "Cardinal Krythos",
		art = "avatars/krythos",
		frame = "frames/HR_CardFrame_Champion_Imperial",
		cost = 6,
		health = 6,
		isGuard = false,
		text = "<size=180%><sprite name=\"expend\">   <sprite name=\"combat_3\">"
	})
	
	return createChampionDef({
		id = "cardinal_krythos",
		name = "Cardinal Krythos",
		acquireCost = 6,
		health = 6,
		isGuard = false,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "cardinalKrythosMain",
				trigger = autoTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = gainCombatEffect(3)
			})
			--TODO: Ally
		}
	})
end

function lead_the_investigation_carddef()
	local cardLayout = createLayout({
		name = "Lead the Investigation",
		art = "art/T_Devotion",
		frame = "frames/HR_CardFrame_Action_Imperial",
		cost = 5,
		text = "<sprite name=\"gold_2\"> <sprite name=\"combat_2\"> <sprite name=\"health_2\"><br>Create two Clues."
	})
	
	return createActionDef({
		id = "lead_the_investigation",
		name = "Lead the Investigation",
		acquireCost = 5,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "leadTheInvestigationMain",
				trigger = autoTrigger,
				effect = createCardEffect(clue_def(), currentSkillsLoc).seq(createCardEffect(clue_def(), currentSkillsLoc)).seq(gainGoldEffect(2)).seq(gainHealthEffect(2)).seq(gainCombatEffect(2))
			})
		}
	})
end

function judge_tulgrul_carddef()
	local cardLayout = createLayout({
		name = "Judge Tulgrul",
		art = "icon/cleric_bless_the_flock",
		frame = "frames/HR_CardFrame_Champion_Imperial",
		cost = 4,
		health = 3,
		isGuard = true,
		text = "<sprite name=\"expend\"> Create a Clue.<br>When you sacrifice a clue, your champions get +1<sprite name=\"shield\"> until your next turn."
	})
	
	return createChampionDef({
		id = "judge_tulgrul",
		name = "Judge Tulgrul",
		acquireCost = 4,
		health = 3,
		isGuard = true,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "judge_tulgrul_main",
				trigger = uiTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = createCardEffect(clue_def(), currentSkillsLoc)
			})
			--NOTICE: Judge Tulgrul's second ability is not implemented here. The ability can be found in clue_def().
		}
	})
end

function council_archmage_carddef()
	local cardLayout = createLayout({
		name = "Council Archmage",
		art = "icon/cleric_bless_the_flock",
		frame = "frames/HR_CardFrame_Champion_Imperial",
		cost = 8,
		health = 8,
		isGuard = false,
		text = "<size=180%><sprite name=\"expend\">     <sprite name=\"combat_6\"> <sprite name=\"health_6\"><br><size=100%>+3 <sprite name=\"combat\"> per action in play."
	})
	
	return createChampionDef({
		id = "council_archmage",
		name = "Council Archmage",
		acquireCost = 8,
		health = 8,
		isGuard = false,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "councilArchmageMain",
				trigger = autoTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = gainCombatEffect(6).seq(gainHealthEffect(6).seq(gainCombatEffect(selectLoc(currentCastLoc).where(isCardAction()).count().multiply(3))))
			})
			--TODO: Ally
		}
	})
end


function faerie_trickster_carddef()
	local cardLayout = createLayout({
		name = "Faerie Trickster",
		art = "art/T_Battle_Cry",
		frame = "frames/HR_CardFrame_Action_Wild",
		cost = 2,
		text = "<size=120%><sprite name=\"gold_2\"><size=45%><br><br>Target opponent discards a card.<br>________________________________________________________<size=100%><br><sprite name=\"wild\"><size=80%>: Target opponent gains a Complaint."
	})
	
	return createActionDef({
		id = "faerie_trickster",
		name = "Faerie Trickster",
		acquireCost = 2,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "elvenMarketMain",
				trigger = autoTrigger,
				effect =  gainGoldEffect(2).seq(oppDiscardEffect(1))
			})
			--TODO: Ally
		}
	})
end

function junk_dealer_carddef()
	local cardLayout = createLayout({
		name = "Junk Dealer",
		art = "art/Gorg__Orc_Shaman",
		frame = "frames/HR_CardFrame_Champion_Wild",
		cost = 3,
		health = 4,
		isGuard = true,
		text = "<size=60%>Gain Gold or Dagger to your hand. Your opponent gains the other to their hand.<br>_____________________________<br><size=100%><sprite name=\"wild\"><sprite name=\"wild\">: Draw a card."
	})
	
	local gainGoldLayout = layoutCard({
		title = "Junk Dealer",
		art = "art/Gorg__Orc_Shaman",
		text = "You gain Gold.<br>Your opponent gains Dagger."
	})
	
	local gainDaggerLayout = layoutCard({
		title = "Junk Dealer",
		art = "art/Gorg__Orc_Shaman",
		text = "You gain Dagger.<br>Your opponent gains Gold."
	})
	
	return createChampionDef({
		id = "junk_dealer",
		name = "Junk Dealer",
		acquireCost = 3,
		health = 4,
		isGuard = true,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "junkDealerMain",
				trigger = uiTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = pushChoiceEffect({
					choices={
						{
							effect = createCardEffect(dagger_carddef(), loc(oppPid, handPloc)).seq(createCardEffect(gold_carddef(), loc(currentPid, handPloc))),
							layout = gainGoldLayout,
							tags = {gold1Tag}
						},
						{
							effect = createCardEffect(gold_carddef(), loc(oppPid, handPloc)).seq(createCardEffect(dagger_carddef(), loc(currentPid, handPloc))),
							layout = gainDaggerLayout,
							tags = {gainHealth2Tag}
						}
					}
				})
			})
			--TODO: Ally
		}
	})
end

function ironwood_treant_carddef()
	local cardLayout = createLayout({
		name = "Ironwood Treant",
		art = "art/Gorg__Orc_Shaman",
		frame = "frames/HR_CardFrame_Champion_Wild",
		cost = 4,
		health = 5,
		isGuard = false,
		text = "<sprite name=\"expend\">: <sprite name=\"gold_2\"><br><sprite name=\"wild\"><sprite name=\"wild\">: Draw a card.<br>__________________<br>When you discard this, gain 3 combat."
	})
	
	return createChampionDef({
		id = "ironwood_treant",
		name = "Ironwood Treant",
		acquireCost = 4,
		health = 5,
		isGuard = false,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "ironwoodTreantMain",
				trigger = autoTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = gainGoldEffect(2)
			})
			--TODO: Ally
		},
		--cardEffectAbilities = {
		--	createCardEffectAbility({
		--		trigger = locationChangedCardTrigger,
		--		effect = gainCombatEffect(3),
		--		check = selectSource().where(isCardName("ironwood_treant")).where(isCardAtLoc(discardPloc)).count().gte(1)
		--	})
		--}
	})
end

function torch_carddef()
	local cardLayout = createLayout({
		name = "Torch",
		art = "art/T_Battle_Cry",
		frame = "frames/HR_CardFrame_Action_Wild",
		cost = 1,
		text = "<sprite name=\"combat_3\"><br>Draw a card, then discard a card.<br><sprite name=\"wild\">: <sprite name=\"gold_1\">"
	})
	
	local noDrawLayout = layoutCard({
		title = "Torch",
		art = "art/T_Battle_Cry",
		text = "<sprite name=\"combat_3\">"
	})
	
	local yesDrawLayout = layoutCard({
		title = "Torch",
		art = "art/T_Battle_Cry",
		text = "<sprite name=\"combat_3\"><br>Draw a card, then discard a card."
	})
	
	return createActionDef({
		id = "torch",
		name = "Torch",
		acquireCost = 1,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "torchMain",
				trigger = autoTrigger,
				effect =  pushChoiceEffect({
                    choices={
                        {
                            effect = gainCombatEffect(3),
                            layout = noDrawLayout,
                            tags = {gold1Tag}
                        },
                        {
                            effect = gainCombatEffect(3).seq(drawCardsEffect(1)).seq(
                                pushTargetedEffect({
                                    desc = "Discard a card",
                                    min = 1,
                                    max = 1,
                                    validTargets = selectLoc(currentHandLoc),
                                    targetEffect = discardTarget()
                                })),
                            layout = yesDrawLayout,
                            tags = {gainHealth2Tag}
                        }
                    }
                })
			})
			--TODO: Upgrade
		}
	})
end

function weapon_stall_carddef()
	local cardLayout = createLayout({
		name = "Weapon Stall",
		art = "art/T_Battle_Cry",
		frame = "frames/HR_CardFrame_Action_Wild",
		cost = 2,
		text = "Gain<br><sprite name=\"combat_1\">\"Throwing Knife\" and <sprite name=\"combat_2\">\"Throwing Axe\"<br>to your hand. Each player discards a card."
	})
	
	return createActionDef({
		id = "weapon_stall",
		name = "Weapon Stall",
		acquireCost = 2,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "weaponStallMain",
				trigger = autoTrigger,
				effect = createCardEffect(thief_throwing_knife_carddef(), currentHandLoc).seq(createCardEffect(fighter_throwing_axe_carddef(), currentHandLoc)).seq(oppDiscardEffect(1)).seq(
					pushTargetedEffect({
						desc = "Discard a card",
						min = 1,
						max = 1,
						validTargets = selectLoc(currentHandLoc),
						targetEffect = discardTarget()
					}))
			})
		}
	})
end

function elven_seer_carddef()
	local cardLayout = createLayout({
		name = "Elven Seer",
		art = "art/Gorg__Orc_Shaman",
		frame = "frames/HR_CardFrame_Champion_Wild",
		cost = 3,
		health = 3,
		isGuard = false,
		text = "<size=70%><sprite name=\"expend\">: Look at the top three cards of your deck. Put up to one with no cost to your hand. Put the rest back in any order."--<br><sprite name=\"necro\">: You may also sacrifice one of the revealed cards."
	})
	
	return createChampionDef({
		id = "elven_seer",
		name = "Elven Seer",
		acquireCost = 3,
		health = 3,
		isGuard = false,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "elvenSeerMain",
				trigger = uiTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = drawToLocationEffect(const(3), currentRevealLoc)
                .seq(promptSplit({
					selector = selectLoc(currentRevealLoc),
					take = const(3),
					sort = const(1),
					ef1 =moveToTopDeckTarget(true),
					ef2 = ifElseTarget(getCardCost().eq(0), moveTarget(currentHandLoc), moveToTopDeckTarget(true)),
					header = "Elven Seer",
					description = "Look at the top three cards of your deck. Put up to one of them with no cost into your hand, then put the rest back in any order.",
					pile1Name = "Top of Deck",
					pile2Name = "Draw if costs 0",
					eff1Tags = { buytopdeckTag },
					eff2Tags = { cheapestTag }
				}))
			})
		},
	})
end

function ancient_protector_carddef()
	local cardLayout = createLayout({
		name = "Ancient Protector",
		art = "art/Gorg__Orc_Shaman",
		frame = "frames/HR_CardFrame_Champion_Wild",
		cost = 6,
		health = 6,
		isGuard = true,
		text = "<sprite name=\"expend\">: <sprite name=\"combat_4\"><br>When you discard or sacrifice this, draw a card."
	})
	
	return createChampionDef({
		id = "ancient_protector",
		name = "Ancient Protector",
		acquireCost = 6,
		health = 6,
		isGuard = true,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "ancientProtectorMain",
				trigger = autoTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = gainCombatEffect(4)
			})
			--TODO: discard
		},
	})
end

function swift_strike_carddef()
	local cardLayout = createLayout({
		name = "Swift Strike",
		art = "art/T_Battle_Cry",
		frame = "frames/HR_CardFrame_Action_Wild",
		cost = 5,
		text = "<sprite name=\"combat_8\"><br>You may draw a card. If you do, discard a card.<br>__________________<br><sprite name=\"wild\">: <sprite name=\"gold_3\">"
	})
	
	local noDrawLayout = layoutCard({
		title = "Swift Strike",
		art = "art/T_Battle_Cry",
		text = "<sprite name=\"combat_8\">"
	})
	
	local yesDrawLayout = layoutCard({
		title = "Swift Strike",
		art = "art/T_Battle_Cry",
		text = "<sprite name=\"combat_8\"><br>Draw a card, then discard a card."
	})
	
	return createActionDef({
		id = "swift_strike",
		name = "Swift Strike",
		acquireCost = 5,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "swiftStrikeMain",
				trigger = autoTrigger,
				effect =  pushChoiceEffect({
                    choices={
                        {
                            effect = gainCombatEffect(8),
                            layout = noDrawLayout,
                            tags = {gold1Tag}
                        },
                        {
                            effect = gainCombatEffect(8).seq(drawCardsEffect(1)).seq(
                                pushTargetedEffect({
                                    desc = "Discard a card",
                                    min = 1,
                                    max = 1,
                                    validTargets = selectLoc(currentHandLoc),
                                    targetEffect = discardTarget()
                                })),
                            layout = yesDrawLayout,
                            tags = {gainHealth2Tag}
                        }
                    }
                })
			})
		}
	})
end

function orc_warlord_carddef()
	local cardLayout = createLayout({
		name = "Orc Warlord",
		art = "art/Gorg__Orc_Shaman",
		frame = "frames/HR_CardFrame_Champion_Wild",
		cost = 7,
		health = 8,
		isGuard = false,
		text = "<sprite name=\"expend\">: <sprite name=\"combat_4\"><br><sprite name=\"guild\">: Stun target Champion.<br><sprite name=\"wild\"><sprite name=\"wild\">: Draw a card."
	})
	
	return createChampionDef({
		id = "orc_warlord",
		name = "Orc Warlord",
		acquireCost = 7,
		health = 8,
		isGuard = false,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "orcWarlordMain",
				trigger = autoTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = gainCombatEffect(4)
			})
			--TODO: ally
		},
	})
end

function reckless_charge_carddef()
	local cardLayout = createLayout({
		name = "Reckless Charge",
		art = "art/T_Battle_Cry",
		frame = "frames/HR_CardFrame_Action_Wild",
		cost = 5,
		text = "<sprite name=\"combat_4\"><br>Draw up to two cards. Then discard that many cards."
	})
	
	local noDrawLayout = layoutCard({
		title = "Reckless Charge",
		art = "art/T_Battle_Cry",
		text = "<sprite name=\"combat_4\">"
	})
	
	local oneDrawLayout = layoutCard({
		title = "Reckless Charge",
		art = "art/T_Battle_Cry",
		text = "<sprite name=\"combat_4\"><br>Draw a card, then discard a card."
	})
	
	local yesDrawLayout = layoutCard({
		title = "Reckless Charge",
		art = "art/T_Battle_Cry",
		text = "<sprite name=\"combat_4\"><br>Draw two cards, then discard two cards."
	})
	
	return createActionDef({
		id = "reckless_charge",
		name = "Reckless Charge",
		acquireCost = 5,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "recklessChargeMain",
				trigger = autoTrigger,
				effect =  pushChoiceEffect({
                    choices={
                        {
                            effect = gainCombatEffect(4),
                            layout = noDrawLayout,
                            tags = {gold1Tag}
                        },
                        {
                            effect = gainCombatEffect(4).seq(drawCardsEffect(1)).seq(
                                pushTargetedEffect({
                                    desc = "Discard a card.",
                                    min = 1,
                                    max = 1,
                                    validTargets = selectLoc(currentHandLoc),
                                    targetEffect = discardTarget()
                                })),
                            layout = oneDrawLayout,
                            tags = {gainHealth2Tag}
                        },
                        {
                            effect = gainCombatEffect(4).seq(drawCardsEffect(2)).seq(
                                pushTargetedEffect({
                                    desc = "Discard two cards.",
                                    min = 2,
                                    max = 2,
                                    validTargets = selectLoc(currentHandLoc),
                                    targetEffect = discardTarget()
                                })),
                            layout = yesDrawLayout,
                            tags = {gainHealth2Tag}
                        }
                    }
                })
			})
		}
	})
end

function eternal_guardian_carddef()
	local cardLayout = createLayout({
		name = "Eternal Guardian",
		art = "art/Gorg__Orc_Shaman",
		frame = "frames/HR_CardFrame_Champion_Wild",
		cost = 8,
		health = 7,
		isGuard = false,
		text = "<sprite name=\"expend\">: <sprite name=\"combat_5\"><br>Put a card without cost from your discard to your hand.<br>__________________<br>When you would discard or sacrifice this, put it in play expended instead."
	})
	
	return createChampionDef({
		id = "eternal_guardian",
		name = "Eternal Guardian",
		acquireCost = 8,
		health = 7,
		isGuard = false,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "eternalGuardianMain",
				trigger = uiTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = gainCombatEffect(5).seq(pushTargetedEffect({
					desc = "Put a card without cost from your discard to your hand.",
					min = 0,
					max = 1,
					validTargets = selectLoc(loc(currentPid, discardPloc)).where(getCardCost().eq(0)),
					targetEffect = moveTarget(currentHandLoc)
				}))
			})
			--TODO: ally
		},
	})
end

function lightning_strike_carddef()
	local cardLayout = createLayout({
		name = "Lightning Strike",
		art = "art/T_Battle_Cry",
		frame = "frames/HR_CardFrame_Action_Wild",
		cost = 3,
		text = "<sprite name=\"combat_1\"><br>Draw a card.<br><sprite name=\"wild\">: Target opponent discards a card.<br><sprite name=\"wild\"><sprite name=\"wild\">: <sprite name=\"combat_3\">"
	})
	
	return createActionDef({
		id = "lightning_strike",
		name = "Lightning Strike",
		acquireCost = 3,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "lightningStrikeMain",
				trigger = autoTrigger,
				effect = gainCombatEffect(1).seq(drawCardsEffect(1))
			})
		}
	})
end

function trade_contract_carddef()
	local cardLayout = createLayout({
		name = "Trade Contract",
		art = "art/T_Set_Sail",
		frame = "frames/HR_CardFrame_Action_Guild",
		cost = 2,
		text = "<sprite name=\"gold_2\"><br>Acquire a card to bottom of deck.<br><sprite name=\"guild\">: <sprite name=\"combat_5\">"
	})
	
	return createActionDef({
		id = "trade_contract",
		name = "Trade Contract",
		acquireCost = 2,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "tradeContractMain",
				trigger = autoTrigger,
				effect = gainGoldEffect(2)
			}),
			--TODO: does not work
			--createAbility({
			--	id = "tradeContractBotDeck",
			--	trigger = uiTrigger,
			--	effect = pushTargetedEffect({
			--		desc = "Acquire a card to bottom of your deck.",
			--		min = 0,
			--		max = 1,
			--		validTargets = selectLoc(tradeRowLoc),
			--		targetEffect = acquireTarget(0, loc(currentPid, discardPloc))
			--	}),
			--})
		}
	})
end

function tithe_broker_carddef()
	local cardLayout = createLayout({
		name = "Tithe Broker",
		art = "art/T_Feisty_Orcling",
		frame = "frames/HR_CardFrame_Champion_Guild",
		cost = 1,
		health = 3,
		isGuard = false,
		text = "<sprite name=\"expend\">: +1 <sprite name=\"gold\"> or +1 <sprite name=\"combat\"><br><sprite name=\"guild\"><sprite name=\"guild\">: Upgrade this with +1 <sprite name=\"gold\">, <sprite name=\"combat\"> and <sprite name=\"shield\">"
	})
	
	local goldLayout = layoutCard({
		title = "Tithe Broker",
		art = "art/T_Feisty_Orcling",
		text = "+1 <sprite name=\"gold\">"
	})
	
	local combatLayout = layoutCard({
		title = "Tithe Broker",
		art = "art/T_Feisty_Orcling",
		text = "+1 <sprite name=\"combat\">"
	})
	
	return createChampionDef({
		id = "tithe_broker",
		name = "Tithe Broker",
		acquireCost = 1,
		health = 3,
		isGuard = false,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "titheBrokerMain",
				trigger = uiTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect =  pushChoiceEffect({
                    choices={
                        {
                            effect = gainGoldEffect(1),
                            layout = goldLayout,
                            tags = {gold1Tag}
                        },
                        {
                            effect = gainCombatEffect(1),
                            layout = combatLayout,
                            tags = {gainHealth2Tag}
                        }
                    }
                })
			})
			--TODO: ally
		},
	})
end

function show_of_force_carddef()
	local cardLayout = createLayout({
		name = "Show of Force",
		art = "art/T_Set_Sail",
		frame = "frames/HR_CardFrame_Action_Guild",
		cost = 3,
		text = "<sprite name=\"gold_1\"> <sprite name=\"combat_5\"><br>If you have two or more other actions in play, draw a card."
	})
	
	return createActionDef({
		id = "show_of_force",
		name = "Show of Force",
		acquireCost = 3,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "showOfForceMain",
				trigger = autoTrigger,
				effect = gainGoldEffect(1).seq(gainCombatEffect(5))
			}),
			createAbility({
				id = "showOfForceDraw",
				trigger = autoTrigger,
				effect = drawCardsEffect(1),
				check = selectLoc(currentCastLoc).where(isCardAction()).count().gte(3)
			})
		}
	})
end

function hired_muscle_carddef()
	local cardLayout = createLayout({
		name = "Hired Muscle",
		art = "art/T_Feisty_Orcling",
		frame = "frames/HR_CardFrame_Champion_Guild",
		cost = 2,
		health = 3,
		isGuard = true,
		text = "<sprite name=\"expend\">: +1 <sprite name=\"combat\"><br><br>Pay 3<sprite name=\"gold\">: Upgrade this card with +1<sprite name=\"combat\"> and +1<sprite name=\"shield\">"
	})
	
	return createChampionDef({
		id = "hired_muscle",
		name = "Hired Muscle",
		acquireCost = 2,
		health = 3,
		isGuard = true,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "hiredMuscleMain",
				trigger = autoTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = gainCombatEffect(1)
			})
			--TODO: upgrade
		},
	})
end

function orc_guardian_carddef()
    return createChampionDef({
        id="orc_guardian",
        name="Orc Guardian",
        types={ orcType, noStealType },
        acquireCost=0,
        health = 3,
        isGuard = true,
        abilities = {
            createAbility({
                id="feisty_orcling_auto",
                trigger = autoTrigger,
                effect = nullEffect()
            })
        },
        layout = createLayout({
            name = "Orc Guardian",
            art = "art/T_Orc_Guardian",
            frame = "frames/Coop_Campaign_CardFrame",
            text = "<i>He's quite defensive.</i>",
            cost = 2,
			health = 3,
            isGuard = true
        })
    })
end


--given to the players at the start of the game, triggers at the start of first player's turn then sacrifices itself
function doubleHealthBuffDef() 
    -- here we define an effect for the buff
    local ef = gainMaxHealthEffect(currentPid, getPlayerMaxHealth(currentPid))
		-- no comments :D
        .seq(gainMaxHealthEffect(oppPid, getPlayerMaxHealth(oppPid)))
		-- I've changed my mind, lets just scrap this thing
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
    -- register newly created cards for further use
    -- no need to register overridden cards, like shining breastplate here
	registerCards(g, {
		imperial_investigator_carddef(),
		mobilization_carddef(),
		militia_carddef(),
		peasant_carddef(),
		security_search_carddef(),
		palace_guard_carddef(),
		resupply_carddef(),
		warehouse_carddef(),
		shady_bishop_carddef(),
		written_complaint_carddef(),
		bureaucracy_carddef(),
		cardinal_krythos_carddef(),
		lead_the_investigation_carddef(),
		judge_tulgrul_carddef(),
		council_archmage_carddef(),
		faerie_trickster_carddef(),
		junk_dealer_carddef(),
		ironwood_treant_carddef(),
		torch_carddef(),
		weapon_stall_carddef(),
		elven_seer_carddef(),
		ancient_protector_carddef(),
		swift_strike_carddef(),
		orc_warlord_carddef(),
		reckless_charge_carddef(),
		eternal_guardian_carddef(),
		lightning_strike_carddef(),
		trade_contract_carddef(),
		tithe_broker_carddef(),
		show_of_force_carddef(),
		orc_guardian_carddef(),
		clue_def()
	})
    
    -- startardSetup function accepts a table with all data required to set the game up
    standardSetup(g, {
        -- script description - displayed in in-game menu
        description = "Userkaffe's Mod v0.1", 
        -- order in which players take turns
        playerOrder = { plid1, plid2 }, 
        -- sets AI for ai players
        ai = createHardAi(),
        -- if true, randomizes players order
        randomOrder = true,
        -- pairs of opponents
        opponents = { { plid1, plid2 } },
        -- specify up to 5 cards to appear in the center row at the start of the game
        --centerRow = { "tithe_priest", "imperial_investigator", "imperial_investigator", "imperial_investigator", "imperial_investigator"  }, 
        -- this allows to change market deck.
        tradeDeckExceptions = {
            -- 3 orc guardians go into deck
            -- { qty=3, cardId="orc_guardian" },
        },
        -- set to true if you don't want trade deck
        noTradeDeck = false,
        -- set to true if you don't want fire gems
        noFireGems = false,
        -- array of players
        players = { 
            {
                -- sets up id for the player. options are plid1, plid2, plid3, plid4
                id = plid1, 
                -- sets how many cards player draws at the start of the game. If not set, first player will draw 3, second player - 5
                -- commented out as we have random order enabled.
                -- startDraw = 3,
                -- sets how hero get initialized
                --init = {
                --    -- takes hero data from the selection (VS AI or Online)
                --    fromEnv = plid1
                --},
			name = "player1",
			avatar= "assassin",
			health= 50,
                -- cards allows to add any cards to any of hero location at the start of the game
                cards = { 
					deck = {
                      { qty=3, card=show_of_force_carddef() },
                      { qty=2, card=gold_carddef() },
					  { qty=4, card=wizard_ignite_carddef() },
					  { qty=1, card=ruby_carddef() }
                  },
                  buffs = {
                        -- mandatory card: discards cards at the end of turn and draws next hand
                        drawCardsAtTurnEndDef(),
                        -- mandatory card: processes discards at the start of turn 
                        discardCardsAtTurnStartDef(),
                        -- grants increased by 1 combat starting from turn 40
                        fatigueCount(40, 1, "FatigueP1"),
                        -- custom buff we created to double health
                        doubleHealthBuffDef()
                    }
                }
            },
            {
                id = plid2,
                -- should always be true for player 2 when playing around with local scripts
                isAi = true, 
                -- startDraw = 5,
                name = "AI",
                -- sets avatar for the player
                avatar="assassin",
                -- starting health
                health = 100,
                -- if not set - equals to starting health
                maxHealth = 200,
                -- you may also set cards for "hand", "inPlay", "discard", "skills"
                cards = { 
                    deck = {
                        { qty=2, card=dagger_carddef() },
                        { qty=8, card=gold_carddef() },
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







