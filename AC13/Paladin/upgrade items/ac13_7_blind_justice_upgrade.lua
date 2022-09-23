function paladin_blind_justice_carddef()
    return createActionDef(
        {
            id = "paladin_blind_justice",
            name = "Blind Justice",
            types = { actionType, noStealType},
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "paladin_blind_justice_ab",
                        trigger = autoTrigger,
                        effect = damageTarget(1).apply(selectTargets().where(isCardChampion()))
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Blind Justice",
                    art = "art/T_Pillar_Of_Fire",
                    frame = "frames/Cleric_CardFrame",
                    ext = 'Deal 2 damage to opponent, and 1 damage to each opposing champion.'
                }
            )
        }
    )
end