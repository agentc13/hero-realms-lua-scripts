function paladin_jeweled_dagger_carddef()
    return createActionDef(
        {
            id = "paladin_jeweled_dagger",
            name = "Jeweled Dagger",
            types = {weaponType, noStealType, paladinType, itemType, magicWeaponType, meleeWeaponType, daggerType},
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "paladin_jeweled_dagger_ab",
                        trigger = autoTrigger,
                        effect = gainCombatEffect(2).seq(gainGoldEffect(1))
                            
                    }
                ),
                createAbility(
                    {
                        id = "paladin_jeweled_dagger_sac",
                        trigger = uiTrigger,
                        cost = sacrificeSelfCost,
                        promptType= showPrompt,
                        effect = pushTargetedEffect(
                                {
                                    desc = "Sacrifice a card from your discard pile.",
                                    min = 0,
                                    max = 1,
                                    validTargets = selectLoc(loc(currentPid,discardPloc)),
                                    targetEffect =sacrificeTarget(),
                                 }),
                        layout = createLayout({
                            name = "Jeweled Dagger",
                            art = "art/T_Influence",
                            frame = "frames/Cleric_CardFrame",
                            text = '<size=170%><line-height=75%><sprite name="combat_2"> <sprite name=\"gold_1\"></line-height></size> \n<size=150%><line-height=50%><pos=-15%><sprite name=\"scrap\"><space=.3em></size><size=60%><voffset=1em>Sacrifice a card in your \ndiscard pile.</size></line-height>'
                        })

                    }
                )
            },
            layout = createLayout(
                {
                    name = "Jeweled Dagger",
                    art = "art/T_Influence",
                    frame = "frames/Cleric_CardFrame",
                    text = '<size=170%><line-height=75%><sprite name="combat_2"> <sprite name=\"gold_1\"></line-height></size> \n<size=150%><line-height=50%><pos=-15%><sprite name=\"scrap\"><space=.3em></size><size=60%><voffset=1em>Sacrifice a card in your \ndiscard pile.</size></line-height>'
                }
            )
        }
    )
end