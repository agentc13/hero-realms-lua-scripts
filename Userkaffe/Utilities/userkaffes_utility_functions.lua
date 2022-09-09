--NOTICE:
--	I currently don't know a way to import library files so that Hero Realms app would accept them.
--	At the moment the only way to use these functions is to copy-and-paste them into your lua-file.

--CONTENTS:
--cycleCardsEffect(int num)		// effect: discard up to num cards, then draw that many cards.
--redrawCardsEffect(int num)	// effect: draw up to num cards, then discard that many cards.

-- This function returns an effect that lets the player to discard up to 'num' cards, then draw that many cards.
-- There is no prompt here, the game will just ask the player to discard, and the draw will be based on number of cards selected.
function cycleCardsEffect(num)
	return pushTargetedEffect({
		desc = "Discard up to " .. tostring(num) .. " cards.",
		min = 0,
		max = num,
		validTargets = selectLoc(currentHandLoc),
		targetEffect = discardTarget().seq(drawCardsEffect(selectTargets().count()))
	})
end

-- This function returns an effect that lets the player to draw up to 'num' cards, then discard that many cards.
-- Player will be prompted about how many cards they want to draw and discard.
-- If 'num' is 4 or more, only options for drawing 0, 1, 2 and 'num' cards will be available, because the in-game prompt can only handle four entries.
function redrawCardsEffect(num)
	local choiceTable = {}	
		
	choiceTable[1] = {
		effect = nullEffect(),                  
		layout = layoutCard({
			title = "Do nothing.",
			art = "art/T_Heist",
			text = "<size=120%>Do nothing."
		})
	}
	
	if (num > 0) then
		choiceTable[2] = {
			effect = drawCardsEffect(1).seq(pushTargetedEffect({
				desc = "Discard a card.",
				min = 1,
				max = 1,
				validTargets = selectLoc(currentHandLoc),
				targetEffect = discardTarget()
			})),                  
			layout = layoutCard({
				title = "Redraw 1.",
				art = "art/T_Heist",
				text = "<size=120%>Draw a card, then discard a card."
			})
		}
	end
	
	if (num > 1) then
	choiceTable[3] = {
			effect = drawCardsEffect(2).seq(pushTargetedEffect({
				desc = "Discard two cards.",
				min = 2,
				max = 2,
				validTargets = selectLoc(currentHandLoc),
				targetEffect = discardTarget()
			})),                  
			layout = layoutCard({
				title = "Redraw 2.",
				art = "art/T_Heist",
				text = "<size=120%>Draw up to two cards, then discard two cards."
			})
		}
	end
	
	if (num > 2) then
	choiceTable[4] = {
			effect = drawCardsEffect(num).seq(pushTargetedEffect({
				desc = "Discard " .. tostring(num) .. " cards.",
				min = num,
				max = num,
				validTargets = selectLoc(currentHandLoc),
				targetEffect = discardTarget()
			})),                  
			layout = layoutCard({
				title = "Redraw " .. tostring(num) .. ".",
				art = "art/T_Heist",
				text = "<size=120%>Draw " .. tostring(num) .. " cards, then discard " .. tostring(num) .. " cards."
			})
		}
	end
	
	return pushChoiceEffect({
		choices = choiceTable
	})
end