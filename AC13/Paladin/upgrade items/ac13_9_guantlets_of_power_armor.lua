function paladin_gauntlets_of_power_carddef()
    local cardLayout =
        createLayout(
        {
            name = "Gauntlets of Power",
            art = "icons/wizard_spellcaster_gloves",
            frame = "frames/Cleric_armor_frame",
            text = ('<size=300%><line-height=0%><voffset=-.8em> <pos=-75%><sprite name="requiresHealth_20"></size><line-height=80%> \n <voffset=1.8em><size=80%> If you have dealt 5 <sprite name="combat"> to an opponent this turn. \n  Gain 2 <sprite name="health"> \n or Draw 1 \n then discard 1 </size>')
        }
    )

    return createMagicArmorDef(
        {
            id = "gauntlets_of_power",
            name = "Gauntlets of Power",
            layout = cardLayout,
            layoutPath = "icons/wizard_spellcaster_gloves",
            abilities = {
                createAbility(
                    {
                        id = "gauntlets_of_power",
                        layout = cardLayout,
                        effect = pushChoiceEffect(
                            {
                                choices = {
                                    {
                                        effect = drawCardsEffect(1).seq(
                                            pushTargetedEffect(
                                                {
                                                    desc = "Discard a card",
                                                    min = 1,
                                                    max = 1,
                                                    validTargets = selectLoc(currentHandLoc),
                                                    targetEffect = discardTarget()
                                                }
                                            )
                                        ),
                                        layout = layoutCard(
                                            {
                                                title = "Gauntlets of Power",
                                                art = "icons/wizard_spellcaster_gloves",
                                                text = ("Draw 1 then discard 1.")
                                            }
                                        ),
                                        tags = {cycle1Tag}
                                    },
                                    {
                                        effect = gainGoldEffect(1),
                                        layout = layoutCard(
                                            {
                                                title = "Gauntlets of Power",
                                                art = "icons/wizard_spellcaster_gloves",
                                                text = ("{1 gold}")
                                            }
                                        ),
                                        tags = { gainGold1Tag }
                                    }
                                }
                            }
                        ),
                        trigger = uiTrigger,
                        check = minDamageTakenOpp(5).And(minHealthCurrent(30)),
                        cost = expendCost,
                        tags = { draw1Tag, gainGold1Tag }
                    }
                )
            }
        }
    )
end