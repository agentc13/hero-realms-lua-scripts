function paladin_guardians_shield_carddef()
    local cardLayout =
        createLayout(
        {
            name = "Guardian's Shield",
            art = "icons/cleric_brightstar_shield",
            frame = "frames/Warrior_CardFrame",
            text = ('<size=300%><line-height=0%><voffset=-.4em> <pos=-75%><sprite name="requiresHealth_20"></size><line-height=80%>\n <voffset=1.8em><size=80%><sprite name=\"expend\"> \n Gain 2 <sprite name="combat"> for\n  each champion\n  you have in\n  play.</size>')
        }
    )

    return createMagicArmorDef(
        {
            id = "guardians_shield",
            name = "Guardian's Shield",
            layout = cardLayout,
            layoutPath = "icons/cleric_brightstar_shield",
            abilities = {
                createAbility({
                    id = "paladin_guardians_shield_ab",
                    trigger = uiTrigger,
                    effect = gainCombatEffect(selectLoc(currentInPlayLoc).where(isCardChampion()).count().multiply(2)), 
                    check = minHealthCurrent(20).And(selectLoc(currentInPlayLoc).where(isCardChampion()).count().gte(1)),
                    cost = expendCost,
                    tags = {}
                })
            }
        }
    )
end