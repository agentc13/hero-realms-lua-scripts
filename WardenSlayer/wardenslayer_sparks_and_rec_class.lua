require 'herorealms'
require 'decks'
require 'stdlib'
require 'timeoutai'
require 'hardai_2'
require 'aggressiveai'

-- this script allows you to play as 'S&R' custom class

function bird_dog_def()
	return createSkillDef({
		id = "bird_dog",
		name = "Bird Doggin'",
		cardTypeLabel = "Skill",
		types = { skillType },
        abilities = {
			createAbility({
				id = "birdDogActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Bird Doggin'",
					art = "art/T_Spark",
					text = "<size=400%><line-height=0%><voffset=-0.6em> <pos=-95%><sprite name=\"expend_2\"></size><line-height=100%> \n <voffset=1.8em><size=80%><pos=8%>Draw 1 card and reveal\n<pos=9%> it. If it's an action,\n<pos=9%> draw another card and \n<pos=8%>keep talking for 10 more minutes"
				}),
                effect = drawToLocationEffect(1, currentRevealLoc).seq(ifElseEffect(
																		selectLoc(currentRevealLoc).where(isCardAction()).count().gte(1),
																		drawCardsEffect(1),
																		nullEffect()
																	)).seq(moveTarget(currentHandLoc).apply(selectLoc(currentRevealLoc))),
				cost = goldCost(2)
			})
		},
		layout = createLayout({
			name = "Bird Doggin'",
			art = "art/T_Spark",
			text = "<size=400%><line-height=0%><voffset=-0.6em> <pos=-95%><sprite name=\"expend_2\"></size><line-height=100%> \n <voffset=1.8em><size=80%><pos=8%>Draw 1 card and reveal\n<pos=9%> it. If it's an action,\n<pos=9%> draw another card and \n<pos=8%>keep talking for 10 more minutes"
		}),
		layoutPath= "art/T_Spark"
	})
end		

function patron_shoutout_def()
	return createDef({
		id = "patron_shoutout",
		name = "Shoutout to the Patrons",
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
					name = "Shoutout to the Patrons",
					art = "art/T_Command",
					text = "<size=200%><pos=-30%><sprite name=\"scrap\"></size><space=1.7em><size=250%><sprite name=\"gold_3\"></size>"
				}),
				effect = gainGoldEffect(3),
				cost = sacrificeSelfCost
			})
		},
		layoutPath= "art/T_Command"
	})
end	

function hero_dash_helper_carddef()
	local cardLayout = createLayout({
		name = "Hero-Helper Plug",
		art = "art/T_Stone_Guardian",
		frame = "frames/Warrior_CardFrame",
		cardTypeLabel = "Champion",
		types = { championType, noStealType },
		text = "<size=160%><pos=-40%><sprite name=\"expend\"></size><size=180%><voffset=12><space=1.36em><sprite name=\"combat_2\"></voffset></size><line-height=40%><br>_________________</line-height><br><size=75%><voffset=-3>Visit: Hero-Helper.com</voffset></size>"
	})
	return createChampionDef({
		id = "hero_helper",
		name = "Hero-Helper",
		acquireCost = 0,
		health = 2,
		isGuard = true,
		layout = cardLayout,
		factions = {},
		abilities = {
			createAbility({
				id = "hhMain",
				trigger = autoTrigger,
				cost = expendCost,
				effect = gainCombatEffect(2)
			})
		}
	})
end

function situational_card_carddef()
	local cardLayout = createLayout({
		name = "Situational Card",
		art = "art/T_Elixir_Of_Fortune",
		frame = "frames/Cleric_Frames/Cleric_Treasure_CardFrame",
		cardTypeLabel = "Item",
		text = "<size=150%><sprite name=\"gold_1\"><line-height=40%><br>_______________</line-height><br><size=75%><voffset=-3>I would buy this over<br> Tithe Priest.</voffset></size>"
	})
	
	return createDef({
		id = "situational_card",
		name = "Situational Card",
		acquireCost = 0,
		cardTypeLabel = "Item",
		types = { itemType, noStealType },
		layout = cardLayout,
		playLocation = castPloc,
		abilities = {
			createAbility({
				id = "situationMain",
				trigger = autoTrigger,
				effect = gainGoldEffect(1)
			}),
		}
	})
