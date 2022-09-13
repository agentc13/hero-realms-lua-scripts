--[[
Paladin Custom Class

Starting Cards 
Longsword (from Fighter - 3 dmg)(weapon)
Spiked Mace (from Cleric - 2 dmg, 1g)(weapon)
Warhammer (2 dmg or 2 heal, both if another weapon is in play)(weapon)
Crusader (2 Guard, 1g or 1 heal) (champion)
Gold x 5 (item)
Ruby x 1 (item)

Level 3 Skill 
Prayer (1 dmg + 3 health)

Level 3 Ability
Zealous Oath (Prepare up to 3 champions)
]]

require "herorealms"
require "decks"
require "stdlib"
require "stdcards"
require "hardai"
require "mediumai"
require "easyai"


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
                                                    art = "icons/cleric_brightstar_shield",
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
                                                    art = "icons/cleric_brightstar_shield",
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
                    art = "zoomedbuffs/cleric_brightstar_shield",
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
                                        effect = gainCombatEffect(1),
                                        layout = layoutCard(
                                            {
                                                title = "Crusader",
                                                art = "avatars/man_at_arms",
                                                text = ("{1 combat}")
                                            }
                                        ),
                                        tags = {gainCombatTag}
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
                    text = "<size=250%><pos=-5%><sprite name=\"expend\"></pos></size><size=175%><pos=25%><voffset=.2em><sprite name=\"combat_1\"> or <sprite name=\"health_1\"></size></voffset>",
                    health = 2,
                    isGuard = true
                }
            )
        }
    )
end
-- END Crusader CARD

-- START Smite SKILL 
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
-- END Smite SKILL  

-- START Divine Smite SKILL 
function paladin_divine_smite_carddef()
    local cardLayout = createLayout({
        name = "Divine Smite",
        art = "icons/wind_storm",
        frame = "frames/Cleric_CardFrame",
        text = "<size=400%><line-height=0%><voffset=-.25em> <pos=-75%><sprite name=\"expend_2\"></size><line-height=135%> \n <voffset=2em><size=120%><pos=10%>Gain <sprite name=\"health_3\">\n   Gain  <sprite name=\"combat_2\">"
    })

    return createSkillDef({
        id = "paladin_divine_smite_skill",
        name = "Divine Smite",
        types = { paladinType, skillType },
        layout = cardLayout,
        layoutPath = "icons/wind_storm",
        abilities = {
            createAbility({
                id = "paladin_divine_smite_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
                effect = gainHealthEffect(3).seq(gainCombatEffect(2)),
                cost = goldCost(2),
            }),
        }
        
    })
end
-- END Divine Smite SKILL 

-- START Lay On Hands SKILL 
function paladin_lay_on_hands_carddef()
    local cardLayout = createLayout({
        name = "Lay on Hands",
        art = "icons/wind_storm",
        frame = "frames/Cleric_CardFrame",
        text = "<size=400%><line-height=0%><voffset=-.25em> <pos=-75%><sprite name=\"expend_2\"></size><line-height=135%> \n <voffset=2em><size=120%><pos=10%>Gain <sprite name=\"health_4\">\n   Gain  <sprite name=\"combat_1\">"
    })

    return createSkillDef({
        id = "paladin_lay_on_hands_skill",
        name = "Lay on Hands",
        types = { paladinType, skillType },
        layout = cardLayout,
        layoutPath = "icons/wind_storm",
        abilities = {
            createAbility({
                id = "paladin_lay_on_hands_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
                effect = gainHealthEffect(4).seq(gainCombatEffect(1)),
                cost = goldCost(2),
            }),
        }
        
    })
end
-- END Lay On Hands SKILL 

-- START Prayer Of Devotion SKILL 
function paladin_prayer_of_devotion_carddef()
    local cardLayout = createLayout({
        name = "Prayer of Devotion",
        art = "icons/wind_storm",
        frame = "frames/Cleric_CardFrame",
        text = "<size=400%><line-height=0%><voffset=-.25em> <pos=-75%><sprite name=\"expend_2\"></size><line-height=135%> \n <voffset=2em><size=120%><pos=10%>Gain <sprite name=\"health_3\">\n   Gain  <sprite name=\"combat_1\">"
    })

    return createSkillDef({
        id = "paladin_prayer_of_devotion_skill",
        name = "Prayer of Devotion",
        types = { paladinType, skillType },
        layout = cardLayout,
        layoutPath = "icons/wind_storm",
        abilities = {
            createAbility({
                id = "paladin_prayer_of_devotion_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
                effect = gainHealthEffect(3).seq(gainCombatEffect(3)),
                cost = goldCost(2),
            }),
        }
        
    })
