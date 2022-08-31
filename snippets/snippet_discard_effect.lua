-- code snippet to discard a card

pushTargetedEffect({
                    desc="Discard a card",
                    min=1,
                    max=1,
                    validTargets=selectLoc(currentHand()),
                    targetEffect=discardTarget(),
                    tags = { discardTag }
                })
