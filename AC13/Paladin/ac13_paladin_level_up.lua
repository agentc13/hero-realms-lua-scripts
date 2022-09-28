-- This file contains all the upgrades for the Paladin class. The scripting to "level up" is a WIP.
require "herorealms"
require "decks"
require "stdlib"
require "stdcards"
require "hardai"
require "mediumai"
require "easyai"
require "aggressiveai"


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
                        check = selectLoc(currentCastLoc).where(isCardType(weaponType)).count().gte(2),
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Lightbringer",
                    art = "icons/fighter_mighty_blow_OLD",
                    frame = "frames/Cleric_CardFrame",
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
                                        effect = gainGoldEffect(2),
                                        layout = layoutCard(
                                            {
                                                title = "Templar",
                                                art = "avatars/man_at_arms",
                                                text = ("{2 gold}")
                                            }
                                        ),
                                        tags = {gainGoldTag}
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
                                        tags = {gainHealth2Tag}
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
                    text = "<size=250%><pos=-5%><sprite name=\"expend\"></pos></size><size=175%><pos=25%><voffset=.2em><sprite name=\"gold_2\"> or <sprite name=\"health_2\"></size></voffset>",
                    health = 3,
                    isGuard = true
                }
            )
        }
    )
end
-- END Templar CARD 

-- START Jeweled Dagger CARD
function paladin_jeweled_dagger_carddef()
    return createActionDef(
        {
            id = "paladin_jeweled_dagger",
            name = "Jeweled Dagger",
            types = {weaponType, noStealType, paladinType, itemType, magicWeaponType, meleeWeaponType, daggerType},
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "paladin_jeweled_dagger_ab",
                        trigger = autoTrigger,
                        effect = gainCombatEffect(2).seq(gainGoldEffect(1))
                            
                    }
                ),
                createAbility(
                    {
                        id = "paladin_jeweled_dagger_sac",
                        trigger = uiTrigger,
                        cost = sacrificeSelfCost,
                        promptType= showPrompt,
                        effect = pushTargetedEffect(
                                {
                                    desc = "Sacrifice a card from your discard pile.",
                                    min = 0,
                                    max = 1,
                                    validTargets = selectLoc(loc(currentPid,discardPloc)),
                                    targetEffect =sacrificeTarget(),
                                 }),
                        layout = createLayout({
                            name = "Jeweled Dagger",
                            art = "art/T_Influence",
                            frame = "frames/Cleric_CardFrame",
                            text = '<size=170%><line-height=75%><sprite name="combat_2"> <sprite name=\"gold_1\"></line-height></size> \n<size=150%><line-height=50%><pos=-15%><sprite name=\"scrap\"><space=.3em></size><size=60%><voffset=1em>Sacrifice a card in your \ndiscard pile.</size></line-height>'
                        })

                    }
                )
            },
            layout = createLayout(
                {
                    name = "Jeweled Dagger",
                    art = "art/T_Influence",
                    frame = "frames/Cleric_CardFrame",
                    text = '<size=170%><line-height=75%><sprite name="combat_2"> <sprite name=\"gold_1\"></line-height></size> \n<size=150%><line-height=50%><pos=-15%><sprite name=\"scrap\"><space=.3em></size><size=60%><voffset=1em>Sacrifice a card in your \ndiscard pile.</size></line-height>'
                }
            )
        }
    )
end
-- END Jeweled Dagger CARD

-- START Blind Justice CARD
function paladin_blind_justice_carddef()
    return createActionDef(
        {
            id = "paladin_blind_justice",
            name = "Blind Justice",
            types = { itemType, noStealType},
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "paladin_blind_justice_ab",
                        trigger = autoTrigger,
                        effect = hitOpponentEffect(2).seq(damageTarget(1).apply(selectLoc(loc(oppPid, inPlayPloc)).where(isCardExpended().invert().And(isCardStunnable()))))
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Blind Justice",
                    art = "art/T_Pillar_Of_Fire",
                    frame = "frames/Cleric_CardFrame",
                    text = 'Deal 2 damage to opponent, and 1 damage to each opposing champion.'
                }
            )
        }
    )
end
-- END Blind Justice CARD