end
-- END Prayer of Devotion SKILL

-- START Consecration SKILL 
function paladin_consecration_carddef()
    local cardLayout = createLayout({
        name = "Consecration",
        art = "icons/wind_storm",
        frame = "frames/Cleric_CardFrame",
        text = "<size=400%><line-height=0%><voffset=-.25em> <pos=-75%><sprite name=\"expend_2\"></size><line-height=135%> \n <voffset=2em><size=120%><pos=10%>Gain <sprite name=\"health_4\">\n   Gain  <sprite name=\"combat_2\">"
    })

    return createSkillDef({
        id = "paladin_consecration_skill",
        name = "Consecration",
        types = { paladinType, skillType },
        layout = cardLayout,
        layoutPath = "icons/wind_storm",
        abilities = {
            createAbility({
                id = "paladin_consecration_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
                effect = gainHealthEffect(4).seq(gainCombatEffect(2)),
                cost = goldCost(2),
            }),
        }
        
    })
end
-- END Consecration SKILL

-- START Prayer of Healing SKILL 
function paladin_prayer_of_healing_carddef()
    local cardLayout = createLayout({
        name = "Prayer of Healing",
        art = "icons/wind_storm",
        frame = "frames/Cleric_CardFrame",
        text = "<size=400%><line-height=0%><voffset=-.25em> <pos=-75%><sprite name=\"expend_2\"></size><line-height=135%> \n <voffset=2em><size=120%><pos=10%>Gain <sprite name=\"health_5\">\n   Gain  <sprite name=\"combat_1\">"
    })

    return createSkillDef({
        id = "paladin_prayer_of_healing_skill",
        name = "Prayer of Healing",
        types = { paladinType, skillType },
        layout = cardLayout,
        layoutPath = "icons/wind_storm",
        abilities = {
            createAbility({
                id = "paladin_prayer_of_healing_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
                effect = gainHealthEffect(5).seq(gainCombatEffect(1)),
                cost = goldCost(2),
            }),
        }
        
    })
end
-- END Prayer of Healing SKILL 

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
                    desc = "Choose up to 3 championsin play. Prepare those champions",
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

-- START Oath of Devotion ABILITY 
function paladin_oath_of_devotion_carddef()
	return createHeroAbilityDef({
		id = "oath_of_devotion",
		name = "Oath of Devotion",
		types = { heroAbilityType },
        abilities = {
            createAbility( {
                id = "oath_of_devotion_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                promptType = showPrompt,
                layout = createLayout ({
                    name = "Oath of Devotion",
                    art = "art/T_Devotion",
                    text = "Prepare up to 3 champions in play. Those champions gain +1 <sprite name=\"shield\"> until they leave play"
                    }),
                effect = pushTargetedEffect({
                    desc = "Choose up to 3 champions in play. Prepare those champions and they gain +1 defense until they leave play.",
                    validTargets = s.CurrentPlayer(CardLocEnum.InPlay).where(isCardChampion()),
                    min = 1,
                    max = 3,
                    targetEffect = prepareTarget().seq(grantHealthTarget(1, { SlotExpireEnum.LeavesPlay }, nullEffect(), "shield")),
			    }),
                cost = sacrificeSelfCost,
            }),
        },
        layout = createLayout({
            name = "Oath of Devotion",
            art = "art/T_Devotion",
            text = "Prepare up to 3 champions in play. Those champions gain +1 <sprite name=\"shield\"> until they leave play"
        }),
        layoutPath  = "art/T_Devotion",
	})
end	
--END Oath of Devotion ABILITY

-- START Oath of Righteousness ABILITY
function paladin_oath_of_righteousness_carddef()
	return createHeroAbilityDef({
		id = "oath_of_righteousness",
		name = "Oath of Righteousness",
		types = { heroAbilityType },
        abilities = {
            createAbility( {
                id = "oath_of_righteousness_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                promptType = showPrompt,
                layout = createLayout ({
                    name = "Oath of Righteousness",
                    art = "art/T_Devotion",
                    text = "Prepare up to 3 champions in play. Gain +1 <sprite name=\"combat\"> for each champion you have in play." 
                    }),
                effect = pushTargetedEffect({
                    desc = "Choose up to 3 championsin play. Prepare those champions. Gain +1 Combat for each champion you have in play.",
                    validTargets = s.CurrentPlayer(CardLocEnum.InPlay).where(isCardChampion()),
                    min = 1,
                    max = 3,
                    targetEffect = prepareTarget().seq(gainCombatEffect(selectLoc(loc(currentPid, inPlayPloc)).count())),
			    }),
                cost = sacrificeSelfCost,
            }),
        },
        layout = createLayout({
            name = "Oath of Righteousness",
            art = "art/T_Devotion",
            text = "Prepare up to 3 champions in play. Gain +1 <sprite name=\"combat\"> for each champion you have in play"
        }),
        layoutPath  = "art/T_Devotion",
	})
