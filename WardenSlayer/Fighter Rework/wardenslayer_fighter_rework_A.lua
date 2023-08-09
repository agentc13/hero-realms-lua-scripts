require 'herorealms'
require 'decks'
require 'stdlib'
require 'timeoutai'
require 'hardai_2'
require 'aggressiveai'

--=======================================================================================================
--Skills/Abilities
function dish_and_take_def()
    --Level 6
	return createSkillDef({
		id = "dish_and_take",
		name = "Dish and take",
		cardTypeLabel = "Skill",
		types = { skillType },
        abilities = {
			createAbility({
				id = "DishActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Dish and Take",
					art = "art/T_Rally_The_Troops",      
                xmlText = [[
                    <vlayout>
                        <hlayout flexibleheight="1">
                            <box flexiblewidth="1">
                                <tmpro text="{expend_2}" fontsize="72"/>
                            </box>
                            <vlayout flexiblewidth="6">
                                <box flexibleheight="1">
                                    <tmpro text="{combat_3}" fontsize="42" />
                                </box>
                                <box flexibleheight="1">
                                    <tmpro text="Gain Toughness 3 until your next turn." fontsize="24" />
                                </box>
                            </vlayout>
                        </hlayout>
                    </vlayout>
                    ]],
				}),
                effect = gainToughnessEffect(3).seq(gainCombatEffect(3)),
				cost = goldCost(2)
			})
		},
		layout = createLayout({
			name = "Dish and Take",
			art = "art/T_Rally_The_Troops",        
            xmlText = [[
                <vlayout>
                    <hlayout flexibleheight="1">
                        <box flexiblewidth="1">
                            <tmpro text="{expend_2}" fontsize="72"/>
                        </box>
                        <vlayout flexiblewidth="6">
                            <box flexibleheight="1">
                                <tmpro text="{combat_3}" fontsize="42" />
                            </box>
                            <box flexibleheight="1">
                                <tmpro text="Gain Toughness 3 until your next turn." fontsize="24" />
                            </box>
                        </vlayout>
                    </hlayout> 
                </vlayout>
                ]],
		}),
		layoutPath= "art/T_Rally_The_Troops"
	})
end	

--=======================================================================================================
--Cards
function better_shield_bearer_carddef()
    --Level 5
	local cardLayout = createLayout({
		name = "Better Shield Bearer",
		art = "art/T_Fighter_Seasoned_Shield_Bearer",
        -- art = "art/T_Shield_Bearer",
		frame = "frames/Warrior_CardFrame",
		cardTypeLabel = "Champion",
		types = { championType, noStealType },
        xmlText = [[
            <vlayout>
                <hlayout flexibleheight="1">
                    <vlayout flexiblewidth="7">
                        <box flexibleheight="1">
                            <tmpro text="When Stunned" fontsize="32" />
                        </box>
                        <box flexibleheight="1">
                            <tmpro text="{health_2}" fontsize="52" />
                        </box>
                    </vlayout>
                </hlayout>
            </vlayout>
            ]],
    })
	return createChampionDef({
		id = "better_shield_bearer",
		name = "Better Shield Bearer",
		acquireCost = 0,
		-- health = 3,
        health = 4,
		isGuard = true,
		layout = cardLayout,
		factions = {},
		abilities = {
			createAbility({
				id = "bsbMain",
				trigger = onStunTrigger,
				effect = healPlayerEffect(ownerPid,2)
			})
		}
	})
end

function econ_shield_bearer_carddef()
    --Level 5
	local cardLayout = createLayout({
		name = "Better Shield Bearer",
		art = "art/T_Fighter_Seasoned_Shield_Bearer",
        -- art = "art/T_Shield_Bearer",
		frame = "frames/Warrior_CardFrame",
		cardTypeLabel = "Champion",
		types = { championType, noStealType },
        xmlText = [[
            <vlayout>
                <hlayout flexibleheight="1">
                    <box flexiblewidth="1">
                        <tmpro text="{expend}" fontsize="65"/>
                    </box>
                    <box flexiblewidth="6">
                        <tmpro text="{gold_1}&lt;size=0%&gt;" fontsize="52" />
                    </box>
                </hlayout>
            </vlayout>
            ]],
    })
	return createChampionDef({
		id = "econ_shield_bearer",
		name = "Better Shield Bearer",
		acquireCost = 0,
        health = 5,
		isGuard = true,
		layout = cardLayout,
		factions = {},
		abilities = {
			createAbility({
				id = "esbMain",
				trigger = autoTrigger,
                cost = expendCost,
				effect = gainGoldEffect(1)
			})
		}
	})
