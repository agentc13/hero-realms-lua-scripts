function paladin_lightbringer_carddef()
    return createActionDef(
        {
            id = "paladin_lightbringer",
            name = "Lightbringer",
            types = {weaponType, noStealType, paladinType, itemType,holyRelicType, magicWeaponType, meleeWeaponType, swordType},
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "paladin_lightbringer",
                        trigger = autoTrigger,
                        effect = gainCombatEffect(3).seq(
                            pushTargetedEffect(
                                {
                                    desc = "Stun target champion.",
                                    min = 1,
                                    max = 1,
                                    validTargets = selectLoc(loc(oppPid, inPlayPloc)).where(isCardStunnable()),
                                    targetEffect =stunTarget()
                                }
                            )
                        ),
                        check = selectLoc(currentCastLoc).where(isCardType(weaponType)).count().gte(1),
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Lightbringer",
                    art = "art/T_Flesh_Ripper",
                    frame = "frames/Warrior_CardFrame",
                    text = '<size=50%><i>Replaces: Longsword/i></size><br><size=170%><sprite name="combat_3"></size> <br><size=75%>If you have played another weapon this turn, stun target champion.</size>'
                }
            )
        }
    )
end