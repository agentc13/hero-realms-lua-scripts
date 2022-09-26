require 'herorealms'
require 'decks'
require 'stdlib'
require 'stdcards'
require 'hardai'
require 'mediumai'
require 'easyai'

function sacrificial_mace_carddef()
    return createActionDef(
        {
            id = "sacrificial_mace",
            name = "Sacfiricial Mace",
            types = {weaponType, noStealType, thiefype, clericType, itemType, magicWeaponType, meleeWeaponType, maceType},
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "sacrificial_mace_ab",
                        trigger = autoTrigger,
                        prompt = showPrompt,
                        -- Make sure to discuss sequencing here!!!
                        effect = gainCombatEffect(1).seq(gainGoldEffect(1)).seq(gainHealthEffect(1)).seq(pushTargetedEffect
                                {
                                    desc = "Sacrifice a card from your hand or discard pile.",
                                    min = 0,
                                    max = 1,
                                    validTargets = selectLoc(loc(currentPid,discardPloc)),
                                    targetEffect =sacrificeTarget(),
                                 }),
                            
                    }),
                layout = createLayout(
                        {
                            name = "Sacrificial Mace",
                            art = "art/T_Influence",
                            frame = "frames/Cleric_CardFrame",
                            text = '<size=170%><line-height=75%><sprite name="combat_1"> <sprite name=\"gold_1\"><sprite name=\"health_1\"></line-height></size> \nsize=60%><voffset=1em>Sacrifice a card in your \n hand or discard pile.</size></line-height>'
                        }
                ),
            },
        })
end

function setupGame(g)
    registerCards(g, {
        sacrificial_mace_carddef(),
        --bless_of_silence_carddef(),
    })

    standardSetup(g, {
        description = "Custom DblDubz Stream Game",
        playerOrder = { plid1, plid2 },
        ai = createHardAi(),
        randomOrder = true,
        opponents = { { plid1, plid2 } },
        noTradeDeck = false,
        noFireGems = false,
        players = {
            {
                id = plid1,
                name = "DeebleDoobz",
                avatar = "wolf_shaman",
                health = 55,
                maxHealth = 55,
                cards = {
                    deck = {
                        { qty = 1, card = cleric_follower_a_carddef() },
                        { qty = 1, card = cleric_follower_b_carddef() },
                        { qty = 6, card = gold_carddef() },
                        { qty = 1, card = ruby_carddef() },
                        { qty = 1, card = cleric_prayer_beads_carddef() },
                        { qty = 1, card = cleric_everburning_candle_carddef() },
                        { qty = 1, card = thief_blackjack_carddef() },
                        { qty = 1, card = sacrificial_mace_carddef() },
                    },
                    skills = {
                        { qty = 1, card = thief_smooth_heist_carddef() },
                        { qty = 1, card = thief_silent_boots_carddef() },
                        { qty = 1, card = cleric_bless_the_flock_carddef() },

                    },
                    buffs = {
                        drawCardsAtTurnEndDef(),
                        discardCardsAtTurnStartDef(),
                        fatigueCount(40, 1, "FatigueP2")
                    }
                }
            },
            {
                id = plid2,
                isAi = true,
                name = "AC13",
                avatar = "the_wolf_tribe",
                health = 55,
                maxHealth = 55,
                cards = {
                    deck = {
                        { qty = 2, card = dagger_carddef() },
                        { qty = 8, card = gold_carddef() },
                    },
                    buffs = {
                        drawCardsAtTurnEndDef(),
                        discardCardsAtTurnStartDef(),
                        fatigueCount(40, 1, "FatigueP2")
                    }
                }
            }
        }
    })
end

-- more info on this later
function endGame(g)
end