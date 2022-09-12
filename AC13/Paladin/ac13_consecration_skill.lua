function paladin_consecration_carddef()
    local cardLayout = createLayout({
        name = "Consecration",
        art = "icons/wind_storm",
        frame = "frames/Cleric_CardFrame",
        text = "<size=400%><line-height=0%><voffset=-.25em> <pos=-75%><sprite name=\"expend_2\"></size><line-height=135%> \n <voffset=2em><size=120%><pos=10%>Gain <sprite name=\"health_4\">\n   Gain  <sprite name=\"combat_2\">"
    })

    return createSkillDef({
        id = "paladin_consecration_skill",
        name = "Consecration",
        types = { paladinType, skillType },
        layout = cardLayout,
        layoutPath = "icons/wind_storm",
        abilities = {
            createAbility({
                id = "paladin_consecration_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
                effect = gainHealthEffect(4).seq(gainCombatEffect(2)),
                cost = goldCost(2),
            }),
        }
        
    })
end