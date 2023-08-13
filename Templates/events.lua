require 'herorealms'
require 'decks'
require 'stdlib'
require 'timeoutai'
require 'hardai_2'
require 'aggressiveai'

function eventTriggeringBuffDef() --given to the players in setup game function. Plays events when they enter trade row
    return createGlobalBuff({
        id="event_triggering_buff",
        name = "Event trigger",
        abilities = {
            createAbility({
                id="hassuxdxd",
                trigger = autoTrigger,
				activations = multipleActivations,
				effect = (acquireTarget(0, revealPloc).seq(playTarget())).apply(selectLoc(centerRowLoc).where(isCardType(100))),
				check = selectLoc(centerRowLoc).where(isCardType(100)).count().gte(1)
            })
        }
    })
end

function tithe_is_due_carddef()
	return createDef({
		id = "tithe_is_due",
		name = "Tithe Time",
		acquireCost = 0,
		cardTypeLabel = "Event",
		playLocation = revealPloc,
		types = { 100 },
		layout = createLayout({
			name = "Tithe Time",
			art = "art/T_Evangelize",
			frame = "frames/HR_CardFrame_Item_Generic",
			cost = 0,
			text = "Acquire a Tithe Priest.\nThen give all your Tithe Priests +1<sprite name=\"shield\"> permanently."
		}),
		abilities = {
			createAbility({
				id = "titheIsDueMain",
				trigger = autoTrigger,
				effect = createCardEffect(tithe_priest_carddef(), currentInPlayLoc).seq(grantHealthTarget(1).apply(selectLoc(currentInPlayLoc).where(isCardName("tithe_priest")))),
				cost = sacrificeSelfCost,
			}),
		}
	})
end

function setupGame(g)
    registerCards(g, {
        tithe_is_due_carddef()
    })

    standardSetup(g, {
        description = "Event game",
        playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(),  createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
		tradeDeckExceptions = {
			{ qty = 50, cardId = "tithe_is_due"}
		},
        players = {
            {
                id = plid1,
                startDraw = 3,
                init = {
                    fromEnv = plid1
                },
                cards = {
                    buffs = {
                        drawCardsAtTurnEndDef(),
                        eventTriggeringBuffDef(),
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
                        eventTriggeringBuffDef(),
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
    meta.name = "events"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/xTheC/Desktop/Git Repositories/hero-realms-lua-scripts/Templates/events.lua"
     meta.features = {
}

end