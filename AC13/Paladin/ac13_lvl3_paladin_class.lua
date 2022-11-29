
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
    registerCards(
        g,
        {
            paladin_warhammer_carddef(),
            paladin_crusader_carddef(),
            paladin_prayer_carddef(),
            paladin_sacred_oath_carddef(),
 
        }
    )

    standardSetup(
        g,
        {
            description = "Paladin Class (level 3). Created by agentc13.",
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
                            --chooseDifficulty(),
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
    meta.name = "ac13_lvl3_paladin_class"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "Z:/Projects/hero-realms-lua-scripts/AC13/Paladin/ac13_lvl3_paladin_class.lua"
     meta.features = {
}

end