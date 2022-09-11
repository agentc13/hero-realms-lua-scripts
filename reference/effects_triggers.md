## Effects

### Simple Effect

```lua
endGameEffect()
showMessageEffect(message)
```

Game state effects:

```lua
gainCombatEffect(int(expression))
gainGoldEffect(int(expression))
gainHealthEffect(int(expression))
drawCardsEffect(int(expression))
drawToLocationEffect(intExpression, locExpression) -- draws count cards to location
hitOpponentEffect(int(expression)) -- deals damage to opponent
hitSelfEffect(int(expression)) -- deals damage to self
oppDiscardEffect(int(expression)) -- makes opponent discard cards when their turn starts
createCardEffect(cardId, location) -- creates a card at location
endGameEffect(winnerId, endReason) -- ends game with a winner and given reason
setMarketLengthEffect(int) -- sets length of market row to the value
incrementCounterEffect(string counterId, int(Expression)) -- increments given counter by the incoming integer value
shuffleEffect(locExr) -- shuffles all cards contained in the passed location
```

Conditionals (conditions are bool expressions):

```lua
ifEffect(condition, simpleEffect)  -- if condition is true, executes the effect
ifElseEffect(condition, yesSimpleEffect, noSimpleEffect) -- if condition is true executes yes effect, otherwise no effect
```

Specials:

```lua
noUndoEffect() -- prevents user from undoing their actions from this point
nullEffect() -- does nothing - can be used to do nothing in certain cases
```

Random selection:

```lua
randomEffect({valueItem1, valueItem2, ...}) --Value item is an integer/simple effect pair. Integers represent weight of the given item. Say we have 5, 2, 1 items in the list. Item with 5 has the most chances to be selected.

valueItem(int, effect) -- creates value item for RandomEffect, where determines probability of an effect to be randomly selected.
```

Control flow:

```lua
equalSwitchEffect(intExpression, defaultSimpleEffect, valueItems[]) -- value item is an integer/simple effect pair. Integers represent value of incoming integer to be compared to. Effect from value item with matching integer will be executed. If none of the items match, default effect is executed.
```

Animations / text:

```lua
animateShuffleEffect(player) -- plays deck shuffle animation
showOpponentTextEffect(text) -- shows text to the opponent
hideOpponentTextEffect(text) -- hides previously shown opponent text
showCardEffect(layout) -- you may build a layout to be shown to player for several seconds or until clicked.
-- createLayout("avatars/troll", "Injured Troll I", "{combat}", "The troll gets angry")
showTextEffect(text) --shows text on the screen
waitForClickEffect(playerText, oppText)-- shows text to corresponding player and waits for click
customAnimationEffect({id, player}) --- plays a custom animation with “id” for “player”
cardAbilityAnimationEffect({ id, layout }) -- plays card animation with “id” style and “layout” card face
```

### Card Effects

Game state card effects:

```lua
sacrificeTarget() -- sacrifices targets
acquireForFreeTarget(loc) -- acquires targets for free to location
acquireTarget(int discount, loc) -- acquires targets to location with a discount
addSlotToTarget(slot) -- adds a slot to targets
damageTarget(intExpression) -- deals damage to targets
discardTarget() -- discards targets
expendTarget() -- expends targets
grantHealthToTarget(intExpression) -- grants +X defense to target champions
moveTarget(locExr) -- moves targets to location
moveToTopDeckTarget() -- moves targets to top of current player’s deck
nullTarget() -- does nothing
playTarget() -- plays targets
prepareTarget() --prepares targets
stunTarget() -- stuns target
transformTarget(cardStringId) -- transforms target to a card with the given id
modifyCardDefTarget(healthDelta, ability) --- gives an existing card a modified health value and/or a new ability
```

Random card effects:

```lua
probabilityTarget({ chance, onSuccessTarget, onFailureTarget}) -- executes onSuccess target effect with chance probability, otherwise executes onFailureTarget effect.
randomTarget(cardEffect, intExpression) --
```

Animation card effects:

```lua
showTextTarget(text) -- show the provided text above the target card

```

Control flow card effects:

```lua
ifElseTarget(boolCardExpression, yesCardEffect, noCardEffect) - same as ifElseEffect

```

Control flow:

```lua
equalSwitchEffect(intExpression, defaultSimpleEffect, valueItems[]) -- value item is an integer/simple effect pair. Integers represent value of incoming integer to be compared to. Effect from value item with matching integer will be executed. If none of the items match, default effect is executed.
```

Animations / text:

```lua
animateShuffleEffect(player) -- plays deck shuffle animation
showOpponentTextEffect(text) -- shows text to the opponent
hideOpponentTextEffect(text) -- hides previously shown opponent text
showCardEffect(layout) -- you may build a layout to be shown to player for several seconds or until clicked.
-- createLayout("avatars/troll", "Injured Troll I", "{combat}", "The troll gets angry")
showTextEffect(text) --shows text on the screen
waitForClickEffect(playerText, oppText)-- shows text to corresponding player and waits for click
customAnimationEffect({id, player}) --- plays a custom animation with “id” for “player”
cardAbilityAnimationEffect({ id, layout }) -- plays card animation with “id” style and “layout” card face
```

Game State Card Effects:

```lua
startOfTurnTrigger
endOfTurnTrigger
endOfOppTurnTrigger
oppStartOfTurnTrigger
autoTrigger -- automatic trigger, like death cultist's expend ability has auto trigger
onExpendTrigger
onSacrificeTrigger
uiTrigger -- user will need to manually trigger it
onAcquireTrigger -- triggers every time you acquire any card, not just the card with the onAcquire ability
onPlayTrigger -- triggers every time you play any card, not just the card with the onPlay ability
startOfGameTrigger
endOfGameTrigger
deckShuffledTrigger = ActivationTrigger.DeckShuffled
```

Costs:

```lua
expendCost
sacrificeSelfCost
goldCost(value)
sacrificeSelfCost
costAnd({ expendCost, goldCost(value) })
```

Card Effect Triggers:

```lua
acquiredCardTrigger -- triggers before card is acquired
locationChangedCardTrigger -- triggers when a card is added to the market,created, or moved
postAcquiredCardTrigger -- triggers after card is acquired
postSelfAcquiredCardTrigger -- like postAcquired, but only triggers for the card itself
playedCardTrigger -- triggers after a card is played from hand. The trigger will happen after after played triggers, but before auto triggers happen. This way, if the played card trigger expends a champion, auto triggers will not fire.
```

Card Ability Triggers:

```lua
startOfTurnTrigger
endOfTurnTrigger
endOfOppTurnTrigger
oppStartOfTurnTrigger
autoTrigger -- automatic trigger, like death cultist's expend ability has auto trigger
onExpendTrigger
onSacrificeTrigger
uiTrigger -- user will need to manually trigger it
onAcquireTrigger -- triggers every time you acquire any card, not just the card with the onAcquire ability
onPlayTrigger -- triggers every time you play any card, not just the card with the onPlay ability
startOfGameTrigger
endOfGameTrigger
deckShuffledTrigger = ActivationTrigger.DeckShuffled
```