--START Guardian's Shield ARMOR  WIP
function paladin_guardians_shield_carddef()
    local cardLayout =
        createLayout(
        {
            name = "Guardian's Shield",
            art = "icons/cleric_brightstar_shield",
            frame = "frames/Warrior_CardFrame",
            text = ('<size=300%><line-height=0%><voffset=-.4em> <pos=-75%><sprite name="requiresHealth_20"></size><line-height=80%>\n <voffset=1.8em><size=80%><sprite name=\"expend\"> \n Gain 2 <sprite name="combat"> for\n  each champion\n  you have in\n  play.</size>')
        }
    )

    return createMagicArmorDef(
        {
            id = "guardians_shield",
            name = "Guardian's Shield",
            layout = cardLayout,
            layoutPath = "icons/cleric_brightstar_shield",
            abilities = {
                createAbility({
                    id = "paladin_guardians_shield_ab",
                    trigger = uiTrigger,
                    effect = gainCombatEffect(selectLoc(currentInPlayLoc).where(isCardChampion()).count().multiply(2)), 
                    check = minHealthCurrent(20).And(selectLoc(currentInPlayLoc).where(isCardChampion()).count().gte(1)),
                    cost = expendCost,
                    tags = {}
                })
            }
        }
    )
end
-- END Guardian's Shield ARMOR   ]]

-- START Gauntlets of Power ARMOR   
function paladin_gauntlets_of_power_carddef()
    local cardLayout =
        createLayout(
        {
            name = "Gauntlets of Power",
            art = "icons/wizard_spellcaster_gloves",
            frame = "frames/Cleric_armor_frame",
            text = ('<size=300%><line-height=0%><voffset=-.8em> <pos=-75%><sprite name="requiresHealth_20"></size><line-height=80%> \n <voffset=1.8em><size=80%> If you have dealt 5 <sprite name="combat"> to an opponent this turn. \n  Gain 2 <sprite name="health"> \n or Draw 1 \n then discard 1 </size>')
        }
    )

    return createMagicArmorDef(
        {
            id = "gauntlets_of_power",
            name = "Gauntlets of Power",
            layout = cardLayout,
            layoutPath = "icons/wizard_spellcaster_gloves",
            abilities = {
                createAbility(
                    {
                        id = "gauntlets_of_power",
                        layout = cardLayout,
                        effect = pushChoiceEffect(
                            {
                                choices = {
                                    {
                                        effect = drawCardsEffect(1).seq(
                                            pushTargetedEffect(
                                                {
                                                    desc = "Discard a card",
                                                    min = 1,
                                                    max = 1,
                                                    validTargets = selectLoc(currentHandLoc),
                                                    targetEffect = discardTarget()
                                                }
                                            )
                                        ),
                                        layout = layoutCard(
                                            {
                                                title = "Gauntlets of Power",
                                                art = "icons/wizard_spellcaster_gloves",
                                                text = ("Draw 1 then discard 1.")
                                            }
                                        ),
                                        tags = {cycle1Tag}
                                    },
                                    {
                                        effect = gainGoldEffect(1),
                                        layout = layoutCard(
                                            {
                                                title = "Gauntlets of Power",
                                                art = "icons/wizard_spellcaster_gloves",
                                                text = ("{1 gold}")
                                            }
                                        ),
                                        tags = { gainGold1Tag }
                                    }
                                }
                            }
                        ),
                        trigger = uiTrigger,
                        check = minDamageTakenOpp(5).And(minHealthCurrent(30)),
                        cost = expendCost,
                        tags = { draw1Tag, gainGold1Tag }
                    }
                )
            }
        }
    )
end
-- END Gauntlets of Power ARMOR

-- START Holy Relic UPGRADE
function paladin_holy_relic_carddef()
    return createActionDef(
        {
            id = "paladin_holy_relic",
            name = "Holy Relic",
            types = {itemType, actionType, noStealType},
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "paladin_holy_relic",
                        trigger = autoTrigger,
                        effect = gainGoldEffect(2).seq(gainHealthEffect(selectLoc(currentCastLoc).where(isCardType(weaponType)).count()))
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Holy Relic",
                    art = "icons/thief_swipe",
                    frame = "frames/Cleric_CardFrame",
                    text = '<size=200%><voffset=.4em><sprite name="gold_2"></voffset></size><line-height=70%><size=75%>\n+1 <sprite name="health"> for each weapon you have in play.</size></line-height>'
                }
            )
        }
    )
end
-- END Holy Relic UPGRADE

