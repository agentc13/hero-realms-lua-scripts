require 'herorealms'
require 'decks'
require 'stdlib'
require 'stdcards'
require 'hardai'
require 'mediumai'
require 'easyai'


function confused_apparition_carddef()
    return createActionDef({
        id="confused_apparition",
        name="Confused Apparition",
        types={noStealType},
        acquireCost=0,
        abilities = {
            createAbility({
                id="confused_apparition_auto",
                trigger= autoTrigger,
                effect = ifEffect(selectLoc(currentInPlayLoc).where(isCardName("weak_skeleton")).count().lte(0), healPlayerEffect(oppPid, 1))
            })
        },
        layout = createLayout({
            name = "Confused Apparition",
            frame = "frames/Coop_Campaign_CardFrame",
            text = "Opponent gains 1 <sprite name=\"health\"> unless you have a Weak Skeleton in play."
        })
})
end

function setupGame(g)
    registerCards(g, {
        confused_apparition_carddef()
    })

    standardSetup(g, {
        description = "Testing Setup",
        playerOrder = { plid1, plid2 },
        ai = createHardAi(),
        randomOrder = true,
        opponents = { { plid1, plid2 } },
        noTradeDeck = false,
        noFireGems = false,
        players = {
            {
                id = plid1,
                init = {
                    fromEnv = plid1
                },
                cards = {
                    deck = {
                        { qty = 1, card = confused_apparition_carddef() }
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
                name = "Silent AI",
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

-- more info on this later
function endGame(g)
end

