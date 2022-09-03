-- EFFECT TRIGGERS

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

-- cardEffectAbility TRIGGERS

--[[
 CardEffectAbilities must use CardEffects, which require specific card targets. The CardEffectAbility will 
 pass the acquired card as the target for the CardEffect assigned to it if the trigger is onAcquire or 
 postAcquire; it will pass the card whose location changed if the trigger is onLocationChanged. You can 
 also use selectTargets() to obtain the targets.

Additionally, for a card that contains a CardEffectAbility with the onLocationChanged trigger, when that 
card is first created, that ability will trigger, targeting every possible card.

You can pass a Simple Effect to the CardEffectAbility, it will be auto converted to a CardEffect.
]]


acquiredCardTrigger -- triggers before card is acquired
locationChangedCardTrigger -- triggers when a card is added to the market,created, or moved
postAcquiredCardTrigger -- triggers after card is acquired
postSelfAcquiredCardTrigger -- like postAcquired, but only triggers for the card itself
playedCardTrigger -- triggers after a card is played from hand. The trigger will happen after after played triggers, but before auto triggers happen. This way, if the played card trigger expends a champion, auto triggers will not fire.