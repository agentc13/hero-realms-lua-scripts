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
            showCardEffect(layoutCard({
               title = "Piracy",
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

createAbility({id, trigger, effect, cost, activations, check})