end

function wwyd_carddef()
	local cardLayout = createLayout({
		name = "WWYD?",
		art = "art/T_Edge_Of_The_Moat",
		frame = "frames/Ranger_CardFrame",
		cardTypeLabel = "Action",
		text = "<size=150%><sprite name=\"combat_3\"><size=80%>  or  <size=150%><sprite name=\"health_4\"><size=80%><br>If you have Street Thug in play, do both."
	})
	local faceLayout = layoutCard({
		title = "WWYD?",
		art = "art/T_Blazing_Fire",
		text = "<size=300%><sprite name=\"combat_3\">"
	})
	local removalLayout = layoutCard({
		title = "WWYD?",
		art = "art/T_Evangelize",
		text =  "<size=300%><sprite name=\"health_4\">"
	})
	
	return createDef({
		id = "wwyd_card",
		name = "WWYD?",
		acquireCost = 0,
		cardTypeLabel = "Action",
		types = { actionType, noStealType },
		layout = cardLayout,
		playLocation = castPloc,
		abilities = {
			createAbility({
				id = "noChampMain",
				trigger = autoTrigger,
				effect = ifElseEffect(selectLoc(currentInPlayLoc).where(isCardName("street_thug")).count().gte(1),
				gainCombatEffect(4).seq(gainHealthEffect(4)),
				pushChoiceEffect({
					choices = {
						{
							effect = gainCombatEffect(4),
							layout = faceLayout
						},
						{
							effect = gainHealthEffect(4),
							layout = removalLayout
						}
					}
				})
			)
			}),
		}
	})
end

function nostra_dbl_damus_carddef()
	local cardLayout = createLayout({
		name = "NostraDblDamus",
		art = "art/T_Channel",
		frame = "frames/Wizard_CardFrame",
		cardTypeLabel = "Champion",
		types = { championType, noStealType },
		text = "<size=140%><pos=-40%><sprite name=\"expend\"></size><size=160%><voffset=12><space=1.36em><sprite name=\"gold_1\"></voffset></size><br><size=50%>Reveal the top card of your<br> deck. Discard it or put it back<br> on the top of your deck.</voffset></size><line-height=30%><br>_________________</line-height><br><size=45%><voffset=-3>Visions of Thandar!</voffset></size>"
	})
	return createChampionDef({
		id = "nostra_dbl_damus",
		name = "NostraDblDamus",
		acquireCost = 0,
		health = 2,
		isGuard = false,
		layout = cardLayout,
		factions = {},
		abilities = {
			createAbility({
				id = "nddOnPlay",
				trigger = uiTrigger,
				cost = expendCost,
				effect = gainGoldEffect(1).seq(drawToLocationEffect(1, currentRevealLoc)
				.seq(promptSplit({
				   selector = selectLoc(currentRevealLoc),
				   take = const(4),
				   sort = const(2),
				   ef1 =moveToTopDeckTarget(true),
				   ef2 = discardTarget(),
				   header = "Visions of Thandar",
				   description = "Look at the top card of your deck. You may put it in your discard pile, or put it back on the top of your deck.",
				   pile1Name = "Top of Deck",
				   pile2Name = "Discard Pile",
				   eff1Tags = { buytopdeckTag },
				   eff2Tags = { cheapestTag }
			   }))
			)
			})
		}
	})
end

function blank_to_my_blank_carddef()
	local cardLayout = createLayout({
		name = "The _____ To My _____ ",
		art = "art/T_Paladin_Sword",
		frame = "frames/Warrior_CardFrame",
		cardTypeLabel = "Item",
		text = "<size=200%><sprite name=\"gold_1\"><space=0.7em><sprite name=\"combat_2\"></size>"
	})
	
	return createDef({
		id = "b2mb_card",
		name = "The Blank To My Blank",
		acquireCost = 0,
		cardTypeLabel = "Item",
		types = { itemType, noStealType },
		layout = cardLayout,
		playLocation = castPloc,
		abilities = {
			createAbility({
				id = "b2mbMain",
				trigger = autoTrigger,
				effect = gainGoldEffect(1).seq(gainCombatEffect(2)),
			}),
		}
	})
