require 'herorealms'
require 'decks'
require 'stdlib'
require 'stdcards'
require 'hardai'
require 'mediumai'
require 'easyai'


-- THIS IS NOT COMPLETED YET!!!!!


-- just an empty card to be displayed in skills area and for checking when granting gold
local function wisdom_of_the_wolf()
    card = createSkillDef({
        id = "cunning_of_the_wolf",
        name = "Wisdom of the Wolf",
        abilities = {},
        cardEffectAbilities = {
        },
        layout = createLayout({
            name = "Wisdom of the Wolf",
            art = "art/T_Cunning_Of_The_Wolf",
            text = "You generate\n double <sprite name=\"gold\"> from \ncards in your deck."
        }),
    })
    return card
end

-- just an empty card to be displayed in skills area and for checking when granting combat
local function wolf_strength_skill()
    card = createSkillDef({
        id = "strength_of_the_wolf",
        name = "Wolf Strength",
        abilities = {},
        cardEffectAbilities = {
        },
        layout = createLayout({
            name = "Wolf Strength",
            art = "art/T_Strength_Of_The_Wolf",
            text = "You generate\n double <sprite name=\"combat\"> from \ncards in your deck."
        }),
    })
    return card
end

-- simple choice effect, showing two layouts and executing selected one, triggers at the game start
local function chooseTheSkill()
    return cardChoiceSelectorEffect({
        id = "choose_the_wolf_skill",
        name = "Choose the wolf skill",
        trigger = startOfGameTrigger,

        upperTitle = "Choose one.",
        lowerTitle = "(Your opponent gets the other.)",

        effectFirst = createCardEffect(wisdom_of_the_wolf(), loc(currentPlayer(), skillsPloc))
            .seq(createCardEffect(wolf_strength_skill(), loc(oppPlayer(), skillsPloc)))
            .seq(nuUndoEffect()).seq(drawCardsWithAnimation(3)),

        effectSecond = createCardEffect(wolf_strength_skill(), loc(currentPlayer(), skillsPloc))
            .seq(createCardEffect(wisdom_of_the_wolf(), loc(oppPlayer(), skillsPloc)))
            .seq(nuUndoEffect()).seq(drawCardsWithAnimation(3)),

        layoutFirst = layoutCard({
            title = "Wisdom of the Wolf",
            art = "art/T_Cunning_Of_The_Wolf",
            text = "You generate\n double <sprite name=\"gold\"> from cards in your deck."
        }),

        layoutSecond = layoutCard({
            title = "Strength of the Wolf",
            art = "art/T_Strength_Of_The_Wolf",
            text = "You generate\n double <sprite name=\"combat\"> from cards in your deck."
        }),

        turn = 1
    })
end

-- combat mod function allows you to do anything with any combat generated in game
-- here we check if a card with double combat is in current player's skills location
function combatMod(value)
    return ifInt(selectLoc(currentSkillsLoc).where(isCardName("strength_of_the_wolf")).count().eq(1),
        multiply(toIntExpression(value), const(2)), toIntExpression(value))
end

-- gold mod function allows you to do anything with any gold yielded from cards
-- here we check if a card with double gold is in current player's skills location
function goldMod(value)
    return ifInt(selectLoc(currentSkillsLoc).where(isCardName("cunning_of_the_wolf")).count().eq(1),
        multiply(toIntExpression(value), const(2)), toIntExpression(value))
end

function setupGame(g)
    -- startardSetup function accepts a table with all data required to set the game up
    standardSetup(g, {
        description = "This is not complete!", -- script description - displayed in in-game menu
        playerOrder = { plid1, plid2 }, -- order in which players take turns
        ai = createHardAi(), -- sets AI for ai players
        -- randomOrder = true, -- if true, randomizes players order
        opponents = { { plid1, plid2 } }, -- pairs of opponents
        players = { -- array of players
            {
                id = plid1, -- sets up id for the player. options are plid1, plid2, plid3, plid4
                startDraw = 0,
                init = { -- sets how hero get initialized
                    fromEnv = plid1 -- takes hero data from the selection (VS AI or Online)
                },
                cards = { -- cards allows to add any cards to any of hero location at the start of the game
                    buffs = {
                        drawCardsAtTurnEndDef(),
                        discardCardsAtTurnStartDef(),
                        chooseTheSkill(),
                        fatigueCount(40, 1, "FatigueP1"),
                    }
                }
            },
            {
                id = plid2, -- sets up id for the player. options are plid1, plid2, plid3, plid4
                isAi = true,
                init = { -- sets how hero get initialized
                    fromEnv = plid2 -- takes hero data from the selection (VS AI or Online)
                },
                cards = { -- cards allows to add any cards to any of hero location at the start of the game
                    buffs = {
                        drawCardsAtTurnEndDef(),
                        discardCardsAtTurnStartDef(),
                        fatigueCount(40, 1, "FatigueP1"),
                    }
                }
            }
        }
    })
end

function endGame(g) -- more info on this later
end


function setupMeta(meta)
    meta.name = "ac13_custom_battlefield_effect"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "D:/HRLS/Hero-Realms-Lua-Scripts/AC13/ac13_custom_battlefield_effect.lua"
     meta.features = {
}

end