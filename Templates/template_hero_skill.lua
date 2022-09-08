-- The example code was taken from the Piercing Screech hero ability that is part of the custom Witch class by Userkaffe. The comments are from agentc13. This template will not work on it's own without the gameSetup script.


-- carddef function, this creates the card and is referred to in the game setup.
function siphon_life_def()
	-- createSkillDef() This is where we create all the variables for the card.
	return createSkillDef({
		-- a unique id for the card
		id = "siphon_life",
		-- Title of card
		name = "Siphon Life",
		-- An array of strings where we list the types this card possesses.
		types = { skillType },
		-- array of abilities that the card will have
        abilities = {
			createAbility({
				-- a unique id for the ability
				id = "siphonLifeActivate",
				-- one of the triggers listed in documentation under 'creating abilities' this one is triggered when click on the skill in game
				trigger = uiTrigger,
				-- this shows a prompt when the skill is triggered
				promptType = showPrompt,
				-- ability layout, you can refer to the template_createAbility.lua for more info about this
				layout = createLayout({
					name = "Siphon Life",
					art = "art/T_The_Rot",
					text = "<size=150%><sprite name=\"expend\">,<size=130%><sprite name=\"gold_2\">:<br><size=80%>You gain 1<sprite name=\"health\"> and your opponent loses 1<sprite name=\"health\">.<br>This also affects maximum health."
				}),
				-- an effect to run when triggered. This effect heals the player for 1, and damages the opponent for 1.  It also changes each player's max health by 1 respectively.
				effect = gainMaxHealthEffect(currentPid, 1).seq(gainHealthEffect(1)).seq(hitOpponentEffect(1)).seq(gainMaxHealthEffect(oppPid, -1)),
				-- the cost to use the ability. this requires that the player pay 2 gold to activate the skill.
				cost = goldCost(2)
			})
		},
		-- card layout
		layout = createLayout({
			-- Title of card (as it appears in the top banner)
			name = "Siphon Life",
			-- Art used for card
			art = "art/T_The_Rot",
			-- Text layout, refer to 'Layout Text Formatting' section in Lua documentation
			text = "<size=150%><sprite name=\"expend\">,<size=130%><sprite name=\"gold_2\">:<br><size=80%>You gain 1<sprite name=\"health\"> and your opponent loses 1<sprite name=\"health\">.<br>This also affects maximum health."
		}),
		layoutPath= "art/T_The_Rot"
	})
end	