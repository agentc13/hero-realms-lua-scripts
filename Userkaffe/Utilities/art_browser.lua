--browse all art currently available

require 'herorealms'
require 'decks'
require 'stdlib'
require 'stdcards'
require 'hardai'
require 'mediumai'
require 'easyai'

function quickCreate(id, art)
	return createActionDef({
		id = id,
		name = "",
		acquireCost = 0,
		abilities = {},
		layout = createLayout({
			name = art,
			art = art,
			frame = "frames/HR_CardFrame_Item_Generic",
			text = ""
		})
	})
end

function c1_carddef()
    return quickCreate("c1", "art/dark_sign")
end
function c2_carddef()
    return quickCreate("c2", "art/Gorg__Orc_Shaman")
end
function c3_carddef()
    return quickCreate("c3", "art/T_Angry_Skeleton")
end
function c4_carddef()
    return quickCreate("c4", "art/T_Barreling_Fireball")
end
function c5_carddef()
    return quickCreate("c5", "art/T_Battle_Cry")
end
function c6_carddef()
    return quickCreate("c6", "art/T_Bounty_Collection")
end
function c7_carddef()
    return quickCreate("c7", "art/T_Broadsides")
end
function c8_carddef()
    return quickCreate("c8", "art/T_Capsize")
end
function c9_carddef()
    return quickCreate("c9", "art/T_Captain_Goldtooth")
end
function c10_carddef()
    return quickCreate("c10", "art/T_Confused_Apparition")
end
function c11_carddef()
    return quickCreate("c11", "art/T_Cunning_Of_The_Wolf")
end
function c12_carddef()
    return quickCreate("c12", "art/T_Death_Touch")
end
function c13_carddef()
    return quickCreate("c13", "art/T_Devotion")
end
function c14_carddef()
    return quickCreate("c14", "art/T_Evangelize")
end
function c15_carddef()
    return quickCreate("c15", "art/T_Expansion")
end
function c16_carddef()
    return quickCreate("c16", "art/T_Explosive_Fireball")
end
function c17_carddef()
    return quickCreate("c17", "art/T_Feisty_Orcling")
end
function c18_carddef()
    return quickCreate("c18", "art/T_Fire_Bomb")
end
function c19_carddef()
    return quickCreate("c19", "art/T_Fire_Gem")
end
function c20_carddef()
    return quickCreate("c20", "art/T_Flesh_Ripper")
end
function c21_carddef()
    return quickCreate("c21", "art/T_Heist")
end
function c22_carddef()
    return quickCreate("c22", "art/T_Influence")
end
function c23_carddef()
    return quickCreate("c23", "art/T_Life_Force")
end
function c24_carddef()
    return quickCreate("c24", "art/T_Maroon")
end
function c25_carddef()
    return quickCreate("c25", "art/T_Maurader")
end
function c26_carddef()
    return quickCreate("c26", "art/T_Orc_Guardian")
end
function c27_carddef()
    return quickCreate("c27", "art/T_Orc_Riot")
end
function c28_carddef()
    return quickCreate("c28", "art/T_Pillar_Of_Fire")
end
function c29_carddef()
    return quickCreate("c29", "art/T_Piracy")
end
function c30_carddef()
    return quickCreate("c30", "art/T_Rolling_Fireball")
end
function c31_carddef()
    return quickCreate("c31", "art/T_Seek_Revenge")
end
function c32_carddef()
    return quickCreate("c32", "art/T_Set_Sail")
end
function c33_carddef()
    return quickCreate("c33", "art/T_Strength_Of_The_Wolf")
end
function c34_carddef()
    return quickCreate("c34", "art/T_The_Rot")
end
function c35_carddef()
    return quickCreate("c35", "art/T_TimelyHeist")
end
function c36_carddef()
    return quickCreate("c36", "art/T_Weak_Skeleton")
end
function c37_carddef()
    return quickCreate("c37", "icons/battle_cry")
end
function c38_carddef()
    return quickCreate("c38", "icons/fighter_crushing_blow_OLD")
end
function c39_carddef()
    return quickCreate("c39", "icons/fighter_devastating_blow_OLD")
end
function c40_carddef()
    return quickCreate("c40", "icons/fighter_group_tackle_OLD")
end
function c41_carddef()
    return quickCreate("c41", "icons/fighter_knock_back_OLD")
end
function c42_carddef()
    return quickCreate("c42", "icons/fighter_knock_down_OLD")
end
function c43_carddef()
    return quickCreate("c43", "icons/fighter_mighty_blow_OLD")
end
function c44_carddef()
    return quickCreate("c44", "icons/fighter_powerful_blow_OLD")
end
function c45_carddef()
    return quickCreate("c45", "icons/fighter_precision_blow_OLD")
end
function c46_carddef()
    return quickCreate("c46", "icons/fighter_shoulder_bash_OLD")
end
function c47_carddef()
    return quickCreate("c47", "icons/fighter_shoulder_crush_OLD")
end
function c48_carddef()
    return quickCreate("c48", "icons/fighter_shoulder_smash_OLD")
end
function c49_carddef()
    return quickCreate("c49", "icons/fighter_smashing_blow_OLD")
end
function c50_carddef()
    return quickCreate("c50", "icons/fighter_sweeping_blow_OLD")
end
function c51_carddef()
    return quickCreate("c51", "icons/fighter_whirling_blow_OLD")
end
function c52_carddef()
    return quickCreate("c52", "icons/full_armor")
end
function c53_carddef()
    return quickCreate("c53", "icons/full_armor_2")
