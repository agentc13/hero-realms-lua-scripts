drawToLocationEffect(4, currentRevealLoc)
                 .seq(promptSplit({
                    selector = selectLoc(currentRevealLoc),
                    take = const(4),
                    sort = const(2),
                    ef1 =moveToTopDeckTarget(true),
                    ef2 = discardTarget(),
                    header = "Careful Track",
                    description = "Look at the top four cards of your deck. You may put up to two of them into your discard pile, then put the rest back in any order.",
                    pile1Name = "Top of Deck",
                    pile2Name = "Discard Pile",
                    eff1Tags = { buytopdeckTag },
                    eff2Tags = { cheapestTag }
                }))
-- Draw to location moves cards to reveal location, then opens prompt split dialog, where you may sort those cards out to do whatever specified as ef1 and ef2 of promptSpit