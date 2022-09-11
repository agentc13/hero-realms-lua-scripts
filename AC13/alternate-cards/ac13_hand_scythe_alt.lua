function fighter_hand_scythe_carddef()
    return createActionDef(
        {
            id = "fighter_hand_scythe",
            name = "Hand Scythe",
            types = {weaponType, noStealType, fighterType, itemType, meleeWeaponType, scytheType},
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "fighter_hand_scythe",
                        trigger = autoTrigger,
                        effect = gainGoldEffect(2).seq(
                            pushTargetedEffect(
                                {
                                    desc = "Deal 3 damage to an opposing guard.",
                                    min = 1,
                                    max = 1,
                                    validTargets = selectLoc(loc(oppPid, inPlayPloc)).where(isCardStunnable()),
                                    targetEffect = damageTarget(3)
                                }
                            )
                        )
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Hand Scythe",
                    art = "art/T_Flesh_Ripper",
                    frame = "frames/Warrior_CardFrame",
                    text = '<size=50%><i>Replaces: Gold</i></size><br><size=170%><sprite name="gold_2"></size> <br><size=75%>Deal 3 damage to an opposing guard.</size>'
                }
            )
        }
    )
end


function setupMeta(meta)
    meta.name = "ac13_hand_scythe_alt"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/timot/OneDrive/Documents/Hero-Realms-Lua-Scripts/AC13/alternate-cards/ac13_hand_scythe_alt.lua"
     meta.features = {
}

end