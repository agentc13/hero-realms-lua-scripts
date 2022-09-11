### BoolCardExpressions

They all start with 'isCard':

```lua
isCardExpended()
isCardStunned()
isCardStunnable()
isCardChampion()
isCardAction()
isCardFaction(Faction.Wild)
isCardType(“Knife”) -- checks type and subtype
isCardName(“thief_throwing_knife”) -- checks card id
isCardAtLoc(ploc) -- true if target is in the passed CardLocEnum
```

#### Operators

```lua
.And(isCardXX())
.Or(isCardXX())
.invert()
```

Note that these are uppercase, as and/or are keywords in lua

```lua
constBoolExpression(value)
--returns a BoolExpression that always returns the value it was initially passed.
```

#### Usage

**Examples:**

```lua
-- selects cards from opponent's in play, which are not expended and can be stunned
selectLoc(loc(oppPid, inPlayPloc)).where(isCardExpended().invert().And(isCardStunnable()))
```

### Selectors

**Selectors** are used to start a chain of selecting cards. All selectors start with 'select':

```lua
selectLoc(loc) -- select cards in a location
selectSource() -- select source card
selectTargets() -- selects target from targeted effect or cardeffect ability trigger.
selectOppStunnable() -- select all opponent’s champions that can be stunned
```

#### Filtering

```lua
selector.where(BoolCardExpression) -- to filter by a property on each card
```

**Example:**

```lua
-- selects cards from opponent's in play, which are not expended and can be stunned
selectLoc(loc(oppPid, inPlayPloc)).where(isCardExpended().invert().And(isCardStunnable()))
```

#### Chaining

```lua
selector1.union(selector2) -- to return the union of both selectors.
-- returns cards from the market and fire gems
selectLoc(centerRowLoc).union(selectLoc(fireGemsLoc)).where(isCardAffordable().And(isCardAcquirable()))

selector.exclude(selectSource()) -- to exclude the source card
```

#### Ordering

```lua
selector.order(intcardexpression) --to order by the provided value

.orderDesc(intcardexpression)

.reverse() -- to reverse the order

selector.take(n) -- to take the first X cards

.take(intExpression)
```

#### Conversions

**To Int:**

```lua
.count()
or
.sum(intcardexpression) --e.g. .sum(getCardCost())
```

You can use `.take(1).sum(getCardCost()` to get the cost of a single card

#### Predefined selectors

We predefine commonly used selectors in lua:

```lua
selectCurrentChampions()
selectNextChampions()
```

**Examples:**

```lua
-- to select all stunned champions
selectCurrentChampions().where(isCardStunned())
-- to count all cards in opponent’s hand
selectLoc(loc(nextPid, handPloc)).count()
-- action cards in trade row
selectLoc(centerRowLoc).where(isCardAction())
```

### IntExpression

Most int expressions start with 'get':

```lua
-- From selector:
selector.count()


getCounter(pid, counter)
getPlayerHealth(pid)
getPlayerCombat(pid)
getPlayerGold(pid)
getPlayerDamageReceivedThisTurn(pid)
getTurnsPlayed(pid)
```

constant int:

```lua
const(int)
```

Arithmetic:

```lua
.add(intExpression)
.multiply(intExpression)
negate() -- use negate with add to subtract
```

Conversions:

```lua
.gte(intExpression or int)
.lte(intExpression or int)
.eq(intExpression or int)
```

Conditional:

```lua
ifInt(boolExpression, intExpression1, intExpression2) -- if bool true - returns expression1, otherwise expression 2

```

Operations:

```lua
minInt(intExp, intExp) -- returns min of two values
```

### StringExpression

```lua
format(“{0}”, { int, intexpressoin etc})
```

### IntCardExpression

```lua
getCardCost()
getCardHealth()
```

### BoolExpression

```lua
hasClass(playerExpression, heroClass)
hasPlayerSlot(playerExpression, slot)
constBoolExpression(value) - -constant value
```

#### Negate

```lua
.invert() --to negate, e.g. isExpended().invert() returns false if the card is expended (not is a reserved word in lua)
```

#### Combining

```lua
.And(boolExp)
.Or(boolExp)
```
