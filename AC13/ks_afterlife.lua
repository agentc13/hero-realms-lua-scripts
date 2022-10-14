function afterlife_carddef()
    local cardLayout =
        createLayout(
        {
            name = "Afterlife",
            art = "art/T_Feisty_Orcling",
            frame = "frames/HR_CardFrame_Action_Necros",
            cost = 3,
            text = '<size=200%><sprite name="gold_2"> \nsprite name="necros"\n You may put a champion from your discard pile to the tope of your deck.'
        }
    )

    return createActionDef(
        {
            id = "afterlife",
            name = "Afterlife",
            types = {actionType},
            acquireCost = 3,
            abilities = {
                createAbility(
                    {
                        id = "afterlife_main",
                        trigger = autoTrigger,
                        effect = gainGoldEffect(2)
                    }
                ),
                createAbility(
                    {
                        id = "afterlife_faction",
                        trigger = autoTrigger,
                        effect = gainGoldEffect(2)
                    }
                )
            },
            layout = cardLayout
        }
    )
end
