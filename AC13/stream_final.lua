require 'herorealms'
require 'decks'
require 'stdlib'
require 'stdcards'
require 'hardai'
require 'mediumai'
require 'easyai'

function sacrificial_mace_carddef()
    -- Talk about brackets,parenthesis here.  They can be on the same line or on their own.
    return createDef({
            -- Unique id for card, this must be different for each card/function.
            id = "sacrificial_mace",
            -- Name displayed on the card
            name = "Sacrificial Mace",
            types = {weaponType, noStealType, thiefype, clericType, itemType, magicWeaponType, meleeWeaponType, maceType},
            acquireCost = 0,
            -- the next two lines of code make it an item and say that it gets played to the normal play location.
            cardTypeLabel = "Item",
            playLocation = castPloc,
            -- This is where we write the abilities (trigger/effect) for the card.
            abilities = {
                createAbility(
                    {
                        --unique id for ability
                        id = "sacrificial_mace_ab",
                        -- triggers when played
                        trigger = autoTrigger,
                        -- Prompt to select sacrifice (see desc)
                        prompt = showPrompt,
                        -- Make sure to discuss sequencing here!!!
                        effect = gainCombatEffect(1).seq(gainGoldEffect(1)).seq(gainHealthEffect(1)).seq(pushTargetedEffect
                                {
                                    -- Because this is a pushTargetEffect, this is the text that displays when you choose what card to sacrifice.
                                    desc = "Sacrifice a card from your hand or discard pile.",
                                    -- Minimum number of targets.
                                    min = 0,
                                    -- Maximum nomber of targets.
                                    max = 1,
                                    -- make sure to discuss .union and the different ways to write these locations and that they can't mix.
                                    -- This code describes what can be targeted by the sacrifice effect.
                                    validTargets = selectLoc(loc(currentPid,discardPloc)).union(selectLoc(loc(currentPid, handPloc))),
                                    -- This is the actual sacrifice effect.
                                    targetEffect = sacrificeTarget(),
                                 }),
                            
                    }),
                },
            -- This is the part of the code to do the card layout.
            layout = createLayout(
                {
                        -- Card name
                       name = "Sacrificial Mace",
                       -- This is the art that appears on the card.
                       -- There are limited art assets at this time, so unfortunately we will have to use one of those even if it's not what we really want to have here.
                       art = "art/T_Influence",
                       -- This is the frame of the card. The artwork around the edges.
                       frame = "frames/Cleric_CardFrame",
                       -- This is the text/icon arrangement on the card.  
                       -- This part is usually a lot of trial and error for me to get it how I want. 
                       text = '<size=170%><line-height=75%><sprite name=\"combat_1\"> <sprite name=\"gold_1\"><sprite name=\"health_1\"></line-height></size> \n<size=75%><line-height=100%><voffset=1.5em>Sacrifice a card in your \n hand or discard pile.</size></line-height>'
                }),
    })
end

function bless_of_silence_carddef()
    -- This is the layour for the skill card.  It is pretty much the same as the item card we made, but will need to be written so that it does what we want and describes what the skill does.
    local cardLayout = createLayout({
        name = "Bless of Silence",
        art = "icons/cleric_bless_the_flock",
        frame = "frames/Cleric_CardFrame",
        -- the \n is a line break.
        text = "<size=400%><line-height=0%><voffset=-.5em> <pos=-75%><sprite name=\"expend_2\"></size><line-height=100%> \n <voffset=2em><size=100%><pos=10%>Gain <sprite name=\"health_3\">\n Sacrifice a \n card in the \n market row."
    })

    -- This creates a skill (as opposed to an action or item).  It has things preset so we don't need to the cardTypeLabel/playLocation, those are already defined in the createSkillDef.
    return createSkillDef({
        id = "bless_of_silence_skill",
        name = "Bless of Silence",
        types = { skillType },
        -- This refers to the layout we made above.  I don't believe it matters if the layout is done before or after the createSkillDef. As lon as it is encapsulated within the carddef it will work.  This is a 'local' variable that is only able to be called within the same function.  It only needs a unique name within the function as opposed to within the script as a whole.
        layout = cardLayout,
        -- This is the art for the skill icon next to your player avatar.
        layoutPath = "icons/cleric_bless_the_flock",
        abilities = {
            createAbility({
                id = "bless_of_silence_ab",
                -- This trigger requires you to select the skill to use it (as opposed to happening automatically when played) since you don't actually 'play' this card from your hand.
                trigger = uiTrigger,
                -- This says that it can only be activated once per turn as opposed to multiple activations.
                activations = singleActivation,
                layout = cardLayout,
                -- The skills effect.  This gains 3 health and sacrifices a card from the market row.
                effect = gainHealthEffect(3).seq(pushTargetedEffect({
					desc = "Sacrifice a card in the Market Row.",
					min = 0,
					max = 1,
                    -- Like the targeted effect in the item card we made, this sets the valid target to a card in the market row.
					validTargets = selectLoc(centerRowLoc),
					targetEffect = sacrificeTarget(),
				})),
                -- This is the cost to use the card. Since it is a skill it costs 2 gold.
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
        -- Description of the script.  This shows wheen you hit the menu icon at the top left of the game screen.
        description = "Custom DblDubz Stream Game",
        ai = createHardAi(),
        -- Here we set the order that the players go in.  I commented it out to show that you canset it to a specific order, but we are using the randomOrder below so it isn't needed. 
        --playerOrder = { plid1, plid2 },
        randomOrder = true,
        -- This sets the players that are part of the game.
        opponents = { { plid1, plid2 } },
        -- Set this to true if you do not want a market deck in the game. This sill really only be used if you make a custom market deck. I did not include details on how to do that in this script.
        noTradeDeck = false,
        -- Set to true if you do not want Fire Gems available. Again this is just here so you know it exists, we want them included in theis gameSetup
        noFireGems = false,
        -- Here we define the starting decks, skills, abilities, and armors for the players. 
        players = {
            {
                -- plid1, plid2, plid3, plid4 are the options, but we are only setting this up as a 2 player game.
                id = plid1,
                -- The players name.  if you don't have custom decks you can just use the following to use the setup from the default 
                --[[
                init = {
                    fromEnv = plid2
                },
                ]]
                name = "DeebleDoobz",
                -- The player's avatar
                avatar = "wolf_shaman",
                -- Starting health (can be the default of the class, but this is custom)
                health = 55,
                -- Maximum health (can be the default of the class, but this is custom)
                maxHealth = 55,
                -- Here we define what cards the player starts with.
                cards = {
                    -- Cards in starting deck.
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
                    -- Skills for the player.
                    skills = {
                        { qty = 1, card = thief_smooth_heist_carddef() },
                        { qty = 1, card = thief_silent_boots_carddef() },
                        { qty = 1, card = bless_of_silence_carddef() },

                    },
                    -- Buffs for the player. 
                    -- These three are the default and will almost always be all there is. 
                    buffs = {
                        -- This tells the game to draw a new hand when the current one ends.
                        drawCardsAtTurnEndDef(),
                        -- This tells the game that the player will apply discard effect at the start of their turn.
                        discardCardsAtTurnStartDef(),
                        -- This is the enrage effect.
                        fatigueCount(40, 1, "FatigueP2")
                    }
                }
            },
            {
                -- Same as above, but for player2.
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

-- this is needed to end the game, for now this is all we can put here (that I know of).  In the future we should be able to have different win conditions and such. 
function endGame(g)
end

