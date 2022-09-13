function paladin_oath_of_devotion_carddef()
	return createHeroAbilityDef({
		id = "oath_of_devotion",
		name = "Oath of Devotion",
		types = { heroAbilityType },
        abilities = {
            createAbility( {
                id = "oath_of_devotion_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                promptType = showPrompt,
                layout = createLayout ({
                    name = "Oath of Devotion",
                    art = "art/T_Devotion",
                    text = "Prepare up to 3 champions in play. Those champions gain +1 <sprite name=\"shield\"> until they leave play"
                    }),
                effect = pushTargetedEffect({
                    desc = "Choose up to 3 champions in play. Prepare those champions and they gain +1 defense until they leave play.",
                    validTargets = s.CurrentPlayer(CardLocEnum.InPlay).where(isCardChampion()),
                    min = 1,
                    max = 3,
                    targetEffect = prepareTarget().seq(grantHealthTarget(1, { SlotExpireEnum.LeavesPlay }, nullEffect(), "shield")),
			    }),
                cost = sacrificeSelfCost,
            }),
        },
        layout = createLayout({
            name = "Oath of Devotion",
            art = "art/T_Devotion",
            text = "Prepare up to 3 champions in play. Those champions gain +1 <sprite name=\"shield\"> until they leave play"
        }),
        layoutPath  = "art/T_Devotion",
	})
end	