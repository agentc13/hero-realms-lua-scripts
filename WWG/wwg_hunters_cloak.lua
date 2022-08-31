-- Hunter's Cloak armor example

local ab = createAbility({
        id = "ranger_hunters_cloak",
        layout = loadLayoutTexture("Textures/ranger_hunters_cloak"),

        effect =  pushChoiceEffect({
            choices={
                {
                    effect = gainGoldEffect(1),                    
                    layout = layoutCard({
                        title = "Hunter's Cloak",
                        art = "icons/ranger_hunters_cloak",
                        text = ("{1 gold}"),
                    }),
                    tags = {gold1Tag}

                },
                {
                    effect = gainHealthEffect(2),                  
                    layout = layoutCard({
                        title = "Hunter's Cloak",
                        art = "icons/ranger_hunters_cloak",
                        text = ("{2 health}"),
                    }),
                    tags = {gainHealth2Tag}
                }
            }
        }),
        trigger = uiTrigger,
        check =  minDamageTakenOpp(5).And(minHealthCurrent(30)),
        cost =expendCost,
        tags = {gold1Tag,gainHealthTag,gainHealth2Tag},
    })