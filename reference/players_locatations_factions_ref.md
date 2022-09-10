### Players

Predefined constants to select players:

```lua
currentPid -- current player
nextPid -- next player to take a turn
oppPid -- opponent of current player
nextAllyPid -- next ally player
nextOppPid -- next opponent
```

### Locations

To specify a location:

```lua
loc(player, ploc) -- where ploc is (ends with Ploc or player loc)

inPlayPloc
discardPloc
handPloc
castPloc
deckPloc
buffsPloc
skillsPloc
revealPloc -- common reveal location for any cards that get revealed to both players
myRevealPloc -- used when you need to reveal cards only to player

-- also, predefined locs without a need to specify player (ends with -Loc)

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
```

**Examples:**

```lua
-- these two are the same
currentInPlayLoc
loc(currentPid, inPlayPloc)
```

### Factions

```lua
wildFaction
guildFaction
necrosFaction
imperialFaction
```
