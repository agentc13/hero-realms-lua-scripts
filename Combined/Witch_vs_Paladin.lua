require 'herorealms'
require 'decks'
require 'stdlib'
require 'timeoutai'
require 'hardai_2'
require 'aggressiveai'

-- player 1 plays as witch, player 2 plays as paladin

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

-- START Warhammer CARD
function paladin_warhammer_carddef()
    return createDef(
        {
            id = "paladin_warhammer",
            name = "Warhammer",
            types = {weaponType, noStealType, paladinType, itemType, meleeWeaponType, hammerType},
            acquireCost = 0,
            cardTypeLabel = "Item",
            playLocation = castPloc,
            abilities = {
                createAbility(
                    {
                        id = "paladin_warhammer",
                        layout = cardLayout,
                        effect = ifElseEffect(selectLoc(currentCastLoc).where(isCardType(weaponType)).count().gte(2),
                        gainCombatEffect(2).seq(gainHealthEffect(2)),
                        pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = gainCombatEffect(2),
                                            layout = layoutCard(
                                                {
                                                    title = "Warhammer",
                                                    art = "art/T_Flesh_Ripper",
                                                    text = "Gain <sprite name=\"combat_2\">"
                                                }
                                            ),
                                            tags = {gainCombat2Tag}
                                        },
                                        {
                                            effect = gainHealthEffect(2),
                                            layout = layoutCard(
                                                {
                                                    title = "Warhammer",
                                                    art = "art/T_Flesh_Ripper",
                                                    text = "Gain <sprite name=\"health_2\">"
                                                }
                                            ),
                                            tags = {gainHealth2Tag}
                                        }
                                    }
                                }
                        )),
                        trigger = autoTrigger,
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Warhammer",
                    art = "art/T_Flesh_Ripper",
                    frame = "frames/Cleric_CardFrame",
                    text = "Gain <sprite name=\"combat_2\"> or Gain <sprite name=\"health_2\"> \n <size=50%>If you have played a weapon this turn, gain both.</size>",
                }
            )
        }
    )
end
-- END Warhammer CARD

-- START Crusader CARD
function paladin_crusader_carddef()
    return createChampionDef(
        {
            id = "paladin_Crusader",
            name = "Crusader",
            acquireCost = 0,
            health = 2,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "Crusader_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = pushChoiceEffect(
                            {
                                choices = {
                                    {
                                        effect = gainGoldEffect(1),
                                        layout = layoutCard(
                                            {
                                                title = "Crusader",
                                                art = "avatars/man_at_arms",
                                                text = ("{1 gold}")
                                            }
                                        ),
                                        tags = {gainGoldTag}
                                    },
                                    {
                                        effect = gainHealthEffect(1),
                                        layout = layoutCard(
                                            {
                                                title = "Crusader",
                                                art = "avatars/man_at_arms",
                                                text = ("{1 health}")
                                            }
                                        ),
                                        tags = {gainHealthTag}
                                    }
                                }
                            }
                        )
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Crusader",
                    art = "avatars/man_at_arms",
                    frame = "frames/Cleric_CardFrame",
                    text = "<size=250%><pos=-5%><sprite name=\"expend\"></pos></size><size=175%><pos=25%><voffset=.2em><sprite name=\"gold_1\"> or <sprite name=\"health_1\"></size></voffset>",
                    health = 2,
                    isGuard = true
                }
            )
        }
    )
end
-- END Crusader CARD

-- START Prayer SKILL 
function paladin_prayer_carddef()
    local cardLayout = createLayout({
        name = "Prayer",
        art = "icons/wind_storm",
        frame = "frames/Cleric_CardFrame",
        text = "<size=400%><line-height=0%><voffset=-.25em> <pos=-75%><sprite name=\"expend_2\"></size><line-height=135%> \n <voffset=2em><size=120%><pos=10%>Gain <sprite name=\"health_3\">\n   Gain  <sprite name=\"combat_1\">"
    })

    return createSkillDef({
        id = "paladin_prayer_skill",
        name = "Prayer",
        types = { paladinType, skillType },
        layout = cardLayout,
        layoutPath = "icons/wind_storm",
        abilities = {
            createAbility({
                id = "paladin_prayer_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
                promptType = showPrompt,
                effect = gainHealthEffect(3).seq(gainCombatEffect(1)),
                cost = goldCost(2),
            }),
        }
        
    })
end
-- END Prayer SKILL  

--START Sacred Oath ABILITY 
function paladin_sacred_oath_carddef()
	return createHeroAbilityDef({
		id = "sacred_oath",
		name = "Sacred Oath",
		types = { heroAbilityType },
        abilities = {
            createAbility( {
                id = "sacred_oath_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                promptType = showPrompt,
                layout = createLayout ({
                    name = "Sacred Oath",
                    art = "art/T_Devotion",
                    frame = "frames/Cleric_CardFrame",
                    text = "Prepare up to 3 champions in play."
                    }),
                effect = pushTargetedEffect({
                    desc = "Choose up to 3 champions in play. Prepare those champions",
                    validTargets = s.CurrentPlayer(CardLocEnum.InPlay).where(isCardChampion()),
                    min = 1,
                    max = 3,
                    targetEffect = prepareTarget(),
			    }),
                cost = sacrificeSelfCost,
            }),
        },
        layout = createLayout({
            name = "Sacred Oath",
            art = "art/T_Devotion",
            text = "Prepare up to 3 champions in play."
        }),
        layoutPath  = "art/T_Devotion",
	})
end	
-- END Sacred Oath ABILITY

function setupGame(g)
	registerCards(g, {
		witch_flash_freeze_carddef(),
		witch_cauldron_carddef(),
		siphon_life_def(),
		piercing_screech_def(),
        paladin_warhammer_carddef(),
        paladin_crusader_carddef(),
        paladin_prayer_carddef(),
        paladin_sacred_oath_carddef(),
	})

    standardSetup(g, {
        description = "Witch vs Paladin game. Witch created by Userkaffe, Paladin created by agentc13.",
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
				name = "Paladin",
				avatar = "cristov__the_just",
				health = 58,
				cards = {
					deck = {
						{qty = 1, card = cleric_spiked_mace_carddef()},
						{qty = 1, card = paladin_warhammer_carddef()},
						{qty = 1, card = paladin_crusader_carddef()},
						{qty = 1, card = ruby_carddef()},
						{qty = 5, card = gold_carddef()},
						{qty = 1, card = fighter_longsword_carddef()},
					},
					skills = {
						{qty = 1, card = paladin_prayer_carddef() },
						{qty = 1, card = paladin_sacred_oath_carddef()},
					},
					buffs = {
						drawCardsAtTurnEndDef(),
						discardCardsAtTurnStartDef(),
						fatigueCount(40, 1, "FatigueP1")
					}
				}
			}         
        }
    })
end

function endGame(g)
end