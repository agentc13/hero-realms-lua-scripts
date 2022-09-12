function paladin_prayer_of_devotion_carddef()
    local cardLayout = createLayout({
        name = "Prayer of Devotion",
        art = "icons/wind_storm",
        frame = "frames/Cleric_CardFrame",
        text = "<size=400%><line-height=0%><voffset=-.25em> <pos=-75%><sprite name=\"expend_2\"></size><line-height=135%> \n <voffset=2em><size=120%><pos=10%>Gain <sprite name=\"health_3\">\n   Gain  <sprite name=\"combat_1\">"
    })

    return createSkillDef({
        id = "paladin_prayer_of_devotion_skill",
        name = "Prayer of Devotion",
        types = { paladinType, skillType },
        layout = cardLayout,
        layoutPath = "icons/wind_storm",
        abilities = {
            createAbility({
                id = "paladin_prayer_of_devotion_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
                effect = gainHealthEffect(3).seq(gainCombatEffect(3)),
                cost = goldCost(2),
            }),
        }
        
    })
end