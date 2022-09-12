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
Smite (1 dmg + 3 health)

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
                                    },
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

--START Zealous Devotion ABILITY 
function paladin_zealous_devotion_carddef()
	return createHeroAbilityDef({
		id = "zealous_devotion",
		name = "Zealous Devotion",
		types = { heroAbilityType },
        abilities = {
            createAbility( {
                id = "zealous_devotion_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                promptType = showPrompt,
                layout = createLayout ({
                    name = "Zealous Devotion",
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
            name = "Zealous Devotion",
            art = "art/T_Devotion",
            text = "Prepare up to 3 champions in play."
        }),
        layoutPath  = "art/T_Devotion",
	})
end	
-- END Zealous Devotion ABILITY

function setupGame(g)
    registerCards(
        g,
        {
            paladin_warhammer_carddef(),
            paladin_crusader_carddef(),
            paladin_prayer_carddef(),
            paladin_zealous_devotion_carddef(),
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
                            {qty = 1, card = paladin_crusader_carddef()},
                            {qty = 1, card = ruby_carddef()},
                            {qty = 5, card = gold_carddef()},
                        },
                        skills = {
                        {qty = 1, card = paladin_prayer_carddef() },
                        {qty = 1, card = paladin_zealous_devotion_carddef()}
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
    meta.path = "C:/Users/timot/OneDrive/Documents/Hero-Realms-Lua-Scripts/AC13/ac13_paladin_custom_class.lua"
     meta.features = {
}

end