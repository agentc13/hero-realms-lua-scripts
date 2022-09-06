-- This is a sample template for a Fighter ability. It will not work on it's own without the gameSetup script.
-- The "--" lines are comments that do not effect the actual Lua code
-- They are used to help explain each line of code used so you know what everything does.

-- Custom magic armor Function
function orc_pauldrons_carddef()
    -- this is a local variable (only used in this function) creating the card layout
    local cardLayout = createLayout({
        -- Name of card
        name = "Orc Pauldrons",
        -- Art for card
        art = "icons/battle_cry",
        -- frame for card
        frame = "frames/Warrior_CardFrame",
        -- Card effect text (see the formatting section in documentation)
        text = (
            "<size=300%><line-height=0%><voffset=-.8em> <pos=-75%><sprite name=\"requiresHealth_25\"></size><line-height=80%> \n <voffset=1.8em><size=80%> If you have dealt 5 <sprite name=\"combat\"> to an opponent this turn. \n Draw 1 \n or \n Gain 2 <sprite name=\"health\"> </size>"
            ),
    })

    return createMagicArmorDef({
        -- id of card for magic armor
        id = "orc_pauldrons",
        -- card name as it appears in top banner
        name = "Orc Pauldrons",
        -- card layout for magic armor
        layout = cardLayout,
        -- card art for magic armor
        layoutPath = "icons/battle_cry",
        -- card effect sfor magic armor
        abilities = {
            -- this code creates the ability for the magic armor card
            createAbility({
                -- magic armor id
                id = "orc_pauldrons",
                -- magic armor layout
                layout = cardLayout,
                -- magic armor code (the example is a pushChoiceEffect which means it gives the player a choice of effects when triggered)
                effect = pushChoiceEffect({
                    -- magic armor choices
                    choices = {
                        {
                            -- sets the effect to draw a card (choice 1)
                            effect = drawCardsEffect(1),
                            --layout for choice one
                            layout = layoutCard({
                                -- card title for choice one
                                title = "Orc Pauldrons",
                                -- card art for choice one
                                art = "icons/battle_cry",
                                -- text for choice one
                                text = ("Draw 1. "),
                            }),
                            -- tag for choice one
                            tags = { draw1Tag }

                        },
                        {
                            -- sets the effect to gain 2 health (choice 2)
                            effect = gainHealthEffect(2),
                            -- layout for choice two
                            layout = layoutCard({
                                -- card title for choice two
                                title = "Orc Pauldrons",
                                -- card art for choice two
                                art = "icons/battle_cry",
                                -- text for choice two
                                text = ("{2 health}"),
                            }),
                            -- tag for choice two
                            tags = { gainHealth2Tag }
                        }
                    }
                }),
                -- trigger to activate magic armor
                trigger = uiTrigger,
                -- conditions to check to activate magic armor
                check = minDamageTakenOpp(5).And(minHealthCurrent(25)),
                -- cost to use magic armor
                cost = expendCost,
                -- tags for magic armor
                tags = { draw1Tag, gainHealthTag },
            })
        }
    })
end
