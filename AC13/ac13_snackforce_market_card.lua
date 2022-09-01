require 'herorealms'
require 'decks'
require 'stdlib'
require 'stdcards'
require 'hardai'
require 'mediumai'
require 'easyai'

function snackforce_carddef()
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
        layout = createLayout({
               name = "Snackforce",
            art = "art/T_Feisty_Orcling",
            frame = "frames/HR_CardFrame_Action_Necros",
            cost - 2,
            text = "<size=200%><sprite name=\"gold_1\">   <sprite name=\"health_3\">",
        })
    })
end

function setupGame(g)
    -- registerCards function will register newly created cards for further use within our setup.
    -- You only need to use this when adding new carddefs, if you are using modified carddefs of existing cards you do not net to register them.
    registerCards(g, {
        -- This registers the example card orc_guardian from the WWG examples.
        snackforce_carddef()
    })

    -- startardSetup function accepts a table with all data required to set the game up. 
    standardSetup(g, {
        -- script description - displayed in in-game menu
        description = "Snackforce Test",
        -- order in which players take turns
        playerOrder = { plid1, plid2 },
        -- sets AI for ai players (I will assume this isn't necessary for stricly pvp setups)
        ai = createHardAi(),
        -- if true, randomizes players order
        randomOrder = true,
        -- pairs of opponents
        opponents = { { plid1, plid2 } },
        -- specify up to 5 cards to appear in the center row at the start of the game
        -- this isn't necessary if you want the startgin cards to be random
        centerRow = { "snackforce", "fire_bomb", "grak__storm_giant", "tyrannor__the_devourer", "domination" },
        -- this allows us to change market deck. qty=0 will remove cards, and qty='positive number' will add that many to the market deck
        tradeDeckExceptions = {
            -- here we set 0 quantity for cards we added to center row, so they don't appear in market deck
            -- and 3 orc guardians go into deck
            { qty = 2, cardId = "snackforce" },
        },
        -- set to true if you don't want trade deck
        noTradeDeck = false,
        -- set to true if you don't want fire gems
        noFireGems = false,
        -- array of players
        players = {
            {
                -- sets up id for the player. options are plid1, plid2, plid3, plid4
                id = plid1,
                -- sets how many cards player draws at the start of the game. If not set, first player will draw 3, second player - 5
                -- commented out as we have random order enabled.
                -- startDraw = 3,
                -- sets how hero get initialized
                init = {
                    -- takes hero data from the selection (VS AI or Online). if you use fromEnv you will pull the info from that hero, and you cannot modify that stuff with the 'name' and 'avatar' table variables.
                    fromEnv = plid1
                },
                -- cards allows to add any cards to any of hero location at the start of the game
                cards = {
                    buffs = {
                        -- mandatory card: discards cards at the end of turn and draws next hand
                        drawCardsAtTurnEndDef(),
                        -- mandatory card: processes discards at the start of turn
                        discardCardsAtTurnStartDef(),
                        -- grants increased by 1 combat starting from turn 40
                        fatigueCount(40, 1, "FatigueP1"),
                        -- custom buff we created to double health (this is used in the template_buff_debuff file if you want to reference it)
                    }
                }
            },
            {
                -- id for player 2, same options as above.
                id = plid2,
                -- should always be true for player 2 when playing around with local scripts. 
                -- If/when WWG allows for custom scripts in pvp this would change.
                isAi = true,
                -- commented out the starting hand size because of the random order from above.
                -- startDraw = 5,
                -- Player 2 name
                name = "AI",
                -- sets avatar for the player (when using the avatar artwork in the documentation you do not need to include the 'avatar/' part here)
                avatar = "assassin",
                -- starting health
                health = 500,
                -- if not set - equals to starting health
                maxHealth = 500,
                -- you may also set cards for "hand", "inPlay", "discard", "skills"
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