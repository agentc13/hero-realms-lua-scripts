--given to the players at the start of the game, triggers at the start of first player's turn then sacrifices itself
function doubleHealthBuffDef()
    -- here we define an effect for the buff
    local ef = gainMaxHealthEffect(currentPid, getPlayerMaxHealth(currentPid))
        -- order is important here. If you heal player before increasing max health
        -- it would heal only up to current max health
        .seq(healPlayerEffect(currentPid, getPlayerMaxHealth(currentPid)))
        .seq(gainMaxHealthEffect(oppPid, getPlayerMaxHealth(oppPid)))
        .seq(healPlayerEffect(oppPid, getPlayerMaxHealth(oppPid)))
        -- now we sacrifice the card, so we don't bother it triggering at the start of next turn
        -- useful for one time effects
        .seq(sacrificeSelf())

    return createGlobalBuff({
        id = "double_health_buff",
        name = "Double health",
        abilities = {
            createAbility({
                id = "double_health_effect",
                trigger = startOfGameTrigger,
                effect = ef
            })
        }
    })
end
