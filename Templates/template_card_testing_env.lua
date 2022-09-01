-- this is a template to easily test the cards you are working on to make sure they work properly.
-- I didn't add comments for everything here, just where you will want to change what is in this file. Refer to the specific card or setup templates for deeper comments on them.

require 'herorealms'
require 'decks'
require 'stdlib'
require 'stdcards'
require 'hardai'
require 'mediumai'
require 'easyai'

--[[ insert card(s) you are testing here and remove the snackforce placeholder. Remove the brackets to make this a single line comment instead of multi-line. Or just remove this altogether.

function snackforce_carddef()
    local cardLayout = createLayout({
            name = "Snackforce",
            art = "art/T_Feisty_Orcling",
            frame = "frames/HR_CardFrame_Action_Necros",
            cost = 2,
            text = "<size=200%><sprite name=\"gold_1\">   <sprite name=\"health_3\">",
        })

    return createActionDef({
        id = "snackforce",
        name = "Snackforce",
        types = { actionType },
        acquireCost = 2,
        abilities = {
            createAbility({
                id = "snackforce",
                trigger = autoTrigger,
                effect = gainGoldEffect(1).seq(gainHealthEffect(3)),
            })
        },
        layout = cardLayout,
    })
end

end card testing area (remove this line when testing)]]

function setupGame(g)
        registerCards(g, {
        --[[ add the carddefs for all the cards you want to test here.    
        snackforce_carddef()
        end added carddefs ]]
    })

    standardSetup(g, {
        description = "Snackforce Test",
        playerOrder = { plid1, plid2 },
        ai = createHardAi(),
        randomOrder = true,
        opponents = { { plid1, plid2 } },
        -- I like to add the cards to the market row just so I can see how they display/work right away. To do this list them as one of the 5 cards here.  If you have less than 5 listed, add other cards otherwise you will have less than 5 cards in your starting row.
        centerRow = { "snackforce", "fire_bomb", "grak__storm_giant", "tyrannor__the_devourer", "domination" },
        tradeDeckExceptions = {
            --[[ enter the number of each card you are adding to the market deck.
            { qty = 2, cardId = "snackforce" },
            end market deck insertions here ]]
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