-- START Blessed Whetstone UPGRADE
function paladin_blessed_whetstone_carddef()
    return createActionDef(
        {
            id = "paladin_blessed_whetstone",
            name = "Blessed Whetstone",
            types = {itemType, actionType, noStealType},
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "paladin_blessed_whetstone",
                        trigger = autoTrigger,
                        effect = drawCardsEffect(1).seq(gainCombatEffect(selectLoc(currentCastLoc).where(isCardType(weaponType)).count()))
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Blessed Whetstone",
                    art = "icons/cunning_of_the_wolf",
                    frame = "frames/Cleric_CardFrame",
                    text = '<size=200%><voffset=.4em><sprite name="gold_2"></voffset></size><line-height=70%><size=75%>\n+1 <sprite name="health"> for each weapon you have in play.</size></line-height>'
                }
            )
        }
    )
end
-- END Blessed Whetstone UPGRADE

-- BEGIN UPGRADE CHOICES
function level4Upgrades()
    local ef = pushChoiceEffect({
		choices = {
			{
                --skills
				effect = pushChoiceEffect({
                    choices = {
                        {
                            -- Lay on Hands
                            effect = createCardEffect(paladin_lay_on_hands_carddef(), loc(currentPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("Prayer")))),
                            layout = createLayout({
                                name = "Lay on Hands",
                                art = "icons/wind_storm",
                                text = "<size=400%><line-height=0%><voffset=-.25em> <pos=-75%><sprite name=\"expend_2\"></size><line-height=135%> \n <voffset=2em><size=120%><pos=10%>Gain <sprite name=\"health_4\">\n   Gain  <sprite name=\"combat_1\">"
                            })
                        },
                        {
                            -- Prayer of Devotion
                            effect = createCardEffect(paladin_prayer_of_devotion_carddef(), loc(currentPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("Prayer")))),
                            layout = createLayout({
                                name = "Prayer of Devotion",
                                art = "icons/wind_storm",
                                text = "<size=400%><line-height=0%><voffset=-.25em> <pos=-75%><sprite name=\"expend_2\"></size><line-height=135%> \n <voffset=2em><size=120%><pos=10%>Gain <sprite name=\"health_3\">\n   Gain  <sprite name=\"combat_1\">"
                            })
                        },

                    },
                }),
				layout = layoutCard({
					title = "Upgrade Skill",
					art = "art/T_Seek_Revenge",
					text = "Upgrade your skill tree."
				}),
			},
			{
                -- abilities
				effect = pushChoiceEffect({
                    choices = {
                        {
                            -- Oath of Righteousness
                            effect = createCardEffect(paladin_oath_of_righteousness_carddef(), loc(currentPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("Sacred Oath")))),
                            layout = createLayout({
                                name = "Oath of Righteousness",
                                art = "art/T_Devotion",
                                text = "Prepare up to 3 champions in play. Gain +1 <sprite name=\"combat\"> for each champion you have in play"
                            }),
                        },
                        {
                            -- Oath of Devotion
                            effect = createCardEffect(paladin_oath_of_devotion_carddef(), loc(currentPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("Sacred Oath")))),
                            layout = createLayout({
                                name = "Oath of Devotion",
                                art = "art/T_Devotion",
                                text = "Prepare up to 3 champions in play. Those champions gain +1 <sprite name=\"shield\"> until they leave play"
                            }),
                        },

                    },
                }),
				layout = layoutCard({
					title = "Upgrade Ability",
					art = "art/T_Devotion",
					text = "Upgrade you Sacred Oath ability."
				}),
			},
            {
                -- Health
				effect = gainMaxHealthEffect(currentPid, 7).seq(healPlayerEffect(currentPid, 7)),
				layout = layoutCard({
					title = "Upgrade Health",
					art = "avatars/cristov__the_just",
					text = "Gain +7 Health"
				}),
			},
		}
	}).seq(sacrificeSelf())


    return createGlobalBuff({
        id="choose_difficulty",
        name = "Choose Difficulty",
        abilities = {
            createAbility({
                id="choose_difficulty",
                trigger = startOfGameTrigger,
                effect = ef
            })
        }
    })
end
-- END UPGRADE CHOICES ]]

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
            paladin_lightbringer_carddef(),
            paladin_jeweled_dagger_carddef(),
            paladin_holy_relic_carddef(),
            paladin_blessed_whetstone_carddef(),
            paladin_blind_justice_carddef(),
            paladin_guardians_shield_carddef(),
            paladin_gauntlets_of_power_carddef(),
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
                            --level4Upgrades(),
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
    meta.name = "ac13_paladin_level_up"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/agentc13/projects/hero-realms-lua-scripts/AC13/Paladin/ac13_paladin_level_up.lua"
     meta.features = {
}

end