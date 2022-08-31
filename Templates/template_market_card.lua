-- This is a sample template for a custom card (this is a version of Rallying Flag for Fighter).
-- The "--" lines are comments that do not effect the actual Lua code
-- They are used to help explain each line of code used so you know what everything does.


--This is the function that creates the card.
function rallying_flag_carddef()
    return createActionDef({
        -- card id
        id = "flag",
        -- card name (what will appear on the card in game)
        name = "Rallying Flag",
        -- card type (see Reference guide for usable types)
        types = { actionType, noStealType },
        -- cost to acquire card from market. This is a class upgrade so cost is "0".
        acquireCost = 0,
        -- card abilities
        abilities = {
            createAbility({
                -- ability id
                id = "flag",
                -- ability trigger (see documentation for trigger types)
                trigger = autoTrigger,
                -- card effects. This card gives 1 gold and heals 3 hp.
                effect = gainGoldEffect(1).seq(gainHealthEffect(3)),
            })
        },
        -- card layout
        layout = createLayout({
            -- card name
            name = "Rallying Flag",
            -- art for card (see documentation for usable art)
            art = "art/T_Devotion",
            -- card frame (the edges and border of card, not the art or text)
            frame = "frames/Warrior_CardFrame",
            -- card text (this is just a 1 gold icon and a 3 heal icon)
            text = "<size=200%><sprite name=\"gold_1\">   <sprite name=\"health_3\">",
        })
    })
end