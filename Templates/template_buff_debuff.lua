-- This buff will be given to the players at the start of the game, triggers at the start of first player's turn then sacrifices itself. It doubles both players max health and heals them to that amount.

-- Code to name the function for the buff we are writing    
function doubleHealthBuffDef()
    -- Below, we define an effect for the buff
    -- Note that the 'local ef =' part means that this code is only referenced within this function and is not global to all our code, so we can use names that would repeated elsewhere in the code, but this won't be referenced by those other areas.
    -- this first line increases the current players max health 'gainMaxHealthEffect(currentPid,xxx)', and it is increased by their current base max health which is found through the 'getPlayerMaxHealth(currentPid)'
    local ef = gainMaxHealthEffect(currentPid, getPlayerMaxHealth(currentPid))
         -- the second line heals the player to their nex maximum health 'healPlayerEffect' and is set to heal them my their max health through the 'currentPid, getPlayerMaxHealth(currentPid)' part.
         -- Note that the order is important here. If you heal player before increasing max health it would heal only up to current (or original) max health
        .seq(healPlayerEffect(currentPid, getPlayerMaxHealth(currentPid)))
        -- The next two lines do the same effects for the opponent. You can see that the functions are the same except for the 'oppPid' instead of 'currentPid'.
        .seq(gainMaxHealthEffect(oppPid, getPlayerMaxHealth(oppPid)))
        .seq(healPlayerEffect(oppPid, getPlayerMaxHealth(oppPid)))
        -- Lastly, we sacrifice the card, so we don't trigger it at the start of every turn.
        -- This is done through the 'sacrificeSelf' which is quite useful for one time effects.
        .seq(sacrificeSelf())
        -- Note that the .seq is used when chaining effects together and is what chains this whole sequence of simpler effects into on large effect.

    return createGlobalBuff({
        -- buff card id
        id = "double_health_buff",
        -- name of buff
        name = "Double Health",
        -- required to add the card abilites
        abilities = {
            -- how we create an ability
            createAbility({
                -- ability id
                id = "double_health_effect",
                -- when the ability triggers. You can find a list of these in the Lua documentation under the 'creating abilities' section.
                trigger = startOfGameTrigger,
                -- this references the local function (the sequence of effects) that we setup above.
                effect = ef
            })
        }
    })
end
