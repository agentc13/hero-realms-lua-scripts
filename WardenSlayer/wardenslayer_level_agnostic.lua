require 'herorealms'
require 'decks'
require 'stdlib'
require 'timeoutai'
require 'hardai_2'
require 'aggressiveai'

--=======================================================================================================
--Buffs
function customClassBuffDef()
	--
	local name = "You But Now A Fighter"
	local ef = setPlayerNameEffect(name, currentPid).seq(setPlayerAvatarEffect("fighter_01", currentPid))
	            .seq(gainMaxHealthEffect(currentPid, const(60).add(getPlayerMaxHealth(currentPid).negate())))
	            .seq(gainHealthEffect(999)).seq(sacrificeSelf())
	--Base Cards
	local ef3 = createCardEffect(gold_carddef(), currentDeckLoc).seq(createCardEffect(gold_carddef(), currentDeckLoc)).seq(createCardEffect(gold_carddef(), currentDeckLoc))
	             				.seq(createCardEffect(gold_carddef(), currentDeckLoc)).seq(createCardEffect(gold_carddef(), currentDeckLoc)).seq(createCardEffect(gold_carddef(), currentDeckLoc))
				 				.seq(createCardEffect(ruby_carddef(), currentDeckLoc)).seq(createCardEffect(fighter_throwing_axe_carddef(), currentDeckLoc))
				 				.seq(createCardEffect(fighter_longsword_carddef(), currentDeckLoc)).seq(createCardEffect(fighter_shield_bearer_carddef(), currentDeckLoc))
								.seq(createCardEffect(fighter_shoulder_bash_carddef(), currentSkillsLoc)).seq(createCardEffect(fighter_crushing_blow_carddef(), currentSkillsLoc))
								.seq(sacrificeSelf())
	--Level 4
	local ef4 = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("fighter_shoulder_bash")).take(1))
					.seq(createCardEffect(fighter_shoulder_smash_carddef(), currentSkillsLoc))
					.seq(sacrificeSelf())                          
    --Level 5
	local ef5 = transformTarget("fighter_seasoned_shield_bearer").apply(selectLoc(loc(currentPid, deckPloc)).where(isCardName("fighter_shield_bearer")).take(1))
					.seq(sacrificeSelf())
    --Level 6
	local ef6 = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("fighter_shoulder_smash")).take(1))
					.seq(createCardEffect(fighter_shoulder_crush_carddef(), currentSkillsLoc))
					.seq(sacrificeSelf())
	--Level 7
	local ef7 = createCardEffect(fighter_jagged_spear_carddef(), currentDeckLoc)
	                .seq(sacrificeSelf())
    --Level 8
	local ef8 = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("fighter_crushing_blow")).take(1))
					.seq(createCardEffect(fighter_smashing_blow_carddef(), currentSkillsLoc))
					.seq(sacrificeSelf())
	--Level 9
	local ef9 = createCardEffect(fighter_helm_of_fury_carddef(), currentSkillsLoc)
	                .seq(sacrificeSelf())
	--Level 10
	local ef10 = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("fighter_smashing_blow")).take(1))
					.seq(createCardEffect(fighter_devastating_blow_carddef(), currentSkillsLoc))
					.seq(sacrificeSelf())
	--Level 11
	local ef11 = transformTarget("fighter_rallying_flag").apply(selectLoc(loc(currentPid, deckPloc)).where(isCardName("gold")).take(1))
					.seq(sacrificeSelf())
	--Level 12
	local ef12 = gainMaxHealthEffect(currentPid, const(69).add(getPlayerMaxHealth(currentPid).negate()))
					.seq(gainHealthEffect(999)).seq(sacrificeSelf())
	--Level 13
	local ef13 = createCardEffect(fighter_bottle_of_rum_carddef(), currentDeckLoc)
	                .seq(sacrificeSelf())			
	--Level 14
	local ef14 = gainMaxHealthEffect(currentPid, const(78).add(getPlayerMaxHealth(currentPid).negate()))
					.seq(gainHealthEffect(999)).seq(sacrificeSelf())
	--Last
	local efShuffle = shuffleEffect(currentDeckLoc).seq(sacrificeSelf())
	--						
    return createGlobalBuff({
        id="custom_class_buff",
        name = "Custom Class",
        abilities = {
			createAbility({
                id="player_info_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "customClass"),
                effect = ef
            }),
			createAbility({
                id="starter_cards_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "customClass").And(getHeroLevel(currentPid).gte(3)),
                effect = ef3
            }),
			createAbility({
                id="level_4_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "customClass").And(getHeroLevel(currentPid).gte(4)),
                effect = ef4
            }),
			createAbility({
                id="level_5_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "customClass").And(getHeroLevel(currentPid).gte(5)),
                effect = ef5
            }),
			createAbility({
                id="level_6_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "customClass").And(getHeroLevel(currentPid).gte(6)),
				effect = ef6
            }),
			createAbility({
                id="level_7_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "customClass").And(getHeroLevel(currentPid).gte(7)),
                effect = ef7
            }),
			createAbility({
                id="level_8_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "customClass").And(getHeroLevel(currentPid).gte(8)),
                effect = ef8
            }),
			createAbility({
                id="level_9_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "customClass").And(getHeroLevel(currentPid).gte(9)),
                effect = ef9
            }),
			createAbility({
                id="level_10_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "customClass").And(getHeroLevel(currentPid).gte(10)),
                effect = ef10
            }),
			createAbility({
                id="level_11_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "customClass").And(getHeroLevel(currentPid).gte(11)),
                effect = ef11
            }),
			createAbility({
                id="level_12_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "customClass").And(getHeroLevel(currentPid).gte(12)),
                effect = ef12
            }),
			createAbility({
                id="level_13_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "customClass").And(getHeroLevel(currentPid).gte(13)),
                effect = ef13
            }),
			createAbility({
                id="level_14_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "customClass").And(getHeroLevel(currentPid).gte(14)),
                effect = ef14
            }),
			createAbility({
                id="shulle_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "customClass"),
                effect = efShuffle
            })
        }
    })
