-- this buff will be given to the players at the start of the game, triggers at the start of first player's turn then sacrifices itself

-- name of function for the buff we are writing    
function doubleHealthBuffDef()
    -- here we define an effect for the buff
    -- the local part means this is only called within function and is not global to all our code, so we can use names and such for other things as well outside of this function.
    -- this 
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
        -- buff card id
        id = "double_health_buff",
        -- name of buff
        name = "Double health",
        -- required to add the card abilites
        abilities = {
            -- how we create an ability
            createAbility({
                -- ability id
                id = "double_health_effect",
                -- when the ability triggers. You can find a list of these in the Lua documentation under the 'creating abilities' section.
                trigger = startOfGameTrigger,
                -- this references the local function (and the effects) that we setup above
                effect = ef
            })
        }
    })
end
