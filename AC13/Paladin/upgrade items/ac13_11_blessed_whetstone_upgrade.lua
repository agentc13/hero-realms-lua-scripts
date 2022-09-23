function paladin_blessed_whetstone_carddef()
    return createActionDef(
        {
            id = "paladin_blessed_whetstone",
            name = "Blessed Whetstone",
            types = {itemType, actionType, noStealType},
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "paladin_blessed_whetstone",
                        trigger = autoTrigger,
                        effect = drawCardsEffect(1).seq(gainCombatEffect(selectLoc(currentCastLoc).where(isCardType(weaponType)).count()))
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Blessed Whetstone",
                    art = "icons/cunning_of_the_wolf",
                    frame = "frames/Cleric_CardFrame",
                    text = '<size=200%><voffset=.4em><sprite name="gold_2"></voffset></size><line-height=70%><size=75%>\n+1 <sprite name="health"> for each weapon you have in play.</size></line-height>'
                }
            )
        }
    )
end