end

--=======================================================================================================
--Armor
function zzz_cleric_shining_breastplate_carddef()
    local cardLayout = createLayout({
        name = "Hunters Cloak",
        art = "icons/ranger_hunters_cloak",
        frame = "frames/Ranger_armor_frame",
        text = "Elite<br><voffset=1em><space=-3.7em><voffset=0.2em><size=200%><sprite name=\"expend\"></size></voffset><pos=30%> <voffset=0.5em><line-height=40><space=-3.7em>Stun a<br>champion</voffset></voffset>"
    })
    return createMagicArmorDef({
        id = "ranger_hunters_cloak",
        name = "Shining Breastplate",
        types = { clericType, magicArmorType, treasureType, chestType },
        layout = cardLayout,
        layoutPath = "icons/ranger_hunters_cloak",
        abilities = {
            createAbility({
                id = "ranger_hunters_cloak",
                layout = loadLayoutTexture("Textures/ranger_hunters_cloak"),
                layout = cardLayout,
                effect = addSlotToTarget(createCostChangeSlot(1, { endOfTurnExpiry })).apply(selectLoc(centerRowLoc)),
                trigger = uiTrigger,
                check =  minDamageTakenOpp(5).And(minHealthCurrent(30)),
                cost = expendCost,
            })
        }
    })
end

--=======================================================================================================
function setupGame(g)
	registerCards(g, {
        better_shield_bearer_carddef(),
        econ_shield_bearer_carddef(),
        dish_and_take_def(),
	})

    standardSetup(g, {
        description = "by WardenSlayer.",
        playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(),  createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
        players = {
            {
                id = plid1,
                -- isAi = true,
                startDraw = 3,
                name = "Fighter A",
                avatar="fighter_02",
                health = 60,
                cards = {
					deck = {
                        { qty=1, card=ruby_carddef()},
                        { qty=1, card=fighter_throwing_axe_carddef() },
                        { qty=1, card=fighter_longsword_carddef() },
                        -- { qty=1, card=better_shield_bearer_carddef() },
                        { qty=1, card=econ_shield_bearer_carddef() },
                        { qty=1, card=fighter_jagged_spear_carddef() },
                        { qty=6, card=gold_carddef() },
					},
					skills = {
						dish_and_take_def(),
						fighter_smashing_blow_carddef(),
                        zzz_cleric_shining_breastplate_carddef()
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
                isAi = true,
                startDraw = 5,
				name = "Fighter B",
                avatar="ambushers",
                health = 60,
                cards = {
					deck = {
                        { qty=1, card=ruby_carddef()},
                        { qty=1, card=fighter_throwing_axe_carddef() },
                        { qty=1, card=fighter_longsword_carddef() },
                        -- { qty=1, card=better_shield_bearer_carddef() },
                        { qty=1, card=econ_shield_bearer_carddef() },
                        { qty=1, card=fighter_jagged_spear_carddef() },
                        { qty=6, card=gold_carddef() },
					},
					skills = {
						dish_and_take_def(),
						fighter_smashing_blow_carddef(),
                        zzz_cleric_shining_breastplate_carddef()

					},
					buffs = {
						drawCardsCountAtTurnEndDef(5),
						discardCardsAtTurnStartDef(),
						fatigueCount(40, 1, "FatigueP2"),
					}
                }
            },            
        }
    })
end

function endGame(g)
end

-- Created by WardenSlayer



function setupMeta(meta)
    meta.name = "wardenslayer_fighter_rework_A"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/xTheC/Desktop/Git Repositories/hero-realms-lua-scripts/WardenSlayer/Fighter Rework/wardenslayer_fighter_rework_A.lua"
     meta.features = {
}

end