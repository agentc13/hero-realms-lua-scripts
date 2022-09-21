function paladin_oath_of_righteousness_carddef()
	return createHeroAbilityDef({
		id = "oath_of_righteousness",
		name = "Oath of Righteousness",
		types = { heroAbilityType },
        abilities = {
            createAbility( {
                id = "oath_of_righteousness_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                promptType = showPrompt,
                layout = createLayout ({
                    name = "Oath of Righteousness",
                    art = "art/T_Devotion",
                    text = "Prepare up to 3 champions in play. Gain +1 <sprite name=\"combat\"> for each champion you have in play." 
                    }),
                effect = pushTargetedEffect({
                    desc = "Choose up to 3 championsin play. Prepare those champions. Gain +1 Combat for each champion you have in play.",
                    validTargets = s.CurrentPlayer(CardLocEnum.InPlay).where(isCardChampion()),
                    min = 1,
                    max = 3,
                    targetEffect = prepareTarget().seq(gainCombatEffect(selectLoc(loc(currentPid, inPlayPloc)).count())),
			    }),
                cost = sacrificeSelfCost,
            }),
        },
        layout = createLayout({
            name = "Oath of Righteousness",
            art = "art/T_Devotion",
            text = "Prepare up to 3 champions in play. Gain +1 <sprite name=\"combat\"> for each champion you have in play"
        }),
        layoutPath  = "art/T_Devotion",
	})
end	