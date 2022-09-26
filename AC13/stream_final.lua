require 'herorealms'
require 'decks'
require 'stdlib'
require 'stdcards'
require 'hardai'
require 'mediumai'
require 'easyai'

function sacrificial_mace_carddef()
    return createDef(
        {
            id = "sacrificial_mace",
            name = "Sacfiricial Mace",
            types = {weaponType, noStealType, thiefype, clericType, itemType, magicWeaponType, meleeWeaponType, maceType},
            acquireCost = 0,
            -- this makes it an item that you play like a normal card.
            cardTypeLabel = "Item",
            playLocation = castPloc,
            abilities = {
                createAbility(
                    {
                        id = "sacrificial_mace_ab",
                        -- triggers when played
                        trigger = autoTrigger,
                        -- Prompt to select sacrifice (see desc)
                        prompt = showPrompt,
                        -- Make sure to discuss sequencing here!!!
                        effect = gainCombatEffect(1).seq(gainGoldEffect(1)).seq(gainHealthEffect(1)).seq(pushTargetedEffect
                                {
                                    desc = "Sacrifice a card from your hand or discard pile.",
                                    min = 0,
                                    max = 1,
                                    -- make sure to discuss .union and the different ways to write these locations and that they can't mix.
                                    validTargets = selectLoc(loc(currentPid,discardPloc)).union(selectLoc(loc(currentPid, handPloc))),
                                    targetEffect = sacrificeTarget(),
                                 }),
                            
                    }),
                },
            layout = createLayout(
                {
                       name = "Sacrificial Mace",
                       -- Limited art available
                       art = "art/T_Influence",
                       -- Card Frames
                       frame = "frames/Cleric_CardFrame",
                       -- 
                       text = '<size=170%><line-height=75%><sprite name=\"combat_1\"> <sprite name=\"gold_1\"><sprite name=\"health_1\"></line-height></size> \n<size=75%><line-height=100%><voffset=1.5em>Sacrifice a card in your \n hand or discard pile.</size></line-height>'
                }
                ),

        })
end

function bless_of_silence_carddef()
    local cardLayout = createLayout({
        name = "Bless of Silence",
        art = "icons/cleric_bless_the_flock",
        frame = "frames/Cleric_CardFrame",
        text = "<size=400%><line-height=0%><voffset=-.5em> <pos=-75%><sprite name=\"expend_2\"></size><line-height=100%> \n <voffset=2em><size=100%><pos=10%>Gain <sprite name=\"health_3\">\n Sacrifice a \n card in the \n market row."
    })

    return createSkillDef({
        id = "bless_of_silence_skill",
        name = "Bless of Silence",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "icons/cleric_bless_the_flock",
        abilities = {
            createAbility({
                id = "bless_of_silence_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
                effect = gainHealthEffect(2).seq(pushTargetedEffect({
					desc = "Sacrifice a card in the Market Row.",
					min = 1,
					max = 1,
					validTargets = selectLoc(centerRowLoc),
					targetEffect = sacrificeTarget(),
				})),
                cost = goldCost(2),
            }),
        }
        
    })
end

function setupGame(g)
    registerCards(g, {
        sacrificial_mace_carddef(),
        bless_of_silence_carddef(),
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
                        { qty = 1, card = bless_of_silence_carddef() },

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
                health = 75,
                maxHealth = 75,
                cards = {
                    deck = {
                        { qty = 1, card = ruby_carddef() },
                        { qty = 4, card = gold_carddef() },
                        { qty = 1, card = wizard_spell_components_carddef() },
                        { qty = 1, card = ranger_snake_pet_carddef() },
                        { qty = 2, card = wizard_ignite_carddef() },
                        { qty = 1, card = wizard_silverskull_amulet_carddef() },
                        { qty = 1, card = wizard_arcane_wand_carddef() },
                        { qty = 1, card = wizard_magic_mirror_carddef() },
                        { qty = 1, card = wondrous_wand_carddef() }

                    },
                    skills = {
                        { qty = 1, card = wizard_runic_robes_carddef() },
                        { qty = 1, card = wizard_pure_channel_carddef() },
                        { qty = 1, card = wizard_explosive_fireball_carddef() }
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


function endGame(g)
end


function setupMeta(meta)
    meta.name = "stream_final"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "Y:/Projects/hero-realms-lua-scripts/AC13/stream_final.lua"
     meta.features = {
}

end