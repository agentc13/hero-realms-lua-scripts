require 'herorealms'
require 'decks'
require 'stdlib'
require 'stdcards'
require 'hardai'
require 'mediumai'
require 'easyai'




-- purchasable armor

function purchasable_armor_carddef()
	local cardLayout = createLayout({
		name = "Jigmelingpa",
        art = "icons/wizard_flame_burst",
		cost = 3,
		frame = "frames/Wizard_CardFrame",
        text = "{imperial} Heal 4. <br> {sac} {imperial} heal 4."
	})
	
	return createActionDef({
		id = "jigmelingpa_market",
		name = "Jigmelingpa",
		acquireCost = 3,
		layout = cardLayout,
		abilities = {},
		cardEffectAbilities = {
			createCardEffectAbility({
				trigger = postSelfAcquiredCardTrigger,
                allyFactions = {imperialFaction},
				effect = createCardEffect(jigmelingpa_carddef(), currentSkillsLoc).seq(sacrificeTarget().apply(selectSource())).seq(gainHealthEffect(4))
			})
		},
	})
end

-- Need to get Ally Faction abilites working. 

function jigmelingpa_carddef()
	return createHeroAbilityDef({
		id = "jigmelingpa_companion",
		name = "Jigmelingpa",
		types = { mageType, attachmentType, noStealType, wizardType },
        abilities = {
			createAbility({
				id = "jigmelingpa_sac",
                trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Jigmelingpa",
					art = "icons/wizard_flame_burst",
					text =  "{sac} {imperial} heal 4."
				}),
				effect = gainHealthEffect(4),
				cost = sacrificeSelfCost
			})
		},
		layout = createLayout({
			name = "Jigmelingpa",
			art = "icons/wizard_flame_burst",
			text = "{sac} {imperial} heal 4."
		}),
		layoutPath= "icons/wizard_flame_burst",
	})
end	



function setupGame(g)
    registerCards(g, { 
    purchasable_armor_carddef(),
    jigmelingpa_carddef()
})

standardSetup(g, {
    description = "Jigmelingpa Companion  Test",
    playerOrder = { plid1, plid2 },
    ai = createHardAi(),
    randomOrder = true,
    opponents = { { plid1, plid2 } },
    centerRow = { "jigmelingpa_market", "fire_bomb", "grak__storm_giant", "tyrannor__the_devourer", "domination" },
    tradeDeckExceptions = {
        { qty = 0, cardId = "fire_bomb" },
        { qty = 0, cardId = "grak__storm_giant" },
        { qty = 0, cardId = "tyrannor__the_devourer" },
        { qty = 0, cardId = "domination" },
    },
    noTradeDeck = false,
    noFireGems = false,
    players = {
        {
            id = plid1,
            init = {
                fromEnv = plid1
            },
            cards = {
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
                    { qty = 1, card = shortsword_carddef() },
                    { qty = 1, card = ruby_carddef() },
                    { qty = 1, card = dagger_carddef() },
                    { qty = 7, card = gold_carddef() },
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
    meta.name = "ac13_jig_WIP"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/timot/OneDrive/Documents/Hero-Realms-Lua-Scripts/AC13/ac13_jig_WIP.lua"
     meta.features = {
}

end