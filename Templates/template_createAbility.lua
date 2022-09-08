--This template will not work on it's own, it will need to be part of a card script or without the gameSetup scripting.

-- Abilities link effects with their trigger times.
-- the basic code structure to creat an ability is createAbility({id, trigger, effect, cost, activations, check})
-- Abilites are usually part of a carddef and so this code snippet is something that you will see as part of a carddef script.

createAbility({
    -- This is the unique id of the ability.
    id = "ability_id",
    -- This sets up the layout for the ability card. 
    layout = layoutCard({
        -- Title for the ability.
        title = "Ability",
        -- Card art the ability. Lists of available art can be found in documentation under 'Image Resources'
        art = "icons/growing_flame",
        -- Text that will appear on ability's card. See 'Layout Text Formatting' documentation for details.
        text = ("Draw 1."),
    }),
    -- Here we set up the effect that happens when this ability is triggered. This example will draw 1 card.
    effect = drawCardsEffect(1),
    -- The trigger is where we set up when the ability can be activated (this is when the players deck is shuffled)
    trigger = deckShuffledTrigger,
    -- conditions to check to activate ability (this example requires 25hp to trigger)
    check = minHealthCurrent(25),
    -- cost to use ability. this requires you expend it and pay 2 gold.
    cost = costAnd({ expendCost, goldCost(2),})
})