end	
-- END Oath of Righteousness ABILITY

-- START Oath of Protection ABILITY
function paladin_oath_of_protection_carddef()
	return createHeroAbilityDef({
		id = "oath_of_protection",
		name = "Oath of Protection",
		types = { heroAbilityType },
        abilities = {
            createAbility( {
                id = "oath_of_protection_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                promptType = showPrompt,
                layout = createLayout ({
                    name = "Oath of Protection",
                    art = "art/T_Devotion",
                    text = "Prepare up to 3 champions in play. Those champions gain +1 <sprite name=\"shield\"> permanently."
                    }),
                effect = pushTargetedEffect({
                    desc = "Choose up to 3 champions in play. Prepare those champions and they gain +1 defense permanently.",
                    validTargets = s.CurrentPlayer(CardLocEnum.InPlay).where(isCardChampion()),
                    min = 1,
                    max = 3,
                    targetEffect = prepareTarget().seq(grantHealthTarget(1, { SlotExpireEnum.Never }, nullEffect(), "shield")),
			    }),
                cost = sacrificeSelfCost,
            }),
        },
        layout = createLayout({
            name = "Oath of Protection",
            art = "art/T_Devotion",
            text = "Prepare up to 3 champions in play. Those champions gain +1 <sprite name=\"shield\"> permanently."
        }),
        layoutPath  = "art/T_Devotion",
	})
end	
-- END Oath of Protection ABILITY

-- START Oath of Vengeance ABILITY
function paladin_oath_of_vengeance_carddef()
	return createHeroAbilityDef({
		id = "oath_of_vengeance",
		name = "Oath of Vengeance",
		types = { heroAbilityType },
        abilities = {
            createAbility( {
                id = "oath_of_vengeance_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                promptType = showPrompt,
                layout = createLayout ({
                    name = "Oath of Vengeance",
                    art = "art/T_Devotion",
                    text = "Expend up to 3 friendly champions in play. Gain <sprite name=\"combat\"> equal to their total <sprite name=\"shield\"> values. Draw 1."
                    }),
                effect = pushTargetedEffect({
                    desc = "Choose up to 3 friendly champions in play. Expend those champions and gain Combat equal to their total Defense. Draw a Card.",
                    validTargets = s.CurrentPlayer(CardLocEnum.InPlay).where(isCardChampion().And(isCardStunnable())),
                    min = 1,
                    max = 3,
                    targetEffect = expendTarget().seq(gainCombatEffect(selectTargets().sum(getCardHealth()))).seq(drawCardsEffect(1)),
			    }),
                cost = sacrificeSelfCost,
            }),
        },
        layout = createLayout({
            name = "Oath of Vengeance",
            art = "art/T_Devotion",
            text = "Expend up to 3 friendly champions in play. Gain <sprite name=\"combat\"> equal to their total <sprite name=\"shield\"> values. Draw 1."
        }),
        layoutPath  = "art/T_Devotion",
	})
end	
-- END Oath of Vengeance ABILITY

-- START Oath of Justice ABILITY
function paladin_oath_of_justice_carddef()
	return createHeroAbilityDef({
		id = "oath_of_justice",
		name = "Oath of Justice",
		types = { heroAbilityType },
        abilities = {
            createAbility( {
                id = "oath_of_justice_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                promptType = showPrompt,
                layout = createLayout ({
                    name = "Oath of Justice",
                    art = "art/T_Devotion",
                    text = "Prepare up to 3 champions in play. Gain <sprite name=\"combat_2\"> for each champion you have in play." 
                    }),
                effect = pushTargetedEffect({
                    desc = "Choose up to 3 championsin play. Prepare those champions. Gain +2 Combat for each champion you have in play.",
                    validTargets = s.CurrentPlayer(CardLocEnum.InPlay).where(isCardChampion()),
                    min = 1,
                    max = 3,
                    targetEffect = prepareTarget().seq(gainCombatEffect(selectLoc(loc(currentPid, inPlayPloc)).count().multiply(2))),
			    }),
                cost = sacrificeSelfCost,
            }),
        },
        layout = createLayout({
            name = "Oath of Justice",
            art = "art/T_Devotion",
            text = "Prepare up to 3 champions in play. Gain <sprite name=\"combat_2\"> for each champion you have in play."
        }),
        layoutPath  = "art/T_Devotion",
	})
