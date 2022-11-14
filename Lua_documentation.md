Lua Effect Documentation v1.1

Changes in 1.1
1. IMPORTANT - set of mandatory player buffs changed. Check updated example scripts and update your scripts correspondingly
2. transformTarget now properly changes card face on the board
3. nuUndoEffect renamed to noUndoEffect
4. createNoStunSlot added
5. createNoDamageSlot added
6. onZeroHealthTrigger added
7. onLeavePlay trigger added
8. drawToLocation can now directly accept integer
9. createLayout(t) is now only way to create layouts for all types of items - cards, abilities, choices
10. deck management fixed and should be more flexible now. you may easily clear hero deck on start now. See example_script_vs_ai_advanced_deck_management.lua for reference
11. more frames. Frames with faction icon on another side added
12. storytelling effects section added
13. coop scenarios development support (see coop_pirates_example.lua)
14. new card formatting option in “xmltext” field. See examples below. You may still use “text” for simple things, but for complex formatting - only xmltext
15. new arts available
Goal

To standardize naming of all lua effects to make it clear what kind of effect it is.

At a high level

- all lua functions will start with a lowercase
- card definitions should only call other lua functions, which will delegate to c# as required

Other goals:

- as few top level functions as possible
- try to use methods to free the user from having to remember how to deal with similar related types, e.g. intexpression, intcardexpression etc


Overview

The rule engine is built using a few concepts that are combined together to form the full effect system that is used to implement all the cards and effects in the game

Selectors are used to select cards, e.g. cards in the market row, cards in hand, champions with 3 or more defense etc.

Effects are used to change the game state, e.g. sacrifice, add combat etc.

We combine selectors and effects to implement most things in the game, e.g. sacrifice a card in hand.

Abilities are used to hold effects and their trigger times (i.e. when the effect happens). For example:

Gold card ability:

- Trigger: when played
- Effect: Gain 1 gold

Effects can be combined by sequenced them into longer chains of effects. For example,

Command card ability:

- Trigger: when played
- Effect: Sequence of (gain 2 gold, gain 3 combat, gain 4 health, draw a card)

Some abilities can automatically be triggered when a condition happens, e.g 

Arkus’s Ally Ability:

- Trigger: automatic
- Trigger condition: When Imperial ally ability is met
- Effect: Gain 6 health


Players

Predefined constants to select players:

currentPid -  current player
nextPid - next player to take a turn
oppPid - opponent of current player
nextAllyPid - next ally player
nextOppPid - next opponent

Locations

To specify a location:

loc(player, ploc), where ploc is (ends with Ploc or player loc):

inPlayPloc
discardPloc
handPloc
castPloc
deckPloc
buffsPloc
skillsPloc
revealPloc - common reveal location for any cards that get revealed to both players
myRevealPloc - used when you need to reveal cards only to player

also, predefined locs without a need to specify player (ends with -Loc):

centerRowLoc
fireGemsLoc
tradeDeckLoc
revealLoc

currentInPlayLoc
currentCastLoc
currentDeckLoc
currentHandLoc
currentDiscardLoc
currentBuffsLoc
currentSkillsLoc
currentRevealLoc

Examples:


    -- these two are the same
    currentInPlayLoc
    loc(currentPid, inPlayPloc)


Factions


    wildFaction
    guildFaction
    necrosFaction
    imperialFaction
BoolCardExpressions (TODO: check if all expressions are present)

They all start with isCard-

isCardExpended()
isCardStunned()
isCardStunnable()
isCardChampion()
isCardAction()
isCardFaction(Faction.Wild)
isCardType(“Knife”) -> checks type and subtype
isCardName(“thief_throwing_knife”) → checks card id
isCardAtLoc(ploc) → true if target is in the passed CardLocEnum
isGuard()

operators
.And(isCardXX()), .Or(isCardXX()), .invert()
Note that these are uppercase, as and/or are keywords in lua

constBoolExpression(value) returns a BoolExpression that always returns the value it was initially passed.

Usage
Bool card expressions are mostly used to filter out data from selectors (see below)

Examples:


    -- selects cards from opponent's in play, which are not expended and can be stunned
    
    selectLoc(loc(oppPid, inPlayPloc)).where(isCardExpended().invert().And(isCardStunnable()))


Selectors TODO: check if there are more predefined selectors

Selectors are used to start a chain of selecting cards. All selectors start with the selectX:

selectLoc(loc): select cards in a location
selectSource(): select source card
selectTargets(): selects target from targeted effect or cardeffect ability trigger.
selectOppStunnable(): select all opponent’s champions that can be stunned

Filtering

selector.where(BoolCardExpression) to filter by a property on each card

Example:


    -- selects cards from opponent's in play, which are not expended and can be stunned
    
    selectLoc(loc(oppPid, inPlayPloc)).where(isCardExpended().invert().And(isCardStunnable()))

Chaining

selector1.union(selector2) to return the union of both selectors.


    -- returns cards from the market and fire gems
    selectLoc(centerRowLoc).union(selectLoc(fireGemsLoc)).where(isCardAffordable().And(isCardAcquirable()))

selector.exclude(selectSource()) to exclude the source card

Ordering

selector.order(intcardexpression) to order by the provided value
.orderDesc(intcardexpression)

.reverse() to reverse the order

selector.take(n) to take the first X cards
.take(intExpression)

Conversions

To Int: .count()

or
.sum(intcardexpression) , e.g. .sum(getCardCost())

You can use .take(1).sum(getCardCost()) to get the cost of a single card, e.g. for comparison

Predefined selectors

We predefine commonly used selectors in lua

selectCurrentChampions()
selectNextChampions()

Examples

to select all stunned champions

selectCurrentChampions().where(isCardStunned())

to count all cards in opponent’s hand

selectLoc(loc(nextPid, handPloc)).count()

action cards in trade row

selectLoc(centerRowLoc).where(isCardAction())


IntExpression TODO: check if we have all int expressions specified here

Most int expressions start with get-

From selector: selector.count()

getCounter(counter)
getPlayerHealth(pid)
getPlayerCombat(pid)
getPlayerGold(pid)
getPlayerDamageReceivedThisTurn(pid)
getTurnsPlayed(pid)
getSacrificedCardsCounter()

constant int:
const(int)

Arithmetic
.add(intExpression), .multiply(intExpression), negate()
use negate with add to subtract

Conversions: 
.gte(intExpression or int), .lte(intExpression or int), .eq(intExpression or int)

Used when you need to check for something - returns BoolExpression

Conditional:
ifInt(boolExpression, intExpression1, intExpression2) - if bool true - returns expression1, otherwise expression 2

Operations:

minInt(intExp, intExp) - returns min of two values


StringExpression

There are several places where we can show dynamic strings. To create a dynamic string, just use the format function.

format(“{0}”, { int, intexpressoin etc})


IntCardExpression

These start with getCard-

getCardCost()
getCardHealth()


BoolExpression

hasClass(playerExpression, heroClass)
hasPlayerSlot(playerExpression, slot)
constBoolExpression(value) - constant value

Negate

.invert() to negate, e.g. isExpended().invert() returns false if the card is expended (not is a reserved word in lua)

Combining

.And(boolExp), .Or(boolExp)


Extended examples TODO: add more examples for selectors

Select all cards in trade row where their cost is greater than the players’ gold

selectTradeRow().where(getCardCost().gt(getPlayerGold(currentPid)))

Note that getCardCost() is a IntCardExpr, the gt() accepts an IntExpr, which should get upgraded to an IntCardExpr, and the entire expression becomes a boolcardexpr


Effects
Simple Effect TODO: check if all available effects are present here

All simple effects end with the word -Effect. These require no input from user.


- endGameEffect()
- showMessageEffect(message)

We can chain simple effects together with

effect1.seq(effect2).seq(effect3)

We can repeat simple effect execution with

effect1.doRepeat(intExpression)

Predefined simple effects:

Game state effects


- gainCombatEffect(int(expression))
- gainGoldEffect(int(expression))
- gainHealthEffect(int(expression))
- drawCardsEffect(int(expression))
- drawToLocationEffect(intExpression, locExpression) - draws count cards to location
- hitOpponentEffect(int(expression)) - deals damage to opponent
- hitSelfEffect(int(expression)) - deals damage to self
- oppDiscardEffect(int(expression)) - makes opponent discard cards when their turn starts
- createCardEffect(cardId, location) - creates a card at location
- endGameEffect(winnerId, endReason) - ends game with a winner and given reason
- setMarketLengthEffect(int) - sets length of market row to the value
- incrementCounterEffect(string counterId, int(Expression)) - increments given counter by the incoming integer value
- resetCounterEffect(string counterId) - resets counter to 0
- shuffleEffect(locExr) - shuffles all cards contained in the passed location
- shuffleTradeDeckEffect() - shuffles trade deck

Conditionals
conditions are bool expressions


- ifEffect(condition, simpleEffect)  - if condition is true, executes the effect
- ifElseEffect(condition, yesSimpleEffect, noSimpleEffect) - if condition is true executes yes effect, otherwise no effect

Specials


- noUndoEffect() - prevents user from undoing their actions from this point
- nullEffect() - does nothing - can be used to do nothing in certain cases

Fatigue counter

fatigueCount(startingTurn, delta, name) - fatigue counter


    local oneSwitch = equalSwitchEffect(
        s.GetCounter(name),
    -- default effect if counter value doesn't match 0 or 1 = 2 in power of counter - 1
    -- in case of 2 - which is first default value hit after starting turn - 2^(2-1) = 2
        getFatigueEffect(s.Power(s.Const(2), s.Minus(s.GetCounter(name), s.Const(1)))),
        e.ValueItem(0, e.NullEffect()),
        e.ValueItem(1, getFatigueEffect(s.Const(1))) 
    )


