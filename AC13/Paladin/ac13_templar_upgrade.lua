function paladin_templar_carddef()
    return createChampionDef(
        {
            id = "paladin_templar",
            name = "Templar",
            acquireCost = 0,
            health = 3,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "templar_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = pushChoiceEffect(
                            {
                                choices = {
                                    {
                                        effect = gainCombatEffect(2),
                                        layout = layoutCard(
                                            {
                                                title = "Templar",
                                                art = "avatars/man_at_arms",
                                                text = ("{2 combat}")
                                            }
                                        ),
                                        tags = {gainCombatTag}
                                    },
                                    {
                                        effect = gainHealthEffect(2),
                                        layout = layoutCard(
                                            {
                                                title = "Templar",
                                                art = "avatars/man_at_arms",
                                                text = ("{2 health}")
                                            }
                                        ),
                                        tags = {gainHealthTag}
                                    }
                                }
                            }
                        )
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Templar",
                    art = "avatars/man_at_arms",
                    frame = "frames/Cleric_CardFrame",
                    text = '<voffset=.5em><size=200%><sprite name=\"expend\"></size><br></line-height><size=150%><sprite name=\"combat_2\"></size> or<size=150%> <sprite name=\"health_2\"></size>',
                    health = 3,
                    isGuard = true
                }
            )
        }
    )
end