-- This is a template to create and action card.

-- carddef function, this creates the card and is referred to in the game setup.
function confused_apparition_carddef()
    -- createActionDef() This is where we vreate all the variable for the card.
    return createActionDef({
        -- a unique id for the card
        id="confused_apparition",
        -- Title of card
        name="Confused Apparition",
        -- array of strings where we list the types this card possesses.
        types={noStealType},
        -- cost to acquire, this is 0 as it has no cost.
        acquireCost=0,
        -- array of abilities that the card will have
        abilities = {
            createAbility({
                -- unique id of the ability (within a card)
                id="confused_apparition_auto",
                -- one of the triggers listed in documentation under 'creating abilities'
                trigger= autoTrigger,
                -- an effect to run when triggered, this card checks if you have a weak skeleton in play, if not it will heal your opponent for 1.
                effect = ifEffect(selectLoc(currentInPlayLoc).where(isCardName("weak_skeleton")).count().lte(0), healPlayerEffect(oppPid, 1))
            })
        },
        -- if we want to dynamically generate the card layout we use this.  we can also load a card texture as layout 'loadLayoutTexture("Textures/death_touch")'
        layout = createLayout({
            -- Title of card
            name = "Confused Apparition",
            -- Frame used for card
            frame = "frames/Coop_Campaign_CardFrame",
            -- Text on card
            text = "Opponent gains 1 <sprite name=\"health\"> unless you have a Weak Skeleton in play."
        })
})
end