function paladin_oath_of_vengeance_carddef()
	return createHeroAbilityDef({
		id = "oath_of_vengeance",
		name = "Oath of Vengeance",
		types = { heroAbilityType },
        abilities = {
            createAbility( {
                id = "oath_of_vengeance_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                promptType = showPrompt,
                layout = createLayout ({
                    name = "Oath of Vengeance",
                    art = "art/T_Devotion",
                    text = "Expend up to 3 friendly champions in play. Gain <sprite name=\"combat\"> equal to their total <sprite name=\"shield\"> values. Draw 1."
                    }),
                effect = pushTargetedEffect({
                    desc = "Choose up to 3 friendly champions in play. Expend those champions and gain Combat equal to their total Defense. Draw a Card.",
                    validTargets = s.CurrentPlayer(CardLocEnum.InPlay).where(isCardChampion().And(isCardStunnable())),
                    min = 1,
                    max = 3,
                    targetEffect = expendTarget().seq(gainCombatEffect(selectTargets().sum(getCardHealth()))).seq(drawCardsEffect(1)),
			    }),
                cost = sacrificeSelfCost,
            }),
        },
        layout = createLayout({
            name = "Oath of Vengeance",
            art = "art/T_Devotion",
            text = "Expend up to 3 friendly champions in play. Gain <sprite name=\"combat\"> equal to their total <sprite name=\"shield\"> values. Draw 1."
        }),
        layoutPath  = "art/T_Devotion",
	})
end	