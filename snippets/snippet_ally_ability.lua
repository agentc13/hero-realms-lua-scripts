local ally_ab = createAbility({
    id = "life_drain_auto",
    layout = loadLayoutTexture("Textures/life_drain_auto"),
    allyFactions = {necrosFaction},
    effect = drawCardsWithAnimation(1),
    trigger = uiTrigger,
    promptType = showPrompt,
    tags = {draw1Tag,allyTag}
})