end	
-- END Oath of Justice ABILITY

-- START Lightbringer CARD

function paladin_lightbringer_carddef()
    return createActionDef(
        {
            id = "paladin_lightbringer",
            name = "Lightbringer",
            types = {weaponType, noStealType, paladinType, itemType,holyRelicType, magicWeaponType, meleeWeaponType, swordType},
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "paladin_lightbringer",
                        trigger = autoTrigger,
                        effect = gainCombatEffect(3).seq(
                            pushTargetedEffect(
                                {
                                    desc = "Stun target champion.",
                                    min = 1,
                                    max = 1,
                                    validTargets = selectLoc(loc(oppPid, inPlayPloc)).where(isCardStunnable()),
                                    targetEffect =stunTarget()
                                }
                            )
                        ),
                        check = selectLoc(currentCastLoc).where(isCardType(weaponType)).count().gte(1),
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Lightbringer",
                    art = "art/T_Flesh_Ripper",
                    frame = "frames/Warrior_CardFrame",
                    text = '<size=50%><i>Replaces: Longsword/i></size><br><size=170%><sprite name="combat_3"></size> <br><size=75%>If you have played another weapon this turn, stun target champion.</size>'
                }
            )
        }
    )
end

-- END LightBringer Card


-- START Templar CARD 
function paladin_templar_carddef()
    return createChampionDef(
        {
            id = "paladin_templar",
            name = "Templar",
            acquireCost = 0,
            health = 3,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "templar_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = pushChoiceEffect(
                            {
                                choices = {
                                    {
                                        effect = gainCombatEffect(2),
                                        layout = layoutCard(
                                            {
                                                title = "Templar",
                                                art = "avatars/man_at_arms",
                                                text = ("{2 combat}")
                                            }
                                        ),
                                        tags = {gainCombatTag}
                                    },
                                    {
                                        effect = gainHealthEffect(2),
                                        layout = layoutCard(
                                            {
                                                title = "Templar",
                                                art = "avatars/man_at_arms",
                                                text = ("{2 health}")
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
                    name = "Templar",
                    art = "avatars/man_at_arms",
                    frame = "frames/Cleric_CardFrame",
                    text = "<size=250%><pos=-5%><sprite name=\"expend\"></pos></size><size=175%><pos=25%><voffset=.2em><sprite name=\"combat_2\"> or <sprite name=\"health_2\"></size></voffset>",
                    health = 3,
                    isGuard = true
                }
            )
        }
    )
end
-- END Templar CARD 


function setupGame(g)
    registerCards(
        g,
        {
            paladin_warhammer_carddef(),
            paladin_crusader_carddef(),
            paladin_prayer_carddef(),
            paladin_sacred_oath_carddef(),
            paladin_divine_smite_carddef(),
            paladin_lay_on_hands_carddef(),
            paladin_prayer_of_healing_carddef(),
            paladin_consecration_carddef(),
            paladin_prayer_of_devotion_carddef(),
            paladin_oath_of_devotion_carddef(),
            paladin_oath_of_protection_carddef(),
            paladin_oath_of_righteousness_carddef(),
            paladin_oath_of_vengeance_carddef(),
            paladin_oath_of_justice_carddef(),
            paladin_lightbringer_carddef()
        }
    )

    standardSetup(
        g,
        {
            description = "Paladin Class. Created by agentc13.",
            playerOrder = {plid1, plid2},
            ai = ai.CreateKillSwitchAi(createAggressiveAI(), createHardAi2()),
            timeoutAi = createTimeoutAi(),
            opponents = {{plid1, plid2}},
            players = {
                {
                    id = plid1,
                    startDraw = 3,
                    name = "Paladin",
                    avatar = "cristov__the_just",
                    health = 58,
                    cards = {
                        deck = {
                            {qty = 1, card = fighter_longsword_carddef()},
                            {qty = 1, card = cleric_spiked_mace_carddef()},
                            {qty = 1, card = paladin_warhammer_carddef()},
                            {qty = 1, card = paladin_templar_carddef()},
                            {qty = 1, card = ruby_carddef()},
                            {qty = 5, card = gold_carddef()},
                            {qty = 1, card = paladin_lightbringer_carddef()},
                        },
                        skills = {
                            {qty = 1, card = paladin_consecration_carddef() },
                            {qty = 1, card = paladin_oath_of_justice_carddef()}
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
        }
    )
end

function endGame(g)
end






function setupMeta(meta)
    meta.name = "ac13_paladin_custom_class"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "D:/HRLS/Hero-Realms-Lua-Scripts/AC13/ac13_paladin_custom_class.lua"
     meta.features = {
}

end