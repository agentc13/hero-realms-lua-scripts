--[[
Paladin Custom Class

Starting Cards 
Longsword (from Fighter - 3 dmg)(weapon)
Spiked Mace (from Cleric - 2 dmg, 1g)(weapon)
Warhammer (2 dmg or 2 heal, both if another wapon is in play)(weapon)
Crusader (2 Guard, 1g or 1 heal) (champion)
Gold x 5 (item)
Ruby x 1 (item)

Level 3 Skill
Smite (+1 dmg to a weapon in hand or play, up to double base dmg)

Level 3 Ability
Zealous Oath (Draw 1, You may stun one of your champions in play, gain combat equal to it's defense)
]]
require "herorealms"
require "decks"
require "stdlib"
require "stdcards"
require "hardai"
require "mediumai"
require "easyai"

-- START WARHAMMER CARD, NEED TO WORK OUT TRIGGER TO APPLY BOTH EFFECTS
function paladin_warhammer_carddef()
    return createActionDef(
        {
            id = "paladin_warhammer",
            name = "Warhammer",
            types = {weaponType, noStealType, paladinType, itemType, meleeWeaponType, hammerType},
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "paladin_warhammer",
                        layout = cardLayout,
                        effect = pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = gainCombatEffect(2),
                                            layout = layoutCard(
                                                {
                                                    title = "Warhammer",
                                                    art = "icons/cleric_brightstar_shield",
                                                    text = ("{2 combat}")
                                                }
                                            ),
                                            tags = {}
                                        },
                                        {
                                            effect = gainHealthEffect(2),
                                            layout = layoutCard(
                                                {
                                                    title = "Warhammer",
                                                    art = "icons/cleric_brightstar_shield",
                                                    text = ("{2 health}")
                                                }
                                            ),
                                            tags = {gainHealth2Tag}
                                        }
                                    }
                                }
                            ),
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
                    text = "Deal 2 dmg or gain 2 health"
                }
            )
        }
    )
end
-- END WARHAMMER

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
                                        tags = {}
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
                                        tags = {gainHealthTag, gainGoldTag}
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
                    text = '<voffset=.5em><size=200%><sprite name=\"expend\"></size><br></line-height><size=150%><sprite name=\"gold_1\"></size>or<size=150%> <sprite name=\"health_1\"></size>',
                    health = 2,
                    isGuard = true
                }
            )
        }
    )
end
-- END Crusader CARD

--[[ START Smite SKILL
function paladin_smite_carddef()
	return createSkillDef({
        id = "paladin_smite",
        name = "Smite",
        types = { paladinType, skillType, spellType },
        abilities = {
            createAbility({
                id="smite_skill",
                trigger=uiTrigger,
                effect = pushTargetedEffect(
                    {
                        desc = "Choose a weapon to get +1 combat (permanent)",
                        validTargets = s.CurrentPlayer(CardLocEnum.InPlay),
                        min = 1,
                        max = 1,
                        targetEffect = grantCombatTarget(1, { SlotExpireEnum.Never }, nullEffect(), "shield"),
                        tags = {  }
                    }
                ),
                cost =  goldCost(2),
                check = selectLoc(currentInPlayLoc).where(isCardWeapon()).count().gte(1)
            })
        },
        layout = createLayout({
        name = "Smite",
        art = "art/T_Pillar_Of_Fire",
        frame = "frames/Cleric_CardFrame",
        text = "Elite<br><voffset=1em><space=-3.7em><voffset=0.2em><size=200%><sprite name=\"expend\"></size></voffset><pos=30%> <voffset=0.5em><line-height=40><space=-3.7em>Give a weapon +1 <sprite name=\"combat\"></voffset></voffset>"
    })
})
end

-- END Smite SKILL ]]



function setupGame(g)
    registerCards(
        g,
        {
            paladin_warhammer_carddef(),
            paladin_crusader_carddef(),
            --paladin_smite_carddef(),
            --paladin_zealous_fury_carddef(),
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
                        --{qty = 1, card = paladin_smite_carddef },
                        --{qty = 1, card = paladin_zealous_fury_def()}
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
    meta.name = "ac13_paladin_class"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/timot/OneDrive/Documents/Hero-Realms-Lua-Scripts/AC13/ac13_paladin_class.lua"
     meta.features = {
}

end