function paladin_oath_of_protection_carddef()
	return createHeroAbilityDef({
		id = "oath_of_protection",
		name = "Oath of Protection",
		types = { heroAbilityType },
        abilities = {
            createAbility( {
                id = "oath_of_protection_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                promptType = showPrompt,
                layout = createLayout ({
                    name = "Oath of Protection",
                    art = "art/T_Devotion",
                    text = "Prepare up to 3 champions in play. Those champions gain +1 <sprite name=\"shield\"> permanently."
                    }),
                effect = pushTargetedEffect({
                    desc = "Choose up to 3 champions in play. Prepare those champions and they gain +1 defense permanently.",
                    validTargets = s.CurrentPlayer(CardLocEnum.InPlay).where(isCardChampion()),
                    min = 1,
                    max = 3,
                    targetEffect = prepareTarget().seq(grantHealthTarget(1, { SlotExpireEnum.Never }, nullEffect(), "shield")),
			    }),
                cost = sacrificeSelfCost,
            }),
        },
        layout = createLayout({
            name = "Oath of Protection",
            art = "art/T_Devotion",
            text = "Prepare up to 3 champions in play. Those champions gain +1 <sprite name=\"shield\"> permanently."
        }),
        layoutPath  = "art/T_Devotion",
	})
end	