end

function congrats_youre_a_nerd_carddef()
	local cardLayout = createLayout({
		name = "Congrats, You're A Nerd",
		art = "art/treasures/T_Wise_Cat_Familiar",
		frame = "frames/Wizard_CardFrame",
		cardTypeLabel = "Action",
		text = "<size=100%>Opponent discards 1.<line-height=40%><br>_______________</line-height><br><size=50%><voffset=-3>When this card goes into your discard pile, put it on the bottom of your deck.</voffset></size>"
	})
	
	return createDef({
		id = "congrats_youre_a_nerd_card",
		name = "Congrats, You're A Nerd",
		acquireCost = 0,
		cardTypeLabel = "Action",
		types = { actionTypeType, noStealType },
		layout = cardLayout,
		playLocation = castPloc,
		abilities = {
			createAbility({
				id = "congratsMain",
				trigger = autoTrigger,
				effect = oppDiscardEffect(1),
			}),
			createAbility({
				id = "congratsBottomDeck",
				trigger = onDiscardTrigger,
				effect = moveToBottomDeckTarget(false).apply(selectSource()),
			}),
			createAbility({
				id = "congratsBottomDeck2",
				trigger = endOfTurnTrigger,
				effect = moveToBottomDeckTarget(false).apply(selectSource()),
			}),
		}
	})
end

--=======================================================================================================
function setupGame(g)
	registerCards(g, {
		hero_dash_helper_carddef(),
		situational_card_carddef(),
		bird_dog_def(),
		patron_shoutout_def(),
		wwyd_carddef(),
		nostra_dbl_damus_carddef(),
		blank_to_my_blank_carddef(),
		congrats_youre_a_nerd_carddef(),
	})

    standardSetup(g, {
        description = "The Sparks & Recreation Class.<br> Check the pod out @www.realmsrising.com/sparks-and-recreation.<br>Created by WardenSlayer.",
        playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(),  createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
        players = {
            {
                id = plid1,
                startDraw = 3,
                name = "Sparks & Recreation",
                avatar="ambushers",
                health = 55,
                cards = {
					deck = {
                      { qty=1, card=hero_dash_helper_carddef() },
					  { qty=1, card=nostra_dbl_damus_carddef() },
					  { qty=1, card=wwyd_carddef()},
					  { qty=1, card=blank_to_my_blank_carddef()},
					  { qty=1, card=congrats_youre_a_nerd_carddef()},
					  { qty=5, card=situational_card_carddef() },
					},
					skills = {
						{ qty=1, card=bird_dog_def() },
						{ qty=1, card=patron_shoutout_def() }
					},
					buffs = {
						drawCardsCountAtTurnEndDef(5),
						discardCardsAtTurnStartDef(),
						fatigueCount(40, 1, "FatigueP1"),
					}
                }
            },
            {
                id = plid2,
                startDraw = 5,
				name = "Sparks & Recreation",
                avatar="ambushers",
                health = 55,
                cards = {
					deck = {
                      { qty=1, card=hero_dash_helper_carddef() },
					  { qty=1, card=nostra_dbl_damus_carddef() },
					  { qty=1, card=wwyd_carddef()},
					  { qty=1, card=blank_to_my_blank_carddef()},
					  { qty=1, card=congrats_youre_a_nerd_carddef()},
					  { qty=5, card=situational_card_carddef() },
					},
					skills = {
						{ qty=1, card=bird_dog_def() },
						{ qty=1, card=patron_shoutout_def() }
					},
					buffs = {
						drawCardsCountAtTurnEndDef(5),
						discardCardsAtTurnStartDef(),
						fatigueCount(40, 1, "FatigueP1"),
					}
                }
            }            
        }
    })
end

function endGame(g)
end

-- Created by WardenSlayer

function setupMeta(meta)
    meta.name = "wardenslayer_sparks_and_rec_class"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/xTheC/Desktop/Git Repositories/hero-realms-lua-scripts/WardenSlayer/wardenslayer_sparks_and_rec_class.lua"
     meta.features = {
}

end