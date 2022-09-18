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
    return quickCreate("c1", "avatars/ambushers")
end
function c2_carddef()
    return quickCreate("c2", "avatars/assassin")
end
function c3_carddef()
    return quickCreate("c3", "avatars/assassin_flipped")
end
function c4_carddef()
    return quickCreate("c4", "avatars/broelyn")
end
function c5_carddef()
    return quickCreate("c5", "avatars/broelyn__loreweaver")
end
function c6_carddef()
    return quickCreate("c6", "avatars/chanting_cultist")
end
function c7_carddef()
    return quickCreate("c7", "avatars/chest")
end
function c8_carddef()
    return quickCreate("c8", "avatars/cleric_01")
end
function c9_carddef()
    return quickCreate("c9", "avatars/cleric_02")
end
function c10_carddef()
    return quickCreate("c10", "avatars/cristov_s_recruits")
end
function c11_carddef()
    return quickCreate("c11", "avatars/cristov__the_just")
end
function c12_carddef()
    return quickCreate("c12", "avatars/fighter_01")
end
function c13_carddef()
    return quickCreate("c13", "avatars/fighter_02")
end
function c14_carddef()
    return quickCreate("c14", "avatars/inquisition")
end
function c15_carddef()
    return quickCreate("c15", "avatars/krythos")
end
function c16_carddef()
    return quickCreate("c16", "avatars/lord_callum")
end
function c17_carddef()
    return quickCreate("c17", "avatars/lys__the_unseen")
end
function c18_carddef()
    return quickCreate("c18", "avatars/man_at_arms")
end
function c19_carddef()
    return quickCreate("c19", "avatars/monsters_in_the_dark")
end
function c20_carddef()
    return quickCreate("c20", "avatars/necromancers")
end
function c21_carddef()
    return quickCreate("c21", "avatars/ogre")
end
function c22_carddef()
    return quickCreate("c22", "avatars/orcs")
end
function c23_carddef()
    return quickCreate("c23", "avatars/orc_raiders")
end
function c24_carddef()
    return quickCreate("c24", "avatars/origins_flawless_track")
end
function c25_carddef()
    return quickCreate("c25", "avatars/origins_shoulder_bash")
end
function c26_carddef()
    return quickCreate("c26", "avatars/pirate")
end
function c27_carddef()
    return quickCreate("c27", "avatars/profit")
end
function c28_carddef()
    return quickCreate("c28", "avatars/ranger_01")
end
function c29_carddef()
    return quickCreate("c29", "avatars/ranger_02")
end
function c30_carddef()
    return quickCreate("c30", "avatars/rayla__endweaver")
end
function c31_carddef()
    return quickCreate("c31", "avatars/rayla__endweaver_flipped")
end
function c32_carddef()
    return quickCreate("c32", "avatars/robbery")
end
function c33_carddef()
    return quickCreate("c33", "avatars/ruinos_zealot")
end
function c34_carddef()
    return quickCreate("c34", "avatars/skeleton")
end
function c35_carddef()
    return quickCreate("c35", "avatars/smugglers")
end
function c36_carddef()
    return quickCreate("c36", "avatars/spider")
end
function c37_carddef()
    return quickCreate("c37", "avatars/summoner")
end
function c38_carddef()
    return quickCreate("c38", "avatars/tentacles")
end
function c39_carddef()
    return quickCreate("c39", "avatars/the_wolf_tribe")
end
function c40_carddef()
    return quickCreate("c40", "avatars/thief_01")
end
function c41_carddef()
    return quickCreate("c41", "avatars/thief_02")
end
function c42_carddef()
    return quickCreate("c42", "avatars/troll")
end
function c43_carddef()
    return quickCreate("c43", "avatars/vampire_lord")
end
function c44_carddef()
    return quickCreate("c44", "avatars/wizard_01")
end
function c45_carddef()
    return quickCreate("c45", "avatars/wizard_02")
end
function c46_carddef()
    return quickCreate("c46", "avatars/wolf_shaman")
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
    })

    standardSetup(g, {
        description = "Avatar Browser",
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
				name = "Avatar Collector",
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
    meta.name = "avatar_browser"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/agentc13/github/hero-realms-lua-scripts/Userkaffe/Utilities/avatar_browser.lua"
     meta.features = {
}

end