end

--=======================================================================================================
-- simple choice effect, showing two layouts and executing selected one, triggers at the game start
local function chooseTheClass()
    return cardChoiceSelectorEffect({
        id = "choose_the_class_s_a_r",
        name = "Choose a class",
        trigger = startOfTurnTrigger,
        upperTitle  = "Choose a class",
        lowerTitle  = "",
        effectFirst = sacrificeTarget().apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))).union(selectLoc(loc(currentPid, skillsPloc))))
					  .seq(addSlotToPlayerEffect(currentPid, createPlayerSlot({ key = "customClass", expiry = { Never } }))),
        effectSecond = nullEffect(),
        layoutFirst = createLayout({
            name = "Fighter Choice",
            art = "art/T_Fighter_Male",
			text = format("Play as a Level<br> {0} Fighter", { getHeroLevel(currentPid) })}),

        layoutSecond = createLayout({
            name = "Selected class",
            art = "art/T_Prism_RainerPetter",
            text = "Play as the character you selected when setting up the game." }),
		
        turn = 1
    })
end

local function goFirstEffect()
	return createGlobalBuff({
        id="draw_three_start_buff",
        name = "Go First",
        abilities = {
            createAbility({
                id="go_first_draw_effect",
                trigger = endOfTurnTrigger,
                effect = ElseEffect(
					getTurnsPlayed(oppPid).eq(1),
					nullEffectif(),
					drawCardsEffect(2)
				)
            })
        }
    })
end

--=======================================================================================================
function setupGame(g)
	registerCards(g, {
	})

    standardSetup(g, {
        description = "Example Script on how to setup a custom build by hero level.",
        playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(),  createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
        players = {
            {
                id = plid1,
                -- isAi = true,
                startDraw = 3,
				init = {
                    fromEnv = plid1
                },
                cards = {
					buffs = {
						chooseTheClass(),
						customClassBuffDef(),
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
				init = {
                    fromEnv = plid2
                },
                cards = {
					buffs = {
						chooseTheClass(),
						customClassBuffDef(),
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
    meta.name = "wardenslayer_level_agnostic"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/xTheC/Desktop/Git Repositories/hero-realms-lua-scripts/WardenSlayer/wardenslayer_level_agnostic.lua"
     meta.features = {
}

end