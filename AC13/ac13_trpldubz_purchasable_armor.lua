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
		name = "TrplDubz",
        art = "zoomedbuffs/goblin_warlord",
		cost = 5,
		frame = "frames/HR_CardFrame_Item_Generic",
        text = (
            "<size=300%><line-height=0%><voffset=-.8em> <pos=-75%><sprite name=\"requiresHealth_20\"></size><line-height=80%> \n <voffset=1.8em><size=80%> If you have played a faction card this turn, all cards of that faction cost 1 less. </size>"
            ),
	})
	
	return createActionDef({
		id = "trpldubz_armor",
		name = "TrplDubz",
		acquireCost = 5,
		layout = cardLayout,
		abilities = {},
		cardEffectAbilities = {
			createCardEffectAbility({
				trigger = postSelfAcquiredCardTrigger,
				effect = createCardEffect(orc_pauldrons_carddef(), currentSkillsLoc).seq(sacrificeTarget().apply(selectSource()))
			})
		},
	})
end

function trpldubz_carddef()
    local cardLayout = createLayout({
        name = "TrplDubz",
        art = "zoomedbuffs/goblin_warlord",
		frame = "frames/HR_CardFrame_Item_Generic",
        text = (
            "<size=300%><line-height=0%><voffset=-.8em> <pos=-75%><sprite name=\"requiresHealth_20\"></size><line-height=80%> \n <voffset=1.8em><size=80%> If you have played a faction card this turn, all cards of that faction cost 1 less. </size>"
            ),
    })

    return createMagicArmorDef({
        id = "trpldubz_armor",
        name = "TrplDubz",
        layout = cardLayout,
        layoutPath = "zoomedbuffs/goblin_warlord",
        abilities = {
            createAbility({
                id = "trpldubz_ab",
                layout = cardLayout,
                effect = ifEffect(selectLoc(currentInPlayLoc).where(isCardFaction(Faction.Wild).count().gte(1), acquireTarget(1,currentDiscardLoc).apply(selectLoc(centerRowLoc).where(isCardFaction(Faction.Wild))),
                trigger = autoTrigger,
                check = minHealthCurrent(20)
            })
        }
    })
end



function setupGame(g)
    registerCards(g, { 
    purchasable_armor_carddef(),
    trpldubz_carddef()
})

standardSetup(g, {
    description = "Purchasable Armor Test",
    playerOrder = { plid1, plid2 },
    ai = createHardAi(),
    randomOrder = true,
    opponents = { { plid1, plid2 } },
    centerRow = { "trpldubz_armor", "fire_bomb", "grak__storm_giant", "tyrannor__the_devourer", "domination" },
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
    meta.name = "ac13_trpldubz_purchasable_armor"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/timot/OneDrive/Documents/Hero-Realms-Lua-Scripts/AC13/ac13_trpldubz_purchasable_armor.lua"
     meta.features = {
}

end