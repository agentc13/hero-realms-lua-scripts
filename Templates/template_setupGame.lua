-- WWG provided pretty thorough comments in the setupGame example. I will just be adding a few clarifications that may help people who are unfamiliar with coding.


-- The following lines are basically telling the game that this script requires other code from elsewhere (sort of like a code library) to work. For most game setups you will definitely need 'herorealms' 'decks' 'stdlib' and 'stdcards' the ai is here because we can only test this against the ai for now, and when first testing your code it is a good idea to have a default game setup against the ai player just to make sure it works, but 'hardai' 'mediumai' 'easyai' would not be required in a pvp game.
require 'herorealms'
require 'decks'
require 'stdlib'
require 'stdcards'
require 'hardai'
require 'mediumai'
require 'easyai'


-- All game setups require the setupGame(g) function. 
function setupGame(g)
    -- registerCards function will register newly created cards for further use within our setup.
    -- You only need to use this when adding new carddefs, if you are using modified carddefs of existing cards you do not net to register them.
    registerCards(g, {
        orc_guardian_carddef()
    })

    -- startardSetup function accepts a table with all data required to set the game up. 
    standardSetup(g, {
        -- script description - displayed in in-game menu
        description = "Custom no heroes game",
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
        centerRow = { "arkus__imperial_dragon", "fire_bomb", "grak__storm_giant", "tyrannor__the_devourer", "domination" },
        -- this allows us to change market deck. qty=0 will remove cards, and qty='positive number' will add that many to the market deck
        tradeDeckExceptions = {
            -- here we set 0 quantity for cards we added to center row, so they don't appear in market deck
            { qty = 0, cardId = "arkus__imperial_dragon" },
            { qty = 0, cardId = "fire_bomb" },
            { qty = 0, cardId = "grak__storm_giant" },
            { qty = 0, cardId = "tyrannor__the_devourer" },
            { qty = 0, cardId = "domination" },
            -- and 3 orc guardians go into deck
            { qty = 3, cardId = "orc_guardian" },
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
                        doubleHealthBuffDef()
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