Random selection

- randomEffect({valueItem1, valueItem2, …}) - value item is an integer/simple effect pair. Integers represent weight of the given item. Say we have 5, 2, 1 items in the list. item with 5 has the most chances to be selected.
- valueItem(int, effect) - creates value item for RandomEffect, where determines probability of an effect to be randomly selected.


    return randomEffect({
        valueItem(5, effect1),
        valueItem(5, effect2),
        valueItem(5, effect3)
    })


- randomChoice(choicesArray1, choicesArray2)


    return randomChoiceEffect({
        choices = {
           {
                effect = effect,
                layout = createLayout()
           },
           {
                effect = effect,
                layout = createLayout()
           }
         },{
        choices_2 = {
           {
                effect = e.CreateFromString("fire_gem", currentHandLoc),
                layout = createLayout()
           },
           {
                effect = e.CreateFromString("fire_gem", currentHandLoc),
                layout = createLayout()
           }
        }
    })


Control flow

- equalSwitchEffect(intExpression, defaultSimpleEffect, valueItems[]) - value item is an integer/simple effect pair. Integers represent value of incoming integer to be compared to. Effect from value item with matching integer will be executed. If none of the items match, default effect is executed.

Animations / text

- animateShuffleEffect(player) - plays deck shuffle animation
- showOpponentTextEffect(text) - shows text to the opponent
- hideOpponentTextEffect(text) - hides previously shown opponent text
- showCardEffect(layout) - you may build a layout to be show to player to several seconds or until clicked. createLayout("avatars/troll", "Injured Troll I", "{3 combat}", "The troll gets angry")
- showTextEffect(text) - shows text on the screen
- waitForClickEffect(playerText, oppText)- shows text to corresponding player and waits for click
- customAnimationEffect({id, player}) - plays a custom animation with “id” for “player”
- cardAbilityAnimationEffect({ id, layout }) - plays card animation with “id” style and “layout” card face


Card Effects TODO: check if all effects are listed

Card effects require a list of cards to be supplied, normally via a selector. They end with -Target

Game state card effects


- sacrificeTarget() - sacrifices targets
- acquireForFreeTarget(loc) - acquires targets for free to location
- acquireTarget(int discount, loc) - acquires targets to location with a discount
- addSlotToTarget(slot) - adds a slot to targets
- damageTarget(intExpression) - deals damage to targets
- discardTarget() - discards targets
- expendTarget() - expends targets
- grantHealthToTarget(intExpression) - grants +X defense to target champions
- moveTarget(locExr) - moves targets to location
- moveToTopDeckTarget(isHidden) - moves targets to top of current player’s deck. Set isHidden to true if you don’t want card’s name reflected in log
- nullTarget() - does nothing
- playTarget() - plays targets
- prepareTarget() - prepares targets
- stunTarget() - stuns target
- transformTarget(cardStringId) - transforms target to a card with the given id
- modifyCardDefTarget(healthDelta, ability) - gives an existing card a modified health value and/or a new ability

Random card effects


- probabilityTarget({ chance, onSuccessTarget, onFailureTarget}) - executes onSuccess target effect with chance probability, otherwise executes onFalureTarget effect.
- randomTarget(cardEffect, intExpression) - passes X random targets to underlying card effect

Animation card effects


- showTextTarget(text) - show the provided text above the target card

Control flow card effects


- ifElseTarget(boolCardExpression, yesCardEffect, noCardEffect) - same as ifElseEffect

Card Effect can be converted into Simple Effect by applying a selector.

Examples:

Sacrifice all cards in the current player’s hand:

sacrificeTarget().apply(selectLoc(loc(currentPid, handPloc)))

We can also convert a simple effect into a card effect by ignoring the target:

ignoreTarget(simpleeffect)


Targeted Effects

Targeted effects can be pushed into the effect queue with pushTargetedEffect(). They will prompt the player to select a target, and then execute the provided card effect on the targets.

Note that pushTargetedEffect() will return a Simple Effect.

If you call pushTargetedEffect in the middle of a sequence of effects, the pushed effect will not happen until everything else in the sequence has already happened. This means if you want another effect to not happen until after the targeted effect has executed, that other effect must be included in the “targetEffect” field of the table passed to pushTargetedEffect(), e.g. targetEffect=sacrificeTarget().seq(drawCardsEffect(1)).

Also, note that you can use selectTargets() to return the targets while processing a targeted/card effect.

Example to prompt the user to sacrifice a card in hand:


    pushTargetedEffect({
      desc=“Sacrifice a card in hand”,
      min=0,
      max=1,
      validTargets=selectLoc(loc(currentPid, handPloc)),
      targetEffect=sacrificeTarget(),
      tags = { "cheapest" }
    })


Special target effects

promptSplit effect
allows to sort cards from a location.
Used for track and channel abilities.

Example:

    drawToLocationEffect(4, currentRevealLoc)
     .seq(promptSplit({
        selector = selectLoc(currentRevealLoc),
        take = const(4), -- number of cards to take for split
        sort = const(2), -- number of cards to be sorted for ef2
        ef1 =moveToTopDeckTarget(true), -- effect to be applied to cards left
        ef2 = discardTarget(), -- effect to be applied to sorted cards
        header = "Careful Track", -- prompt header
        description = "Look at the top four cards of your deck. You may put up to two of them into your discard pile, then put the rest back in any order.",
        pile1Name = "Top of Deck",
        pile2Name = "Discard Pile",
        eff1Tags = { buytopdeckTag },
        eff2Tags = { cheapestTag }
    }))
Choice Effects

The user will make a choice, then a SimpleEffect will be executed for the chosen item.


    pushChoiceEffect({
      choices={
        {
          id="choicelayoutid",
          effect=gainCombatEffect(5)
        },
        {
          effect = healPlayerEffect(currentPid, v),
          layout = createLayout({
              name = "Heal Myself",
              art = "icons/cleric_lesser_resurrect",
              xmlText = [[
              <vlayout>
                  <hlayout flexibleheight="3">
                      <tmpro text="{gold_2}" fontsize="50" flexiblewidth="1"/>
                  </hlayout>
                  <divider/>
                  <hlayout flexibleheight="2">
                      <tmpro text="{scrap}" fontsize="50" flexiblewidth="1"/>
                      <tmpro text="&lt;br&gt; Acquire a card of cost 3 or less." fontsize="20" flexiblewidth="7"/>
                  </hlayout>
              </vlayout>
              ]],
              flavor = format("Health: {0}", { getPlayerHealth(currentPid) }),
              -- condition allows to gray the choice out if there are no targets for it
              condition = e.GteCount(s.CurrentPlayer(CardLocEnum.Sacrifice).where(isCardType(abilityType)), s.Const(1))
          })
        }
      }    
    })

If you are using the field "text" in createLayout ({   }) and 
want to display the gold/combat/health icon in the description
use {X gold} ; {X combat} ; {X health} where X - count of points

Otherwise, use “xmltext” field.

Example:

![](https://paper-attachments.dropbox.com/s_31F66394ABC2465F353C26C1171909EFCCC7A751E53E3C241560ABB665EB7125_1647011256237_ima22ge.png)

    layout = createLayout({
        title = "Hunter's Cloak",
        art = "icons/ranger_hunters_cloak",
        text = ("{2 health}")
    }),


Note that choice effects can be dynamically generated using thecreateLayout() function, which returns a dynamic layout for the art. All the fields of createLayout accept StringExpression.


Target Player effects (not implemented yet)

In coop, we might need to target players.


    pushTargetPlayerEffect({
      mode = targetPlayers,
      effect = playerGainHealthEffect(targetPid, 5)
    })

targetPid will be defined within the context of a target player effect.

mode can only be targetPlayers for now.


Storytelling effects

Speech bubble effect
Shows a speech bubble for defined player, which may wait to be dismissed or not.

    showSpeechBubbleEffect({
        playerExpression=oppPid,
        text="Lys, your supper is here!",
        waitForClick=constBoolExpression(false)
    })

Story tell effect effect with portrait
Shows an avatar sayng a string.

    storyTellEffectWithPortrait("lys__the_unseen", "Delicious…")

Story lines effect
Shows strings one after another.

    storyLinesEffect({"You’ve defeated the Necros but lost many allies in the battle.",
                             "You leave the temple, but the surrounding catacombs are like a maze.",
                             "Without the captive Priest for a guide, you quickly become lost."
    })
Creating abilities

Abilities link effects with their trigger times.

createAbility({id, trigger, effect, cost, activations, check})

id: unique id of the ability (within a card)

trigger: one of


    startOfTurnTrigger
    endOfTurnTrigger
    endOfOppTurnTrigger
    oppStartOfTurnTrigger
    autoTrigger - automatic trigger, like death cultist's expend ability has auto trigger
    onExpendTrigger
    onSacrificeTrigger - triggers this trigger on sacrificed cards
    onSacrificeGlobal - triggers all cards with this trigger
    onStunTrigger - triggers this trigger on sacrificed cards
    onStunGlobal - triggers all cards with this trigger
    uiTrigger - user will need to manually trigger it
    onAcquireTrigger - triggers this trigger on sacrificed cards
    onAcquireGlobal - triggers all cards with this trigger
    onPlayTrigger - triggers every time you play any card, not just the card with the onPlay ability
    startOfGameTrigger
    endOfGameTrigger
    onZeroHealthTrigger - triggers when player's health becomes 0 or below
    deckShuffledTrigger - triggers when player deck shuffled
    onLeavePlayTrigger - triggers when champion leaves InPlay area

effect: an effect to run when triggered

cost: requirements to use the effect, set if required; to give an ability multiple costs, such as expending and also paying gold, use combineCosts(t), passing it a table that contains each of the desired costs, e.g. combineCosts({ expendCost, goldCost(2) })


- expendCost
- sacrificeSelfCost
- goldCost(value)
- sacrificeSelfCost
- costAnd({ expendCost, goldCost(value) })

activations: set if required

- singleActivation: normally used with auto abilities to indicate that the ability can only be activated once per turn. Default.
- multipleActivations: used with expend abilities to indicate that it can be activated multiple times per turn.

promptType: set if you want to show confirmation card before executing ability. 

- noPrompt - default
- showPrompt - enables prompt

priority: trigger priority - when multiple same trigger abilities fire, they are executed in priority order from highest to lowest. 0 by default.

layout: layout to be displayed when activated on prompt

check: bool expression to decide if the ability can be triggered

allyFactions: used for Ally Abilities, which can only activate if a card of the specified faction(s) is also in play; required for createUiAllyAbility() and createAutoAllyAbility()


Creating CardEffectAbilities

Standard Abilities can have the onAcquire trigger, which makes them activate whenever any card is acquired (regardless of destination), which can make it difficult to have the ability affect the acquired card, as the onAcquire ability does not have a reference to it. If you want to create an ability that will always be able to affect the specific card that was acquired, you need to give the Card Def a CardEffectAbility. The createDef() function accepts a cardEffectAbilities table in its table parameter, though the abilities table is still required, even if a card has a CardEffectAbility but no Ability:

    card = createDef({
      ...
      abilities = { },
      cardEffectAbilities = {
        createCardEffectAbility({
          trigger = playedCardTrigger,
          effect = expendTarget().apply(selectTargets().where(isCardChampion()))
        })
      },
      ...
    })

There are several possible trigger timings for a CardEffectAbility:

- acquiredCardTrigger - triggers before card is acquired
- locationChangedCardTrigger - triggers when a card is added to the market, created, or moved
- postAcquiredCardTrigger - triggers after card is acquired
- postSelfAcquiredCardTrigger - like postAcquired, but only triggers for the card itself
- playedCardTrigger - triggers after a card is played from hand. The trigger will happen after after played triggers, but before auto triggers happen. This way, if the played card trigger expends a champion, auto triggers will not fire.

CardEffectAbilities must use CardEffects, which require specific card targets. The CardEffectAbility will pass the acquired card as the target for the CardEffect assigned to it if the trigger is onAcquire or postAcquire; it will pass the card whose location changed if the trigger is onLocationChanged. You can also use selectTargets() to obtain the targets

Additionally, for a card that contains a CardEffectAbility with the onLocationChanged trigger, when that card is first created, that ability will trigger, targeting every possible card.

You can pass a Simple Effect to the CardEffectAbility, it will be auto converted to a CardEffect.


Creating Card Defs

Finally, we put the abilities into a Card Def to allow us to actually create a card.

`createDef({id, name, cardTypeLabel, playLocation, abilities, types, ….})`

id: a unique id for the card

name: Title of card

abilities: array of abilities that the card will have

cardEffectAbilities: array of card effect abilities

acquireCost: cost to acquire

types: array of strings

health: health/defense for champions

healthType: for champions, its either defenseHealthType (default) or healthHealthType

buffDetails: for global buffs, this creates the display when its clicked for details:

    createBuffDetails({
                art = "wizard_spell_components",
                name = "Soak",
                text = "+1 cost"
            }),

layout: if we want to dynamically generate the card layout, example code: 

    createLayout({
                name = "Little Fire Sacer",
                art = "icons/fighter_knock_back",
                text = "Expend: Sacrifice a card in your hand or discard pile",
                flavor = "Water cleanses all"
            })

See layout text chapter below for more formatting info.

Alternatively, we can load a card texture as layout, e.g.
`loadLayoutTexture(``"``Textures/death_touch``"``)`

cardTypeLabel: type of card, used only for display. Normally auto filled in.

playLocation: where the card is played, one of the player loc, e.g. castPloc for action cards. . Normally auto filled in.

Helper methods for creating card defs. These generally just fill in the required type, playLocation and cardTypeLabel.

createActionDef()

    function confused_apparition_carddef()
        return createActionDef({
            id="confused_apparition",
            name="Confused Apparition",
            types={noStealType},
            acquireCost=0,
            abilities = {
                createAbility({
                    id="confused_apparition_auto",
                    trigger= autoTrigger,
                    effect = ifEffect(selectLoc(currentInPlayLoc).where(isCardName("weak_skeleton")).count().lte(0), healPlayerEffect(oppPid, 1))
                })
            },
            layout = createLayout({
                name = "Confused Apparition",
                art = "art/T_Confused_Apparition",
                frame = "frames/Coop_Campaign_CardFrame",
                text = "Opponent gains 1 <sprite name=\"health\"> unless you have a Weak Skeleton in play."
            })
        })
    end

createChampionDef()

    function orc_guardian_carddef()
        return createChampionDef({
            id="orc_guardian",
            name="Orc Guardian",
            types={orcType, noStealType},
            acquireCost=0,
            health = 3,
            isGuard = true,
            abilities = {
                createAbility({
                    id="feisty_orcling_auto",
                    trigger=autoTrigger,
                    effect = e.NullEffect()
                })
            },
            layout = createLayout({
                name = "Orc Guardian",
                art = "art/T_Orc_Guardian",
                frame = "frames/Coop_Campaign_CardFrame",
                text = "<i>He's quite defensive.</i>",
                health = 3,
                isGuard = true,
                cost = 1
            })
        })
    end

createBuffDef()

createSkillDef()

    function piracy_carddef()
        return createSkillDef({
            id="piracy",
            name="Piracy",
            abilities = {
                createAbility({
                    id="piracy_auto",
                    trigger=autoTrigger,
                    effect = --showTextTarget("Piracy!").apply(selectSource())
                            showCardEffect(createLayout({
                                name = "Piracy",
                                art = "art/T_Piracy",
                                frame = "frames/Coop_Campaign_CardFrame",
                                text = "Acquire the cheapest card in the market row for free"
                            }))
                            .seq(acquireForFreeTarget().apply(selectLoc(centerRowLoc).where(isCardAcquirable()).order(getCardCost()).take(1)))
                            .seq(ifEffect(selectLoc(currentDiscardLoc).reverse().take(1).sum(getCardCost()).gte(6), showTextEffect("Mighty fine plunder, that one.")))
                })
            },
            layout = createLayout({
                name = "Piracy",
                art = "art/T_Piracy",
                frame = "frames/Coop_Campaign_CardFrame",
                text = "Acquire the cheapest card in the market row for free"
            })
        })
    end

createMagicArmorDef()

    function cleric_shining_breastplate2_carddef()
        local cardLayout = createLayout({
            name = "Shining Breastplate 2",
            art = "icons/cleric_shining_breastplate",
            frame = "frames/Cleric_CardFrame",
            text = "Champion get +1 defense till the end of turn"
        })
        
        return createMagicArmorDef({
            id = "cleric_shining_breastplate2",
            name = "Shining Breastplate 2",
            types = {clericType, magicArmorType, treasureType, chestType},
            layout = cardLayout,
            layoutPath = "icons/cleric_shining_breastplate",
            abilities = {
                createAbility( {
                    id = "cleric_shining_breastplate2",
                    trigger = uiTrigger,
                    activations = singleActivation,
                    layout = cardLayout,
                    effect = pushTargetedEffect(
                        {
                            desc = "Choose a champion to get +1 defense",
                            validTargets =  s.CurrentPlayer(CardLocEnum.InPlay),
                            min = 1,
                            max = 1,
                            targetEffect = grantHealthTarget(1, { SlotExpireEnum.LeavesPlay }, nullEffect(), "shield"),
                            tags = {toughestTag}                        
                        }
                    ),
                    cost = AbilityCosts.Expend,
                    check = minHealthCurrent(40).And(selectLoc(currentInPlayLoc).where(isCardChampion()).count().gte(1))
                })
            }        
        })
    end

createHeroAbilityDef()

Layout Text formatting

To set up layout text, use xmltext field of layout table. Double square brackets allow multiline code for easier reading.


    xmlText = [[
        <vlayout>
            <hlayout flexibleheight="1">
                <tmpro text="{scrap}" fontsize="60" flexiblewidth="1"/>
                <tmpro text="Deal 4 damage to two target champions." fontsize="28" flexiblewidth="7"/>
            </hlayout>
        </vlayout>
    ]]


![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1661177102391_spriteatlas.png)


Sprites:
{shield}
{combat} {combat_1} 1-9
{expend_1}
{expend_2}
{expend}
{gold} {gold_1} 1-9
{guard}
{guild}
{health} {health_1} 1 to 9
{imperial}
{necro}
{scrap}
{separator}
{wild}
{requiresHealth_40} 10 - 50 step 5

Examples:


    <vlayout>
        <hlayout flexibleheight="2">
                <tmpro text="Draw a card" fontsize="22" flexiblewidth="1" />
        </hlayout>
        <divider/>
        <hlayout flexibleheight="7.7">
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1.5"/>
                <vlayout flexiblewidth="8">
                                    <tmpro text="{imperial}  &lt;size=90%&gt;3 {combat}&lt;/size&gt;" fontsize="20" alignment="Left" flexibleheight="1"/>
                                    <tmpro text="{wild}  &lt;size=90%&gt;2 {gold}&lt;/size&gt;" fontsize="20" alignment="Left" flexibleheight="1"/>
                                    <tmpro text="{guild}  &lt;size=90%&gt;Draw a card.&lt;/size&gt;" fontsize="19" alignment="Left" flexibleheight="1"/>
                                    <tmpro text="{necro}  &lt;size=90%&gt;You may sacrifice a card in your hand or discard pile.&lt;/size&gt;" fontsize="19" alignment="Left" flexibleheight="2"/>
                </vlayout>
        </hlayout>
    </vlayout>


![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378004224_image.png)



    <vlayout>
        <hlayout flexibleheight="3">
                <tmpro text="{expend}" fontsize="50" flexiblewidth="2"/>
                <tmpro text="Choose a card in the market. Acquire it for 1 less or sacrifice it." fontsize="20" flexiblewidth="10" />
        </hlayout>
        <divider/>
        <hlayout flexibleheight="2">
                <tmpro text="{scrap}" fontsize="50" flexiblewidth="2" />
                <tmpro text="&lt;space=-3em/&gt;Draw a card" fontsize="20" flexiblewidth="10" />
        </hlayout> 
    </vlayout>
![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378216298_image.png)

    <vlayout>
        <hlayout flexibleheight="3">
                <tmpro text="Draw a card. If it has no cost, gain 3 {health}.&lt;br&gt;(May bring above maximum)" fontsize="20" flexiblewidth="1" />
        </hlayout>
        <divider/>
        <hlayout flexibleheight="2">
                <tmpro text="{scrap}" fontsize="50" flexiblewidth="1" />
                <tmpro text="&lt;space=-0.7em/&gt;{combat_2}" fontsize="50" flexiblewidth="8" />
        </hlayout>
    </vlayout>
![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378256392_image.png)

    <vlayout>
        <tmpro text="Draw 2" fontsize="26" flexibleheight="0.5"/>
        <divider/>
        <hlayout flexibleheight="1">
            <tmpro text="{imperial}" fontsize="40" flexiblewidth="1"/>
            <tmpro text="&lt;cspace=0.5em&gt;{health_5}&lt;/cspace&gt;" fontsize="40" flexiblewidth="7" />
        </hlayout>
        <divider/>
        <hlayout flexibleheight="1">
            <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
            <tmpro text="&lt;cspace=0.5em&gt;{combat_5}&lt;/cspace&gt;" fontsize="40" flexiblewidth="7" />
        </hlayout>
    </vlayout>
![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378305254_image.png)

    xmlText = [[
    <vlayout>
        <hlayout flexibleheight="1">
            <box flexiblewidth="1">
                <tmpro text="{expend}" fontsize="36"/>
            </box>
            <box flexiblewidth="7">
                <tmpro text="{combat_1}&lt;size=60%&gt; or &lt;/size&gt;{gold_1}&lt;size=60%&gt; or &lt;/size&gt;{health_1}" fontsize="46" />
            </box>
        </hlayout>
    </vlayout>
    ]]
![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378595654_image.png)

    xmlText = [[
    <vlayout>
        <box flexibleheight="0.5">
            <tmpro text="Draw 2" fontsize="26"/>
        </box>
        <divider/>
        <hlayout flexibleheight="1">
            <box flexiblewidth="1">
                <tmpro text="{imperial}" fontsize="40"/>
            </box>
            <box flexiblewidth="7">
                <tmpro text="&lt;cspace=0.5em&gt;{health_5}&lt;/cspace&gt;" fontsize="40" />
            </box>
        </hlayout>
        <divider/>
        <hlayout flexibleheight="1">
            <box flexiblewidth="1">
                <tmpro text="{scrap}" fontsize="40"/>
            </box>
            <box flexiblewidth="7">
                <tmpro text="&lt;cspace=0.5em&gt;{combat_5}&lt;/cspace&gt;" fontsize="40" />
            </box>
        </hlayout>
    </vlayout>
    ]]
![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378720692_image.png)

    xmlText = [[
    <vlayout>
        <box flexibleheight="1">
            <tmpro text="{gold_4}" fontsize="36"/>
        </box>
        <divider/>
        <hlayout flexibleheight="1">
            <box flexiblewidth="1">
                <tmpro text="{wild}" fontsize="36"/>
            </box>
            <box flexiblewidth="7">
                <tmpro text="Opponent discards 1." fontsize="22" />
            </box>
        </hlayout>
        <divider/>
        <hlayout flexibleheight="1">
            <box flexiblewidth="1">
                <tmpro text="{scrap}" fontsize="36"/>
            </box>
            <box flexiblewidth="7">
                <tmpro text="&lt;cspace=0.5em&gt;{combat_4}&lt;/cspace&gt;" fontsize="36" />
            </box>
        </hlayout>
    </vlayout>
    ]]
![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378741733_image.png)

    xmlText = [[
    <vlayout>
        <hlayout flexibleheight="1.8">
            <box flexiblewidth="1">
                <tmpro text="{expend}" fontsize="42"/>
            </box>
            <vlayout flexiblewidth="7">
                <box flexibleheight="1">
                    <tmpro text="{combat_6}" fontsize="36" />
                </box>
                <box flexibleheight="2">
                    <tmpro text="Draw up to one card, then discard that many." fontsize="20" />
                </box>
            </vlayout>
        </hlayout>
        <divider/>
        <hlayout flexibleheight="1">
            <box flexiblewidth="1">
                <tmpro text="{wild}" fontsize="42"/>
            </box>
            <box flexiblewidth="7">
                <tmpro text="Draw up to one card, then discard that many." fontsize="20" />
            </box>
        </hlayout>
    </vlayout>
    ]]
![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378766153_image.png)

    xmlText = [[
    <vlayout>
        <hlayout flexibleheight="1">
            <box flexiblewidth="1">
                <tmpro text="{requiresHealth_10}" fontsize="72"/>
            </box>
            <box flexiblewidth="7">
                <tmpro text="Target Champion gets +1{shield} permanently" fontsize="28" />
            </box>
        </hlayout>
    </vlayout>
    ]]
![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378822046_image.png)

    xmlText = [[
    <vlayout>
        <box flexibleheight="1">
            <tmpro text="{gold_2} or {health_5}" fontsize="42"/>
        </box>
        <box flexibleheight="1">
            <tmpro text="If you have two or more champions, gain both." fontsize="24" />
        </box>
    </vlayout>
    ]]
![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378843081_image.png)

    xmlText = [[
    <vlayout>
        <hlayout flexibleheight="1">
            <box flexiblewidth="1">
                <tmpro text="{expend_2}" fontsize="72"/>
            </box>
            <box flexiblewidth="7">
                <tmpro text="Target player gains 7{health} plus 2{health} for each of their champions, and their champions gain 1{shield} until the end of their turn." fontsize="22" />
            </box>
        </hlayout>
    </vlayout>
    ]]
![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378902674_image.png)

    xmlText = [[
    <vlayout>
        <hlayout flexibleheight="1">
            <box flexiblewidth="1">
                <tmpro text="{expend}" fontsize="42"/>
            </box>
            <vlayout flexiblewidth="7">
                <box flexibleheight="1">
                    <tmpro text="{combat_5}" fontsize="42" />
                </box>
                <box flexibleheight="1">
                    <tmpro text="Draw 1" fontsize="32" />
                </box>
            </vlayout>
        </hlayout>
        <divider/>
        <hlayout flexibleheight="1">
            <box flexiblewidth="1">
                <tmpro text="{imperial}" fontsize="42"/>
            </box>
            <box flexiblewidth="7">
                <tmpro text="{health_6}" fontsize="42" />
            </box>
        </hlayout> 
    </vlayout>
    ]],
![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378926283_image.png)

Slots TODO: add slots info

There are two types of slots in the engine:

- card slots
- player slots

Slots are customizable objects that can be attached to cards and players for various purposes.
All slots have a lifespan, determined by expiration field.

Slot Expiry

    startOfOwnerTurnExpiry
    endOfOwnerTurnExpiry
    endOfTurnExpiry
    leavesPlayExpiry
    linkedExpiry
    neverExpiry


Card slots

Card slots are used to change card properties in various ways or to set flags for further use.

Adding slot to a card

    addSlotToTarget(slot)

As a card effect, it should either be used as part of targeted effect, or followed by .apply(selector)

Checking slots
To check slots, tail selector with .where(isCardWithSlot(“stringSlotKey”))

Available slot types:

Factions Slot
When this slot is attached to a card, it’s considered to have factions specified and this effect falls of when expiration event comes.


    createFactionsSlot({ necrosFaction, guildFaction }, { leavesPlayExpiry, endOfTurnExpiry })

Ability Slot
When this slot attached to a card, it also has the ability in it.


    local ab = createAbility({
        id = "expendio",
        effect = prepareTarget().apply(selectSource()),
        cost = noCost,
        check = selectSource().where(isCardExpended()).count().eq(1),
        trigger = autoTrigger,
        activations = singleActivation,
        tags = {  }
    })
    
    createAbilitySlot(ab, { endOfTurnExpiry })

Cost change Slot
Modifies cost of a card it attached to.


    createCostChangeSlot(discount, expiresArray)

if discount is negative, card will cost more.

NoBuy Slot
When this slot is attached to a card in the market row, a card can’t be acquired even if you have enough gold.


    createNoBuySlot(expires)

Health change Slot
Modifies defense of a card it attached to.


    createCostChangeSlot(discount, expiresArray)

if discount is negative, card will cost more.

No stun slot

    createNoStunSlot(expiresArray)

card with this slot can’t be stunned

No damage slot

    createNoDamageSlot(expiresArray)

card with this slot can’t be damaged

Custom slots
Custom slots can be used to set some flag on a card

    createSlot({ id = "abilityActivated", expiry = endOfTurnExpiry })


Player slots (coming soon)

Player slots can be attached to players and then can be checked and used to make decisions.
Player slot consists of a key and optional string value.

For example, slots are used to mark a player as one who has a champion stunned this turn, so phoenix helm could activate.


Examples: TBD


AI

There are 3 types of AI available in the app:


- createEasyAi()
- createMediumAi()
- createHardAi()


Image resources

Those can be art, frames, icons and avatars.
Virtually all arts except frames are interchangeable.
You may use avatars for choices and layouts, but not vice versa.
Path should be set as a path, see exact values below.

Art

Art folder is used to generate layouts. It determines the art on the card.

Possible values:

    art/dark_sign.png 
    art/gold_female_black.png 
    art/gold_female_dark.png 
    art/gold_female_pale.png 
    art/gold_female_white.png 
    art/gold_female_white_grayscale.png 
    art/gold_male_black.png 
    art/gold_male_dark.png 
    art/gold_male_pale.png 
    art/gold_male_white.png 
    art/Gorg__Orc_Shaman.png 
    art/T_All_Heroes.png 
    art/T_Angry_Skeleton.png 
    art/T_Arkus_Imperial_Dragon.png 
    art/T_Banshee.png 
    art/T_Barreling_Fireball.png 
    art/T_Basilisk.png 
    art/T_Battle_Cry.png 
    art/T_Battle_Resurrect.png 
    art/T_Black_Arrow.png 
    art/T_Black_Knight.png 
    art/T_Blazing_Fire.png 
    art/T_Blazing_Heat.png 
    art/T_Bless.png 
    art/T_Bless_Of_Heart.png 
    art/T_Bless_Of_Iron.png 
    art/T_Bless_Of_Soul.png 
    art/T_Bless_Of_Steel.png 
    art/T_Bless_The_Flock.png 
    art/T_Blistering_Blaze.png 
    art/T_Blow_Away.png 
    art/T_Borg_Ogre_Mercenary.png 
    art/T_Bounty_Collection.png 
    art/T_Bribe.png 
    art/T_Broadsides.png 
    art/T_Broelyn_Loreweaver.png 
    art/T_Broelyn_Loreweaver_Old.png 
    art/T_Calm_Channel.png 
    art/T_Capsize.png 
    art/T_Captain_Goldtooth.png 
    art/T_Careful_Track.png 
    art/T_Cat_Familiar.png 
    art/T_Channel.png 
    art/T_Chaotic_Gust.png 
    art/T_Charing_Guardian.png 
    art/T_Cleric_Brightstar_Shield.png 
    art/T_Cleric_Divine_Resurrect.png 
    art/T_Cleric_Everburning_Candle.png 
    art/T_Cleric_Female.png 
    art/T_Cleric_Hammer_Of_Light.png 
    art/T_Cleric_Holy_Resurrect.png 
    art/T_Cleric_Lesser_Resurrect.png 
    art/T_Cleric_MaleAlternate.png 
    art/T_Cleric_Mass_Resurrect.png 
    art/T_Cleric_Minor_Resurrect.png 
    art/T_Cleric_Phoenix_Helm.png 
    art/T_Cleric_Redeemed_Ruinos.png 
    art/T_Cleric_Rightous_Resurrect.png 
    art/T_Cleric_Shining_Breastplate.png 
    art/T_Cleric_Talisman_Of_Renewal.png 
    art/T_Cleric_Veteran_Follower.png 
    art/T_Close_Ranks.png 
    art/T_Command.png 
    art/T_Confused_Apparition.png 
    art/T_Crashing_Torrent.png 
    art/T_Crashing_Wave.png 
    art/T_Cristov_The_Just.png 
    art/T_Cron_The_Berserker.png 
    art/T_Crushing_Strength.png 
    art/T_Cult_Priest.png 
    art/T_Cunning_Of_The_Wolf.png 
    art/T_Dagger.png 
    art/T_Darian_War_Mage.png 
    art/T_Dark_Energy.png 
    art/T_Dark_Reward.png 
    art/T_Death_Cultist.png 
    art/T_Death_Threat.png 
    art/T_Death_Touch.png 
    art/T_Deception.png 
    art/T_Deep_Channel.png 
    art/T_Demon.png 
    art/T_Devastating_Blow.png 
    art/T_Devil.png 
    art/T_Devotion.png 
    art/T_Dire_Wolf.png 
    art/T_Distracted_Exchange.png 
    art/T_Divine_Resurrect.png 
    art/T_Domination.png 
    art/T_Dragon_Fire.png 
    art/T_Drench.png 
    art/T_Edge_Of_The_Moat.png 
    art/T_Elf.png 
    art/T_Elixir_Of_Concentration.png 
    art/T_Elixir_Of_Endurance.png 
    art/T_Elixir_Of_Fortune.png 
    art/T_Elixir_Of_Strength.png 
    art/T_Elixir_Of_Wisdom.png 
    art/T_Elven_Curse.png 
    art/T_Elven_Gift.png 
    art/T_Evangelize.png 
    art/T_Expansion.png 
    art/T_Explosive_Fireball.png 
    art/T_Fairy.png 
    art/T_Feisty_Orcling.png 
    art/T_Fierce_Gale.png 
    art/T_Fighter_Crushing_Blow.png 
    art/T_Fighter_Double_Bladed_Axe.png 
    art/T_Fighter_FemaleAlternate.png 
    art/T_Fighter_Hand_Scythe.png 
    art/T_Fighter_Helm_Of_Fury.png 
    art/T_Fighter_Helm_Of_Fury_2.png 
    art/T_Fighter_Jagged_Spear.png 
    art/T_Fighter_Male.png 
    art/T_Fighter_Rallying_Flag.png 
    art/T_Fighter_Seasoned_Shield_Bearer.png 
    art/T_Fighter_Sharpening_Stone.png 
    art/T_Fighter_Spiked_Pauldrons.png 
    art/T_Fighter_Sweeping_Blow.png 
    art/T_Fighter_Whirling_Blow.png 
    art/T_Fireball.png 
    art/T_Fire_Blast.png 
    art/T_Fire_Bomb.png 
    art/T_Fire_Gem.png 
    art/T_Fire_Staff.png 
    art/T_Fissure.png 
    art/T_Flame_Burst.png 
    art/T_Flawless_Track.png 
    art/T_Flesh_Ripper.png 
    art/T_Flood.png 
    art/T_Follower_A.png 
    art/T_Follower_B.png 
    art/T_Giant_Knight.png 
    art/T_Glittering_Spray.png 
    art/T_Glittering_Torrent.png 
    art/T_Glittering_Wave.png 
    art/T_Goblin.png 
    art/T_Gold.png 
    art/T_GrakStormGiant.png 
    art/T_Granite_Smasher.png 
    art/T_GroupTackle.png 
    art/T_Growing_Flame.png 
    art/T_HalfDemon_AntonisPapantoniou.png 
    art/T_HalfDemon_HellFire_ShenFei.png 
    art/T_Headshot.png 
    art/T_Headshot_1.png 
    art/T_Heavy_Gust.png 
    art/T_Heist.png 
    art/T_HitJob.png 
    art/T_Holy_Resurrect.png 
    art/T_Horn_Of_Calling.png 
    art/T_Hunting_Bow.png 
    art/T_Ignite.png 
    art/T_Influence.png 
    art/T_Intimidation.png 
    art/T_Knock_Back.png 
    art/T_Knock_Down.png 
    art/T_Kraka_High_Priest.png 
    art/T_Krythos_Master_Vampire.png 
    art/T_Large_Twister.png 
    art/T_Lesser_Resurrect.png 
    art/T_Lesser_Vampire.png 
    art/T_Life_Drain.png 
    art/T_Life_Force.png 
    art/T_Lift.png 
    art/T_Light_Crossbow.png 
    art/T_Longshot.png 
    art/T_Longsword.png 
    art/T_Lys_The_Unseen.png 
    art/T_Man_At_Arms.png 
    art/T_Man_At_Arms_Old.png 
    art/T_Maroon.png 
    art/T_Mass_Resurrect.png 
    art/T_Masterful_Heist.png 
    art/T_Master_Weyan.png 
    art/T_Maurader.png 
    art/T_Midnight_Knight.png 
    art/T_Mighty_Blow.png 
    art/T_Minor_Resurrect.png 
    art/T_Misdirection.png 
    art/T_Myros_Guild_Mage.png 
    art/T_Nature_S_Bounty.png 
    art/T_Orc.png 
    art/T_Orc_Grunt.png 
    art/T_Orc_Guardian.png 
    art/T_Orc_Riot.png 
    art/T_Paladin_Sword.png 
    art/T_Parov_The_Enforcer.png 
    art/T_Pick_Pocket.png 
    art/T_Pilfer.png 
    art/T_Pillar_Of_Fire.png 
    art/T_Piracy.png 
    art/T_Powerful_Blow.png 
    art/T_Practiced_Heist.png 
    art/T_Prayer_Beads.png 
    art/T_Precision_Blow.png 
    art/T_Prism_RainerPetter.png 
    art/T_Profit.png 
    art/T_Pure_Channel.png 
    art/T_Quickshot.png 
    art/T_Raiding_Party.png 
    art/T_Rake_Master_Assassin.png 
    art/T_Rally_The_Troops.png 
    art/T_Rampage.png 
    art/T_Ranger_Fast_Track.png 
    art/T_Ranger_Female_Alternate.png 
    art/T_Ranger_Flashfire_Arrow.png 
    art/T_Ranger_Honed_Black_Arrow.png 
    art/T_Ranger_Hunters_Cloak.png 
    art/T_Ranger_Instinctive_Track.png 
    art/T_Ranger_Male.png 
    art/T_Ranger_Pathfinder_Compass.png 
    art/T_Ranger_Snake_Pet.png 
    art/T_Ranger_Sureshot_Bracer.png 
    art/T_Ranger_Twin_Shot.png 
    art/T_Ranger_Unending_Quiver.png 
    art/T_Rasmus_The_Smuggler.png 
    art/T_Rayla_Endweaver.png 
    art/T_Recruit.png 
    art/T_Relentless_Track.png 
    art/T_Resurrect.png 
    art/T_Righteous_Resurrect.png 
    art/T_Rolling_Fireball.png 
    art/T_Ruby.png 
    art/T_Scorching_Fireball.png 
    art/T_Searing_Fireball.png 
    art/T_Searing_Guardian.png 
    art/T_Seek_Revenge.png 
    art/T_Serene_Channel.png 
    art/T_Set_Sail.png 
    art/T_Shadow_Spell_09.png 
    art/T_Shadow_Spell_09_Blue.png 
    art/T_Shadow_Spell_09_Green.png 
    art/T_Shambling_Dirt.png 
    art/T_Shield_Bearer.png 
    art/T_Shining_Spray.png 
    art/T_Shortsword.png 
    art/T_Shoulder_Bash.png 
    art/T_Shoulder_Crush.png 
    art/T_Shoulder_Smash.png 
    art/T_Skeleton.png 
    art/T_Skeleton_Blue.png 
    art/T_Skeleton_Green.png 
    art/T_Skillful_Heist.png 
    art/T_Sleight_Of_Hand.png 
    art/T_Small_Twister.png 
    art/T_Smashing_Blow.png 
    art/T_Smash_And_Grab.png 
    art/T_Smooth_Heist.png 
    art/T_Snapshot.png 
    art/T_Soothing_Torrent.png 
    art/T_Soothing_Wave.png 
    art/T_Soul_Channel.png 
    art/T_Spark.png 
    art/T_Spell_Components.png 
    art/T_Spider.png 
    art/T_Spiked_Mace.png 
    art/T_Splashing_Wave.png 
    art/T_Spreading_Blaze.png 
    art/T_Spreading_Flames.png 
    art/T_Spreading_Sparks.png 
    art/T_Steady_Shot.png 
    art/T_Stone_Golem.png 
    art/T_Stone_Guardian.png 
    art/T_Storm_Siregar.png 
    art/T_Street_Thug.png 
    art/T_Strength_In_Numbers.png 
    art/T_Strength_Of_The_Wolf.png 
    art/T_Sweltering_Heat.png 
    art/T_Swipe.png 
    art/T_Taxation.png 
    art/T_Theft.png 
    art/T_TheRot.png 
    art/T_The_Rot.png 
    art/T_Thief_Blackjack.png 
    art/T_Thief_Enchanted_Garrote.png 
    art/T_Thief_Female.png 
    art/T_Thief_Jewelers_Loupe.png 
    art/T_Thief_Keen_Throwing_Knife.png 
    art/T_Thief_Knife_Belt.png 
    art/T_Thief_Male_Alternate.png 
    art/T_Thief_Masterful_Heist.png 
    art/T_Thief_Sacrificial_Dagger.png 
    art/T_Thief_Shadow_Mask.png 
    art/T_Thief_Shadow_Mask_2.png 
    art/T_Thief_Silent_Boots.png 
    art/T_Throwing_Axe.png 
    art/T_Throwing_Knife.png 
    art/T_TimelyHeist.png 
    art/T_Tithe_Priest.png 
    art/T_Torgen_Rocksplitter.png 
    art/T_Track.png 
    art/T_Triple_Shot.png 
    art/T_Turn_To_Ash.png 
    art/T_TwinShot.png 
    art/T_Tyrannor_The_Devourer.png 
    art/T_Unify_Apsara.png 
    art/T_Varrick_The_Necromancer.png 
    art/T_Venom.png 
    art/T_Violent_Gale.png 
    art/T_Walking_Dirt.png 
    art/T_Weak_Skeleton.png 
    art/T_Well_Placed_Shot.png 
    art/T_Whirling_Blow.png 
    art/T_Wind_Storm.png 
    art/T_Wind_Tunnel.png 
    art/T_Wizard_Alchemist_S_Stone.png 
    art/T_Wizard_Arcane_Wand.png 
    art/T_Wizard_Blazing_Staff.png 
    art/T_Wizard_Female_Alternate.png 
    art/T_Wizard_Magic_Mirror.png 
    art/T_Wizard_Magic_Mirror_2.png 
    art/T_Wizard_Male.png 
    art/T_Wizard_Runic_Robes.png 
    art/T_Wizard_Runic_Robes_2.png 
    art/T_Wizard_Serpentine_Staff.png 
    art/T_Wizard_Silverskull_Amulet.png 
    art/T_Wizard_Spellcaster_Gloves.png 
    art/T_Wolf_Form.png 
    art/T_Wolf_Shaman.png 
    art/T_Word_Of_Power.png 
    art/T_Wurm.png 
    art/T_Wyvern.png 
    art/Promos1Art/Afterlife.png 
    art/Promos1Art/Bjorn_the_Centurion.png 
    art/Promos1Art/Bloodfang.png 
    art/Promos1Art/Crime_Spree.png 
    art/Promos1Art/Devotion.png 
    art/Promos1Art/Dragon_Fire.png 
    art/Promos1Art/Droga__Guild_Enforcer.png 
    art/Promos1Art/Galok__the_Vile.png 
    art/Promos1Art/Gorg__Orc_Shaman.png 
    art/Promos1Art/Kasha__the_Awakener.png 
    art/Promos1Art/Legionnaire.png 
    art/Promos1Art/Mobia__Elf_Lord.png 
    art/Promos1Art/Raiding_Party.png 
    art/Promos1Art/Ren__Bounty_Hunter.png 
    art/Promos1Art/Robbery.png 
    art/Promos1Art/The_Summoning.png 
    art/Promos1Art/Valius__Fire_Dragon.png 
    art/Promos1Art/Zombie.png 
    art/treasures/T_Bottle_Of_Rum.png 
    art/treasures/T_Bracers_Of_Brawn.png 
    art/treasures/T_Brillant_Ruby.png 
    art/treasures/T_Cleric_Elixir_Blue_Purple.png 
    art/treasures/T_Cleric_Elixir_Golden.png 
    art/treasures/T_Cleric_Elixir_Green.png 
    art/treasures/T_Fat_Cat_Familiar.png 
    art/treasures/T_Fighter_Elixir_Blue.png 
    art/treasures/T_Fighter_Elixir_Green.png 
    art/treasures/T_Fighter_Elixir_Red.png 
    art/treasures/T_Flaming_Longsword.PNG 
    art/treasures/T_Green_Potions_Large.png 
    art/treasures/T_Green_Potions_Medium.png 
    art/treasures/T_Hook_Weapon.png 
    art/treasures/T_Horn_Of_Command.png 
    art/treasures/T_Horn_Of_Need.png 
    art/treasures/T_Imperial_Sailor.png 
    art/treasures/T_Lightning_Longsword.png 
    art/treasures/T_Magic_Scroll_Souveraine.png 
    art/treasures/T_Parrot.png 
    art/treasures/T_Pirate_Cutlass.png 
    art/treasures/T_Ranger_Elixir_Orange.png 
    art/treasures/T_Ranger_Elixir_Red_Brownish.png 
    art/treasures/T_Ranger_Elixir_Yellow.png 
    art/treasures/T_Sharpened_Ruby.png 
    art/treasures/T_Ship_Bell.png 
    art/treasures/T_Ship_In_A_Bottle.png 
    art/treasures/T_Spiked_Mace_Of_Healing.png 
    art/treasures/T_Spiked_Mace_Of_Inspiration.png 
    art/treasures/T_Spyglass.png 
    art/treasures/T_Thief_Elixir_Black.png 
    art/treasures/T_Thief_Elixir_Red.png 
    art/treasures/T_Thief_Elixir_White.png 
    art/treasures/T_Treasure_Map.png 
    art/treasures/T_Trick_Dice.png 
    art/treasures/T_Wise_Cat_Familiar.png 
    art/treasures/T_Wizard_Elixir_Blue.png 
    art/treasures/T_Wizard_Elixir_Orange.png 
    art/treasures/T_Wizard_Elixir_Silver.png 


Frames

Frames are used to set a frame for a card layout

Possible values:

    frames/Cleric_armor_frame.png 
    frames/Cleric_CardFrame.png 
    frames/Fighter_armor_frame.png 
    frames/Generic_CardFrame.png 
    frames/Generic_Top_CardFrame.png 
    frames/Guild_Action_CardFrame.png 
    frames/Guild_Champion_CardFrame.png 
    frames/HR_CardFrame_Action_Guild.png 
    frames/HR_CardFrame_Action_Imperial.png 
    frames/HR_CardFrame_Action_Necros.png 
    frames/HR_CardFrame_Action_Wild.png 
    frames/HR_CardFrame_Champion_Guild.png 
    frames/HR_CardFrame_Champion_Imperial.png 
    frames/HR_CardFrame_Champion_Necros.png 
    frames/HR_CardFrame_Champion_Wild.png 
    frames/HR_CardFrame_Item_Generic.png 
    frames/Imperial_Action_CardFrame.png 
    frames/Imperial_Champion_CardFrame.png 
    frames/Necros_Action_CardFrame.png 
    frames/Necros_Champion_CardFrame.png 
    frames/Ranger_armor_frame.png 
    frames/Ranger_CardFrame.png 
    frames/Thief_armor_frame.png 
    frames/Thief_CardFrame.png 
    frames/Treasure_CardFrame.png 
    frames/Warrior_CardFrame.png 
    frames/warrior_top.png 
    frames/Wild_Action_CardFrame.png 
    frames/Wild_Champion_CardFrame.png 
    frames/Wizard_armor_frame.png 
    frames/Wizard_CardFrame.png 
    frames/Cleric_Frames/Cleric_Treasure_CardFrame.png 
    frames/FactionFrames_IconOnTheLeft/Guild_Action_CardFrame.png 
    frames/FactionFrames_IconOnTheLeft/Guild_Champion_CardFrame.png 
    frames/FactionFrames_IconOnTheLeft/Imperial_Action_CardFrame.png 
    frames/FactionFrames_IconOnTheLeft/Imperial_Champion_CardFrame.png 
    frames/FactionFrames_IconOnTheLeft/Necros_Action_CardFrame.png 
    frames/FactionFrames_IconOnTheLeft/Necros_Champion_CardFrame.png 
    frames/FactionFrames_IconOnTheLeft/Wild_Action_CardFrame.png 
    frames/FactionFrames_IconOnTheLeft/Wild_Champion_CardFrame.png 

Icons
Icons may be used for choice layout generation or to set icons for buffs, skills and abilities

Possible values:

    icons/battle_cry
    icons/cleric_battle_resurrect
    icons/cleric_bless
    icons/cleric_bless_of_heart
    icons/cleric_bless_of_iron
    icons/cleric_bless_of_soul
    icons/cleric_bless_of_steel
    icons/cleric_bless_the_flock
    icons/cleric_brightstar_shield
    icons/cleric_divine_resurrect
    icons/cleric_holy_resurrect
    icons/cleric_lesser_resurrect
    icons/cleric_mass_resurrect
    icons/cleric_minor_resurrect
    icons/cleric_phoenix_helm
    icons/cleric_resurrect
    icons/cleric_righteous_resurrect
    icons/cleric_shining_breastplate
    icons/cunning_of_the_wolf
    icons/dark_sign
    icons/evangelize
    icons/fighter_crushing_blow
    icons/fighter_crushing_blow_OLD
    icons/fighter_devastating_blow
    icons/fighter_devastating_blow_OLD
    icons/fighter_group_tackle
    icons/fighter_group_tackle_OLD
    icons/fighter_helm_of_fury
    icons/fighter_knock_back
    icons/fighter_knock_back_OLD
    icons/fighter_knock_down
    icons/fighter_knock_down_OLD
    icons/fighter_mighty_blow
    icons/fighter_mighty_blow_OLD
    icons/fighter_powerful_blow
    icons/fighter_powerful_blow_OLD
    icons/fighter_precision_blow
    icons/fighter_precision_blow_OLD
    icons/fighter_shoulder_bash
    icons/fighter_shoulder_bash_OLD
    icons/fighter_shoulder_crush
    icons/fighter_shoulder_crush_OLD
    icons/fighter_shoulder_smash
    icons/fighter_shoulder_smash_OLD
    icons/fighter_smashing_blow
    icons/fighter_smashing_blow_OLD
    icons/fighter_spiked_pauldrons
    icons/fighter_sweeping_blow
    icons/fighter_sweeping_blow_OLD
    icons/fighter_whirling_blow
    icons/fighter_whirling_blow_OLD
    icons/fire_bomb
    icons/fire_gem
    icons/full_armor
    icons/full_armor_2
    icons/growing_flame
    icons/life_siphon
    icons/orc_raiders
    icons/piracy
    icons/ranger_careful_track
    icons/ranger_careful_track_OLD
    icons/ranger_fast_track
    icons/ranger_fast_track_OLD
    icons/ranger_flawless_track
    icons/ranger_headshot
    icons/ranger_headshot_OLD
    icons/ranger_hunters_cloak
    icons/ranger_instinctive_track
    icons/ranger_instinctive_track_OLD
    icons/ranger_longshot
    icons/ranger_longshot_OLD
    icons/ranger_quickshot
    icons/ranger_quickshot_OLD
    icons/ranger_relentless_track
    icons/ranger_relentless_track_OLD
    icons/ranger_snapshot
    icons/ranger_snapshot_OLD
    icons/ranger_steady_shot
    icons/ranger_steady_shot_OLD
    icons/ranger_sureshot_bracer
    icons/ranger_track
    icons/ranger_track_OLD
    icons/ranger_triple_shot
    icons/ranger_triple_shot_OLD
    icons/ranger_twin_shot
    icons/ranger_twin_shot_OLD
    icons/ranger_well_placed_shot
    icons/ranger_well_placed_shot_OLD
    icons/smugglers
    icons/strength_of_the_wolf
    icons/thief_distracted_exchange
    icons/thief_heist
    icons/thief_heist_OLD
    icons/thief_lift
    icons/thief_lift_OLD
    icons/thief_masterful_heist
    icons/thief_masterful_heist_OLD
    icons/thief_misdirection
    icons/thief_pickpocket
    icons/thief_pickpocket_OLD
    icons/thief_pilfer
    icons/thief_pilfer_OLD
    icons/thief_practiced_heist
    icons/thief_practiced_heist_OLD
    icons/thief_shadow_mask
    icons/thief_silent_boots
    icons/thief_skillful_heist
    icons/thief_skillful_heist_OLD
    icons/thief_sleight_of_hand
    icons/thief_smooth_heist
    icons/thief_smooth_heist_OLD
    icons/thief_swipe
    icons/thief_swipe_OLD
    icons/thief_theft
    icons/thief_theft_OLD
    icons/thief_timely_heist
    icons/thief_timely_heist_OLD
    icons/turn_to_ash
    icons/T_Bounty_Collection
    icons/wind_storm
    icons/wizard_barreling_fireball
    icons/wizard_calm_channel
    icons/wizard_calm_channel_OLD
    icons/wizard_channel
    icons/wizard_deep_channel
    icons/wizard_deep_channel_OLD
    icons/wizard_explosive_fireball
    icons/wizard_fireball
    icons/wizard_fire_blast
    icons/wizard_fire_blast_OLD
    icons/wizard_flame_burst
    icons/wizard_flame_burst_OLD
    icons/wizard_pure_channel
    icons/wizard_pure_channel_OLD
    icons/wizard_rolling_fireball
    icons/wizard_runic_robes
    icons/wizard_scorching_fireball
    icons/wizard_searing_fireball
    icons/wizard_serene_channel
    icons/wizard_serene_channel_OLD
    icons/wizard_soul_channel
    icons/wizard_soul_channel_OLD
    icons/wizard_spellcaster_gloves


Avatars

You need to specify full path when using for layout.
But only avatar name “assassin”, when used as actual avatar.

Possible values:

    avatars/ambushers
    avatars/assassin
    avatars/assassin_flipped
    avatars/broelyn
    avatars/broelyn__loreweaver
    avatars/chanting_cultist
    avatars/chest
    avatars/cleric_01
    avatars/cleric_02
    avatars/cristov_s_recruits
    avatars/cristov__the_just
    avatars/fighter_01
    avatars/fighter_02
    avatars/inquisition
    avatars/krythos
    avatars/lord_callum
    avatars/lys__the_unseen
    avatars/man_at_arms
    avatars/monsters_in_the_dark
    avatars/necromancers
    avatars/ogre
    avatars/orcs
    avatars/orc_raiders
    avatars/origins_flawless_track
    avatars/origins_shoulder_bash
    avatars/pirate
    avatars/profit
    avatars/ranger_01
    avatars/ranger_02
    avatars/rayla__endweaver
    avatars/rayla__endweaver_flipped
    avatars/robbery
    avatars/ruinos_zealot
    avatars/skeleton
    avatars/smugglers
    avatars/spider
    avatars/summoner
    avatars/tentacles
    avatars/the_wolf_tribe
    avatars/thief_01
    avatars/thief_02
    avatars/troll
    avatars/vampire_lord
    avatars/wizard_01
    avatars/wizard_02
    avatars/wolf_shaman


Zoomed buffs

These are larger variants of some icons


    zoomedbuffs/cleric_battle_resurrect
    zoomedbuffs/cleric_bless
    zoomedbuffs/cleric_bless_of_heart
    zoomedbuffs/cleric_bless_of_iron
    zoomedbuffs/cleric_bless_of_soul
    zoomedbuffs/cleric_bless_of_steel
    zoomedbuffs/cleric_bless_the_flock
    zoomedbuffs/cleric_brightstar_shield
    zoomedbuffs/cleric_divine_resurrect
    zoomedbuffs/cleric_holy_resurrect
    zoomedbuffs/cleric_lesser_resurrect
    zoomedbuffs/cleric_mass_resurrect
    zoomedbuffs/cleric_minor_resurrect
    zoomedbuffs/cleric_phoenix_helm
    zoomedbuffs/cleric_resurrect
    zoomedbuffs/cleric_righteous_resurrect
    zoomedbuffs/goblin_warlord
    zoomedbuffs/ranger_horn_of_calling
    zoomedbuffs/thief_distracted_exchange
    zoomedbuffs/thief_misdirection
    zoomedbuffs/thief_sleight_of_hand
    zoomedbuffs/wizard_barreling_fireball
    zoomedbuffs/wizard_explosive_fireball
    zoomedbuffs/wizard_fireball
    zoomedbuffs/wizard_rolling_fireball
    zoomedbuffs/wizard_runic_robes
    zoomedbuffs/wizard_scorching_fireball
    zoomedbuffs/wizard_searing_fireball
    zoomedbuffs/wizard_serpentine_staff
    zoomedbuffs/wizard_spell_components


Card list

Card available:

    arkus__imperial_dragon_carddef()
    borg__ogre_mercenary_carddef()
    bribe_carddef()
    broelyn__loreweaver_carddef()
    cleric_battle_resurrect_carddef()
    cleric_bless_carddef()
    cleric_bless_of_heart_carddef()
    cleric_bless_of_iron_carddef()
    cleric_bless_of_soul_carddef()
    cleric_bless_of_steel_carddef()
    cleric_bless_the_flock_carddef()
    cleric_brightstar_shield_carddef()
    cleric_divine_resurrect_carddef()
    cleric_everburning_candle_carddef()
    cleric_follower_a_carddef()
    cleric_follower_b_carddef()
    cleric_hammer_of_light_carddef()
    cleric_holy_resurrect_carddef()
    cleric_lesser_resurrect_carddef()
    cleric_mass_resurrect_carddef()
    cleric_minor_resurrect_carddef()
    cleric_phoenix_helm_carddef()
    cleric_prayer_beads_carddef()
    cleric_redeemed_ruinos_carddef()
    cleric_resurrect_carddef()
    cleric_righteous_resurrect_carddef()
    cleric_shining_breastplate_carddef()
    cleric_spiked_mace_carddef()
    cleric_talisman_of_renewal_carddef()
    cleric_veteran_follower_carddef()
    close_ranks_carddef()
    command_carddef()
    cristov__the_just_carddef()
    cron__the_berserker_carddef()
    cult_priest_carddef()
    dagger_carddef()
    darian__war_mage_carddef()
    dark_energy_carddef()
    dark_reward_carddef()
    death_cultist_carddef()
    death_threat_carddef()
    death_touch_carddef()
    deception_carddef()
    dire_wolf_carddef()
    domination_carddef()
    elixir_of_concentration_carddef()
    elixir_of_endurance_carddef()
    elixir_of_fortune_carddef()
    elixir_of_strength_carddef()
    elixir_of_wisdom_carddef()
    elven_curse_carddef()
    elven_gift_carddef()
    fighter_crushing_blow_carddef()
    fighter_devastating_blow_carddef()
    fighter_double_bladed_axe_carddef()
    fighter_group_tackle_carddef()
    fighter_hand_scythe_carddef()
    fighter_helm_of_fury_carddef()
    fighter_jagged_spear_carddef()
    fighter_knock_back_carddef()
    fighter_knock_down_carddef()
    fighter_longsword_carddef()
    fighter_mighty_blow_carddef()
    fighter_powerful_blow_carddef()
    fighter_precision_blow_carddef()
    fighter_rallying_flag_carddef()
    fighter_seasoned_shield_bearer_carddef()
    fighter_sharpening_stone_carddef()
    fighter_shield_bearer_carddef()
    fighter_shoulder_bash_carddef()
    fighter_shoulder_crush_carddef()
    fighter_shoulder_smash_carddef()
    fighter_smashing_blow_carddef()
    fighter_spiked_pauldrons_carddef()
    fighter_sweeping_blow_carddef()
    fighter_throwing_axe_carddef()
    fighter_whirling_blow_carddef()
    fire_bomb_carddef()
    fire_gem_carddef()
    goblin_carddef()
    goblin_warlord_carddef()
    gold_carddef()
    gold_male_black_carddef()
    gold_male_dark_carddef()
    gold_male_pale_carddef()
    gold_male_white_carddef()
    gold_female_black_carddef()
    gold_female_dark_carddef()
    gold_female_pale_carddef()
    gold_female_white_carddef()
    grak__storm_giant_carddef()
    hit_job_carddef()
    influence_carddef()
    intimidation_carddef()
    kraka__high_priest_carddef()
    krythos__master_vampire_carddef()
    life_drain_carddef()
    lightning_gem_carddef()
    lys__the_unseen_carddef()
    man_at_arms_carddef()
    master_weyan_carddef()
    myros__guild_mage_carddef()
    nature_s_bounty_carddef()
    orc_grunt_carddef()
    parov__the_enforcer_carddef()
    potion_carddef()
    potion_of_power_carddef()
    profit_carddef()
    rake__master_assassin_carddef()
    rally_the_troops_carddef()
    rampage_carddef()
    ranger_black_arrow_carddef()
    ranger_careful_track_carddef()
    ranger_fast_track_carddef()
    ranger_flashfire_arrow_carddef()
    ranger_flawless_track_carddef()
    ranger_headshot_carddef()
    ranger_honed_black_arrow_carddef()
    ranger_horn_of_calling_carddef()
    ranger_hunters_cloak_carddef()
    ranger_hunting_bow_carddef()
    ranger_instinctive_track_carddef()
    ranger_light_crossbow_carddef()
    ranger_longshot_carddef()
    ranger_pathfinder_compass_carddef()
    ranger_quickshot_carddef()
    ranger_relentless_track_carddef()
    ranger_snake_pet_carddef()
    ranger_snapshot_carddef()
    ranger_steady_shot_carddef()
    ranger_sureshot_bracer_carddef()
    ranger_track_carddef()
    ranger_triple_shot_carddef()
    ranger_twin_shot_carddef()
    ranger_unending_quiver_carddef()
    ranger_well_placed_shot_carddef()
    rasmus__the_smuggler_carddef()
    rayla__endweaver_carddef()
    reality_prism_carddef()
    recruit_carddef()
    ruby_carddef()
    shortsword_carddef()
    smash_and_grab_carddef()
    spark_carddef()
    spiked_mace_carddef()
    street_thug_carddef()
    taxation_carddef()
    tentacle_carddef()
    tentacle_whip_carddef()
    the_rot_carddef()
    thief_blackjack_carddef()
    thief_distracted_exchange_carddef()
    thief_enchanted_garrote_carddef()
    thief_heist_carddef()
    thief_jewelers_loupe_carddef()
    thief_keen_throwing_knife_carddef()
    thief_knife_belt_carddef()
    thief_lift_carddef()
    thief_masterful_heist_carddef()
    thief_misdirection_carddef()
    thief_pickpocket_carddef()
    thief_pilfer_carddef()
    thief_practiced_heist_carddef()
    thief_sacrificial_dagger_carddef()
    thief_shadow_mask_carddef()
    thief_silent_boots_carddef()
    thief_skillful_heist_carddef()
    thief_sleight_of_hand_carddef()
    thief_smooth_heist_carddef()
    thief_swipe_carddef()
    thief_theft_carddef()
    thief_throwing_knife_carddef()
    thief_timely_heist_carddef()
    tithe_priest_carddef()
    torgen_rocksplitter_carddef()
    tyrannor__the_devourer_carddef()
    varrick__the_necromancer_carddef()
    web_jar_carddef()
    wizard_alchemist_s_stone_carddef()
    wizard_arcane_wand_carddef()
    wizard_barreling_fireball_carddef()
    wizard_blazing_staff_carddef()
    wizard_calm_channel_carddef()
    wizard_cat_familiar_carddef()
    wizard_channel_carddef()
    wizard_deep_channel_carddef()
    wizard_explosive_fireball_carddef()
    wizard_fire_blast_carddef()
    wizard_fire_staff_carddef()
    wizard_fireball_carddef()
    wizard_flame_burst_carddef()
    wizard_ignite_carddef()
    wizard_magic_mirror_carddef()
    wizard_pure_channel_carddef()
    wizard_rolling_fireball_carddef()
    wizard_runic_robes_carddef()
    wizard_scorching_fireball_carddef()
    wizard_searing_fireball_carddef()
    wizard_serene_channel_carddef()
    wizard_serpentine_staff_carddef()
    wizard_silverskull_amulet_carddef()
    wizard_soul_channel_carddef()
    wizard_spell_components_carddef()
    wizard_spellcaster_gloves_carddef()
    wolf_form_carddef()
    wolf_shaman_carddef()
    wondrous_wand_carddef()
    word_of_power_carddef()


Card Subtypes

Card subtypes are set to allow special processing, like knives or arrows.
You may check for it using isCardType(subType)


    noStealType -- cannot be stolen by cards such as thief_heist
    knifeType
    bowType
    arrowType
    actionType
    itemType
    spellType
    chestType
    headType
    championType
    daggerType
    abilityType
    masterType
    magicArmorType
    minionType
    dragonType
    orcType
    eliteMinionType
    elfType
    coinType
    wolfType
    gemType
    monkType
    rogueType
    assassinType
    goblinType
    spearType
    shoulderType
    currencyType
    axeType
    bannerType
    toolType
    rangedWeaponType
    meleeWeaponType
    magicWeaponType
    magicAmuletType
    magicSuppliesType
    swordType
    handType
    paladinType
    scytheType
    
    wizardType
    fighterType
    clericType
    rangerType
    thiefType
    
    weaponType
    inventoryType
    instrumentType
    candleType
    elixirType
    giantType
    maceType
    mageType
    jewelryType
    vampireType
    holyRelicType
    priestType
    treasureType
    warriorType
    ogreType
    humanType
    hammerType
    curseType
    backType
    snakeType
    armType
    felineType
    staffType
    wandType
    trollType
    necromancerType
    tentacleType
    clubType
    footType
    beltType
    demonType
    garroteType
    attachmentType
    noKillType -- mark champions with this sybtype to avoid AI killing it (Redeemed Ruinos)

© 2022 Wise Wizard Games, LLC.
 
