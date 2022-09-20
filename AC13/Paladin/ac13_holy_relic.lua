function paladin_holy_relic_carddef()
    return createActionDef(
        {
            id = "paladin_holy_relic",
            name = "Holy Relic",
            types = {itemType, actionType, noStealType},
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "paladin_holy_relic",
                        trigger = autoTrigger,
                        effect = gainGoldEffect(2).seq(gainHealthEffect(selectLoc(currentCastLoc).where(isCardType(weaponType)).count()))
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Holy Relic",
                    art = "icons/thief_swipe",
                    frame = "frames/Cleric_CardFrame",
                    text = '<size=200%><voffset=.4em><sprite name="gold_2"></voffset></size><line-height=70%><size=75%>\n+1 <sprite name="health"> for each weapon you have in play.</size></line-height>'
                }
            )
        }
    )
end