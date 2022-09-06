-- The example code was taken from the Piercing Screech hero ability that is part of the custom Witch class by Userkaffe. The comments are from agentc13. This template will not work on it's own without the gameSetup script.


-- carddef function, this creates the card and is referred to in the game setup.
function piercing_screech_def()
	-- createHeroAbilityDef() This is where we create all the variables for the card.
	return createHeroAbilityDef({
		-- a unique id for the card
		id = "piercing_screech",
		-- Title of card
		name = "Piercing Screech",
		-- An array of strings where we list the types this card possesses.
		types = { heroAbilityType },
		-- array of abilities that the card will have
        abilities = {
			createAbility({
				-- a unique id for the ability
				id = "piercingScreechActivate",
				-- one of the triggers listed in documentation under 'creating abilities' this one is triggered when the ability is clicked on in game.
				trigger = uiTrigger,
				-- this shows a prompt when the card is triggered
				promptType = showPrompt,
				-- ability layout, you can refer to the template_createAbility.lua for more info about this
				layout = createLayout({
					name = "Piercing Screech",
					art = "art/T_Flesh_Ripper",
					text = "<size=150%><sprite name=\"scrap\">:<br><size=120%>Target opponent discards two cards."
				}),
				-- an effect to run when triggered, this causes the opponent to discard 2 cards.
				effect = oppDiscardEffect(2),
				-- the cost to use the ability. this requires that the ability be sacrificed (i.e. can be used only once per game).
				cost = sacrificeSelfCost
			})
		},
		-- card layout
		layout = createLayout({
			-- Title of card (as it appears in the top banner)
			name = "Piercing Screech",
			-- Art used for card
			art = "art/T_Flesh_Ripper",
			-- Text layout, refer to 'Layout Text Formatting' section in Lua documentation
			text = "<size=150%><sprite name=\"scrap\">:<br><size=120%>Target opponent discards two cards."
		}),
		layoutPath= "art/T_Flesh_Ripper"
	})
end	