-- This is a sample template for a custom market card.
-- The "--" lines are comments that do not effect the actual Lua code
-- They are used to help explain each line of code used so you know what everything does.


--This is the 'carddef' function that creates the card.
function devotion_carddef()
    return createActionDef({
        -- card id
        id = "devotion",
        -- card name (what will appear on the card in game)
        name = "Devotion",
        -- card type (see Reference guide for usable types)
        types = { actionType },
        -- cost to acquire card from market. This is a class upgrade so cost is "0".
        acquireCost = 3,
        -- card abilities
        abilities = {
            createUiAllyAbility({
                -- ability id
                id = "devotion",
                -- ability trigger (see documentation for trigger types)
                trigger = autoTrigger,
                -- card effects. This card gives 1 gold and heals 3 hp.
                effect = gainHealthEffect(4),
                allyFactions = imperialFaction,
            })
        },
        -- card layout
        layout = createLayout({
            -- card name
            name = "Devotion",
            -- art for card (see documentation for usable art)
            art = "art/T_Devotion",
            -- card frame (the edges and border of card, not the art or text)
            frame = "frames/HR_CardFrame_Action_Imperial",
            -- card text (this is just a 1 gold icon and a 3 heal icon)
            text = "<line-height=175><size=190%><voffset=-140><pos=5><sprite name=\"health_4\"></pos></voffset></size><size=50%>><br><voffset=25><pos=0>_____________________</pos></voffset><br><voffset=140><pos=-95><size=143%><sprite name=\"imperial\"> Draw a card. </size></pos></voffset>",
        })
    })
end