end
function c54_carddef()
    return quickCreate("c54", "icons/growing_flame")
end
function c55_carddef()
    return quickCreate("c55", "icons/life_siphon")
end
function c56_carddef()
    return quickCreate("c56", "icons/orc_raiders")
end
function c57_carddef()
    return quickCreate("c57", "icons/piracy")
end
function c58_carddef()
    return quickCreate("c58", "icons/ranger_well_placed_shot_OLD")
end
function c59_carddef()
    return quickCreate("c59", "icons/smugglers")
end
function c60_carddef()
    return quickCreate("c60", "icons/turn_to_ash")
end
function c61_carddef()
    return quickCreate("c61", "icons/wind_storm")
end
function c62_carddef()
    return quickCreate("c62", "zoomedbuffs/goblin_warlord")
end

function setupGame(g)
	registerCards(g, {
		c1_carddef(),
		c2_carddef(),
		c3_carddef(),
		c4_carddef(),
		c5_carddef(),
		c6_carddef(),
		c7_carddef(),
		c8_carddef(),
		c9_carddef(),
		c10_carddef(),
		c11_carddef(),
		c12_carddef(),
		c13_carddef(),
		c14_carddef(),
		c15_carddef(),
		c16_carddef(),
		c17_carddef(),
		c18_carddef(),
		c19_carddef(),
		c20_carddef(),
		c21_carddef(),
		c22_carddef(),
		c23_carddef(),
		c24_carddef(),
		c25_carddef(),
		c26_carddef(),
		c27_carddef(),
		c28_carddef(),
		c29_carddef(),
		c30_carddef(),
		c31_carddef(),
		c32_carddef(),
		c33_carddef(),
		c34_carddef(),
		c35_carddef(),
		c36_carddef(),
		c37_carddef(),
		c38_carddef(),
		c39_carddef(),
		c40_carddef(),
		c41_carddef(),
		c42_carddef(),
		c43_carddef(),
		c44_carddef(),
		c45_carddef(),
		c46_carddef(),
		c47_carddef(),
		c48_carddef(),
		c49_carddef(),
		c50_carddef(),
		c51_carddef(),
		c52_carddef(),
		c53_carddef(),
		c54_carddef(),
		c55_carddef(),
		c56_carddef(),
		c57_carddef(),
		c58_carddef(),
		c59_carddef(),
		c60_carddef(),
		c61_carddef(),
		c62_carddef(),
    })

    standardSetup(g, {
        description = "Art Browser",
        playerOrder = { plid1, plid2 },
        ai = createHardAi(),
        randomOrder = true,
        opponents = { { plid1, plid2 } },
        -- I like to add the cards to the market row just so I can see how they display/work right away. To do this list them as one of the 5 cards here.  If you have less than 5 listed, add other cards otherwise you will have less than 5 cards in your starting row.
        centerRow = { "command", "bribe", "grak__storm_giant", "taxation", "domination" },
        noTradeDeck = false,
        noFireGems = false,
        players = {
            {
                id = plid1,
				startDraw = 0,
				name = "Art Collector",
				avatar = "Assassin",
				health = 100,
                cards = {
					hand = {
						{ qty=1, card=c1_carddef() }
					},
					deck = {
						c1_carddef(),
						c2_carddef(),
						c3_carddef(),
						c4_carddef(),
						c5_carddef(),
						c6_carddef(),
						c7_carddef(),
						c8_carddef(),
						c9_carddef(),
						c10_carddef(),
						c11_carddef(),
						c12_carddef(),
						c13_carddef(),
						c14_carddef(),
						c15_carddef(),
						c16_carddef(),
						c17_carddef(),
						c18_carddef(),
						c19_carddef(),
						c20_carddef(),
						c21_carddef(),
						c22_carddef(),
						c23_carddef(),
						c24_carddef(),
						c25_carddef(),
						c26_carddef(),
						c27_carddef(),
						c28_carddef(),
						c29_carddef(),
						c30_carddef(),
						c31_carddef(),
						c32_carddef(),
						c33_carddef(),
						c34_carddef(),
						c35_carddef(),
						c36_carddef(),
						c37_carddef(),
						c38_carddef(),
						c39_carddef(),
						c40_carddef(),
						c41_carddef(),
						c42_carddef(),
						c43_carddef(),
						c44_carddef(),
						c45_carddef(),
						c46_carddef(),
						c47_carddef(),
						c48_carddef(),
						c49_carddef(),
						c50_carddef(),
						c51_carddef(),
						c52_carddef(),
						c53_carddef(),
						c54_carddef(),
						c55_carddef(),
						c56_carddef(),
						c57_carddef(),
						c58_carddef(),
						c59_carddef(),
						c60_carddef(),
						c61_carddef(),
						c62_carddef(),
					},
                    buffs = {
                        drawCardsAtTurnEndDef(),
                        discardCardsAtTurnStartDef(),
                        fatigueCount(40, 1, "FatigueP1"),
                    }
                }
            },
            {
                id = plid2,
                isAi = true,
                name = "AI",
                avatar = "skeleton",
                health = 50,
                cards = {
                    deck = {
                        { qty = 2, card = dagger_carddef() },
                        { qty = 8, card = gold_carddef() },
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

function endGame(g)
end



function setupMeta(meta)
    meta.name = "art_browser"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/xTheC/Desktop/Git Repositories/hero-realms-lua-scripts/Userkaffe/Utilities/art_browser.lua"
     meta.features = {
}

end