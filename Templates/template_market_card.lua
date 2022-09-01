
-- carddef function, this creates the card and is referred to in the game setup.
function snackforce_carddef()
    -- We set up the card layout that is later referred to in the createActionDef
    local cardLayout = createLayout({        
        -- Title of card (as it appears in the top banner)
        name = "Snackforce",
        -- Art used for card
        art = "art/T_Feisty_Orcling",
        -- Frame around the edges of the card.
        frame = "frames/HR_CardFrame_Action_Necros",
        -- Text layout, refer to 'Layout Text Formatting' section in Lua documentation
        text = "<size=200%><sprite name=\"gold_1\">   <sprite name=\"health_3\">",
    })
    -- createActionDef, This is where we create all the variables for the card.
    return createActionDef({
        -- a unique id for the card
        id = "snackforce",
        -- Title of card
        name = "Snackforce",
        -- An array of strings where we list the types this card possesses.
        types = { actionType },
        -- Gold cost a player must pay to acquire form market
        acquireCost = 2,
        -- array of abilities that the card will have
        abilities = {
            createAbility({
                -- a unique id for the ability
                id = "snackforce",
                -- one of the triggers listed in documentation under 'creating abilities' this one is triggered when the card is played
                trigger = autoTrigger,
                -- an effect to run when triggered. This card gives 1 gold and heals 3.
                effect = gainGoldEffect(1).seq(gainHealthEffect(3)),
            })
        },
        -- card layout
        layout = cardLayout,
    })
end