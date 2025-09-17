require 'herorealms'
require 'decks'
require 'stdlib'
require 'timeoutai'
require 'hardai_2'
require 'aggressiveai'

-- Game Setup
--=======================================================================================================
function setupGame(g)
    registerCards(g, {
    })

    standardSetup(g, {
        description = "Knights of  Balance: A Community Game Balancing Effort.",
        playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(),  createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
        players = {
            {
                id = plid1,
                --isAi = true,
                startDraw = 3,
                init = {
                    fromEnv = plid1
                },
                cards = {
                    reserve = {
                        --{ qty = 1, card = wizard_treasure_map_carddef() }
                        --{ qty = 1, card = ranger_parrot_carddef() }
                    },
                    deck = {
                    },
                    hand = {
                        --{ qty = 1, card = thief_enchanted_garrote_carddef() },
                        --{ qty = 1, card = ranger_honed_black_arrow_carddef() },
                        --{ qty = 2, card = cleric_follower_b_carddef() },
                        --{ qty = 2, card = cleric_imperial_sailor_carddef() },
                        --{ qty = 1, card = cleric_brightstar_shield_carddef() },
                        --{ qty = 1, card = fighter_rallying_flag_carddef() },
                        --{ qty = 1, card = barbarian_disorienting_headbutt_carddef() },
                    },
                    discard = {
                        -- { qty = 2, card = torgen_rocksplitter_carddef() },
                        -- { qty = 2, card = cleric_follower_b_carddef() },
                        -- { qty = 1, card = cleric_follower_a_carddef() },
                        -- { qty = 1, card = cleric_veteran_follower_carddef() },
                        -- { qty = 1, card = cleric_redeemed_ruinos_carddef() },
                    },
                    skills = {
                        --{ qty = 1, card = fighter_helm_of_fury_carddef() },
                        --{ qty = 1, card = alchemist_spectrum_spectacles_carddef() }
                    },
                    buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
                        fatigueCount(40, 1, "FatigueP1"),
                    }
                }
            },
            {
                id = plid2,
                --isAi = true,
                startDraw = 5,
                init = {
                    fromEnv = plid2
                },
                cards = {
                    reserve = {
                        --{ qty = 1, card = wizard_treasure_map_carddef() }
                        --{ qty = 1, card = ranger_parrot_carddef() }
                    },
                    deck = {
                    },
                    hand = {
                        --{ qty = 1, card = ranger_light_crossbow_carddef() },
                        --{ qty = 1, card = ranger_honed_black_arrow_carddef() },
                        --{ qty = 2, card = cleric_follower_b_carddef() },
                        --{ qty = 2, card = cleric_imperial_sailor_carddef() },
                        --{ qty = 1, card = cleric_brightstar_shield_carddef() },
                        --{ qty = 1, card = sway_carddef() },
                    },
                    discard = {
                        --{ qty = 2, card = cleric_follower_b_carddef() },
                    },
                    skills = {
                        --{ qty = 1, card = cleric_shining_breastplate_carddef() },
                    },
                    buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
                        fatigueCount(40, 1, "FatigueP2"),
                    }
                }
            },            
        }
    })
end

function endGame(g)
end

function setupMeta(meta)
                meta.name = "knights_of_balance_v1"
                meta.minLevel = 13
                meta.maxLevel = 24
                meta.introbackground = ""
                meta.introheader = ""
                meta.introdescription = ""
                meta.path = "C:/Users/xTheC/Desktop/Git Repositories/hero-realms-lua-scripts/Knights  of Balance/knights_of_balance_v1.lua"
                meta.features = {
}

end

--Card Overrides
--=======================================================================================================
function fighter_rallying_flag_carddef()
    local cardLayout = createLayout({
        name = "Rallying Flag",
        art = "art/t_fighter_rallying_flag",
        frame = "frames/Warrior_CardFrame",
        cardTypeLabel = "Champion",
        isGuard = true,
        health = 1,
        types = { championType, humanType, fighterType },
        xmlText = [[<vlayout>
                        <box flexibleheight="1">
                            <tmpro text="{gold_2}   {combat_1}" fontsize="60"/>
                        </box>
                    </vlayout>]]
    })
    return createChampionDef({
        id = "fighter_rallying_flag",
        name = "Rallying Flag",
        acquireCost = 0,
        health = 1,
        isGuard = true,
        layout = cardLayout,
        types = { championType, humanType, fighterType },
        factions = {},
        abilities = {
            createAbility({
                id = "fighter_rallying_flag",
                trigger = autoTrigger,
                activations = multipleActivations,
                cost = expendCost,
                effect = gainCombatEffect(1).seq(gainGoldEffect(2))
            }),
        }
    })
end
--=========================================
function cleric_redeemed_ruinos_carddef()
    local cardLayout = createLayout({
        name = "Redeemed Ruinos",
        art = "art/t_cleric_redeemed_ruinos",
        frame = "frames/Cleric_CardFrame",
        cardTypeLabel = "Champion",
        isGuard = false,
        health = 1,
        types = { championType, noStealType, humanType, clericType, noKillType},
        xmlText = [[<vlayout forceheight="false" spacing="6">
                        <hlayout spacing="10">
                        <text text="When stunned, draw 1." fontsize="32"/>
                        </hlayout>    
                        <divider/>
                        <hlayout forcewidth="true" spacing="10">
                            <icon text="{expend}" fontsize="52"/>
                            <vlayout  forceheight="false">
                        <icon text="{health_1}  {gold_1}" fontsize="46"/>
                            </vlayout>
                            <icon text=" " fontsize="20"/>
                        </hlayout>
                    </vlayout>
                    ]]
    })
    return createChampionDef({
        id = "cleric_redeemed_ruinos",
        name = "Redeemed Ruinos",
        acquireCost = 0,
        health = 1,
        isGuard = false,
        layout = cardLayout,
        factions = {},
        types = { championType, noStealType, humanType, clericType, noKillType},
        tags = {noAttackButtonTag},
        abilities = {
            createAbility({
                id = "cleric_redeemed_ruinos",
                trigger = autoTrigger,
                activations = multipleActivations,
                cost = expendCost,
                effect = gainHealthEffect(1).seq(gainGoldEffect(1))
            }),
            createAbility({
                id = "cleric_redeemed_ruinos_stunned",
                trigger = onStunTrigger,
                effect = createCardEffect(ruinosDrawBuff(), oppBuff()).seq(simpleMessageEffect("Drawing a card next turn.")),
            })
        }
    })
end

function ruinosDrawBuff()
    return createGlobalBuff({
        id="cleric_redeemed_ruinos_stunned",
        name="Ruinos Draw",
        abilities = {
            createAbility({
                id = "ruinos_draw",
                triggerPriority = 10,
                trigger = startOfTurnTrigger,
                cost = sacrificeSelfCost,
                effect = drawCardsEffect(1)
            }),
        },
        buffDetails = createBuffDetails({
            name = "Redeemed Ruinos",
            art = "art/t_cleric_redeemed_ruinos",
            text = "Draw a card."
        })
    })
    end
--=========================================
-- function ranger_parrot_carddef()
--     local cardLayout = createLayout({
--         name = "Parrot",
--         art = "art/treasures/t_parrot",
--         frame = "frames/Ranger_CardFrame",
--         cardTypeLabel = "Champion",
--         isGuard = false,
--         health = 1,
--         types = { championType, rangerType, reserveType, noKillType,  parrotType},
--         xmlText = [[<vlayout>
--                     <hlayout flexibleheight="1.8">
--                     <box flexiblewidth="1">
--                     <tmpro text="{expend}" fontsize="42"/>
--                     </box>
--                     <vlayout flexiblewidth="7">
--                     <box flexibleheight="0.5">
--                     <tmpro text="Reserve  1" fontsize="18" />
--                     </box>
--                     <box flexibleheight="1">
--                     <tmpro text="{gold_2}  {combat_1}" fontsize="50" />
--                     </box>
--                     </vlayout>
--                     </hlayout>
--                     <divider/>
--                     <hlayout flexibleheight="1">
--                     <box flexiblewidth="7">
--                     <tmpro text="When this card enters your discard pile (except end of turn) draw a card." fontsize="16" />
--                     </box>
--                     </hlayout>
--                     </vlayout>
--                     ]]
--     })
--     return createChampionDef({
--         id = "ranger_parrot",
--         name = "Parrot",
--         acquireCost = 0,
--         health = 1,
--         isGuard = false,
--         layout = cardLayout,
--         factions = {},
--         types = { championType, rangerType, reserveType, noKillType, parrotType},
--         tags = {noAttackButtonTag},
--         abilities = {
--             createAbility({
--                 id = "ranger_parrot",
--                 trigger = autoTrigger,
--                 activations = multipleActivations,
--                 cost = expendCost,
--                 effect = gainGoldEffect(2).seq(gainCombatEffect(1))
--             }),
--             createAbility({
--                 id = "ranger_parrot_discarded",
--                 trigger = onDiscardTrigger,
--                 activations = multipleActivations,
--                 effect = ifElseEffect(getPlayerDamageReceivedThisTurn(currentPid).eq(getPlayerDamageReceivedThisTurn(ownerPid)),
--                                         drawCardsEffect(1),
--                                         createCardEffect(parrotDrawBuff(), oppBuff()).seq(simpleMessageEffect("Drawing a card next turn."))) 
--             }),
--             createAbility({
--                 id = "ranger_parrot_killed",
--                 trigger = onLeavePlayTrigger,
--                 activations = multipleActivations,
--                 effect = createCardEffect(parrotDrawBuff(), oppBuff()).seq(simpleMessageEffect("Drawing a card next turn."))
--             })
--         }
--     })
-- end   

-- function parrotDrawBuff()
--     return createGlobalBuff({
--         id="ranger_parrot_stunned",
--         name="Parrot Draw",
--         abilities = {
--             createAbility({
--                 id = "parrot_draw",
--                 triggerPriority = 10,
--                 trigger = startOfTurnTrigger,
--                 cost = sacrificeSelfCost,
--                 effect = drawCardsEffect(1)
--             }),
--         },
--         buffDetails = createBuffDetails({
--             name = "Parrot",
--             art = "art/treasures/t_parrot",
--             text = "Draw a card."
--         })
--     })
--     end
--=========================================
function wizard_treasure_map_carddef()
    local cardLayout = createLayout({
        name = "Treasure Map",
        art = "art/treasures/t_treasure_map",
        frame = "frames/Wizard_CardFrame",
        cardTypeLabel = "Item",
        xmlText =[[<vlayout>
                    <tmpro text="Reserve 1" fontsize="16" flexibleheight="0.5"/>
                    <tmpro text="{gold_1}" fontsize="28" flexibleheight="0.8" flexiblewidth="3"/>
                    <divider/>
                    <hlayout flexibleheight="1">
                        <tmpro text="{imperial}" fontsize="36" flexiblewidth="3"/>
                        <tmpro text="&lt;cspace=0.3em&gt;{health_4}&lt;/cspace&gt;" fontsize="36" flexiblewidth="8" />
                        <tmpro text="{guild}" fontsize="36" flexiblewidth="5"/>
                        <tmpro text="&lt;cspace=0.5em&gt;{gold_2}&lt;/cspace&gt;" fontsize="36" flexiblewidth="8" />
                    </hlayout>
                    <divider/>
                    <hlayout flexibleheight="1">

                        <tmpro text="{wild}" fontsize="36" flexiblewidth="3"/>
                        <tmpro text="Draw a card then discard a card.&lt;/cspace&gt;" fontsize="14" flexiblewidth="7" />
                        <tmpro text="{necro}" fontsize="36" flexiblewidth="5"/>
                        <tmpro text="Sacrifice 1 card in hand or discard.&lt;/cspace&gt;" fontsize="14" flexiblewidth="7" />
                    </hlayout>
                </vlayout>]]
    })
    --
    return createItemDef({
        id = "wizard_treasure_map",
        name = "Treasure Map",
        acquireCost = 0,
        cardTypeLabel = "Item",
        types = { itemType, noStealType, wizardType, reserveType},
        factions = {},
        layout = cardLayout,
        playLocation = castPloc,
            abilities = {
                createAbility({
                    id = "mapMain",
                    trigger = autoTrigger,
                    effect = gainGoldEffect(1),
                }),
                createAbility({
                    id = "mapUI",
                    trigger = uiTrigger,
                    activations = multipleActivations,
                    check = hasPlayerSlot(currentPid, "mapNecro").Or(hasPlayerSlot(currentPid, "mapWild")),
                    effect = pushChoiceEffect({
                                        choices={
                                            {
                                                effect = pushTargetedEffect({
                                                                    desc="Sacrifice a card in your hand or  dicard pile.",
                                                                    min=0,
                                                                    max=1,
                                                                    validTargets = selectLoc(loc(currentPid, discardPloc)).union(selectLoc(loc(currentPid, handPloc))),
                                                                    targetEffect = sacrificeTarget(),
                                                                 }).seq(removeSlotFromPlayerEffect(currentPid, "mapNecro")),                
                                                layout = layoutCard({
                                                    title = "Necros",
                                                    art = "art/treasures/t_treasure_map",
                                                    text = "<sprite name=\"necro\"> Scrap a card",
                                                }),
                                                condition = hasPlayerSlot(currentPid, "mapNecro")                         
                                            },
                                            {
                                                effect = drawCardsEffect(1)
                                                            .seq(pushTargetedEffect({
                                                                    desc = "Discard a card.",
                                                                    min = 1,
                                                                    max = 1,
                                                                    validTargets = selectLoc(loc(currentPid, handPloc)),
                                                                    targetEffect = discardTarget(),
                                                                    }))
                                                                    .seq(removeSlotFromPlayerEffect(currentPid, "mapWild")),              
                                                layout = layoutCard({
                                                    title = "Wild",
                                                    art = "art/treasures/t_treasure_map",
                                                    text = "<sprite name=\"wild\"> Draw a card, then discard a card.",
                                                }),
                                                condition = hasPlayerSlot(currentPid, "mapWild")
                                            }
                                        }
                                    }),
                }),
                createAbility({
                    id = "necrosMain",
                    trigger = autoTrigger,
                    tags = {allyTag},
                    allyFactions = {necrosFaction},
                    effect = addSlotToPlayerEffect(currentPid, createPlayerSlot({ key = "mapNecro", expiry = { endOfTurnExpiry } })),
                }),
                createAbility({
                    id = "guildMain",
                    trigger = autoTrigger,
                    tags = {allyTag},
                    allyFactions = {guildFaction},
                    effect = gainGoldEffect(2)
                }),
                createAbility({
                    id = "wildMain",
                    trigger = autoTrigger,
                    tags = {allyTag},
                    allyFactions = {wildFaction},
                    effect = addSlotToPlayerEffect(currentPid, createPlayerSlot({ key = "mapWild", expiry = { endOfTurnExpiry } })),                      
                }),
                createAbility({
                    id = "impMain",
                    trigger = autoTrigger,
                    tags = {allyTag},
                    allyFactions = {imperialFaction},
                    effect = gainHealthEffect(4)
                })
            }
    })
end

--==============================================================
--This   map is kept here for record
--==============================================================
function TESTwizard_treasure_map_carddef()
    local cardLayout = createLayout({
        name = "Treasure Map",
        art = "art/treasures/t_treasure_map",
        frame = "frames/Wizard_CardFrame",
        cardTypeLabel = "Item",
        xmlText =[[<vlayout>
                    <tmpro text="Reserve 1" fontsize="18" flexibleheight="0.5"/>
                    <divider/>
                    <hlayout flexibleheight="1">
                        <tmpro text="{imperial}" fontsize="36" flexiblewidth="3"/>
                        <tmpro text="&lt;cspace=0.3em&gt;{health_4}&lt;/cspace&gt;" fontsize="36" flexiblewidth="8" />
                        <tmpro text="{guild}" fontsize="36" flexiblewidth="5"/>
                        <tmpro text="&lt;cspace=0.5em&gt;{gold_2}&lt;/cspace&gt;" fontsize="36" flexiblewidth="8" />
                    </hlayout>
                    <divider/>
                    <hlayout flexibleheight="1">

                        <tmpro text="{wild}" fontsize="36" flexiblewidth="3"/>
                        <tmpro text="&lt;cspace=0.3em&gt;{combat_3}&lt;/cspace&gt;" fontsize="36" flexiblewidth="7" />
                        <tmpro text="{necro}" fontsize="36" flexiblewidth="5"/>
                        <tmpro text="Sacrifice 1 card in hand or discard.&lt;/cspace&gt;" fontsize="14" flexiblewidth="7" />
                    </hlayout>
                </vlayout>]]
    })
    --
    return createItemDef({
        id = "wizard_treasure_map",
        name = "Treasure Map",
        acquireCost = 0,
        cardTypeLabel = "Item",
        types = { itemType, noStealType, wizardType, reserveType},
        factions = {},
        layout = cardLayout,
        playLocation = castPloc,
            abilities = {
                createAbility({
                    id = "necrosMain",
                    trigger = uiTrigger,
                    tags = {allyTag},
                    allyFactions = {necrosFaction},
                    effect = pushTargetedEffect({
                                desc="Sacrifice a card in your hand or  dicard pile.",
                                min=0,
                                max=1,
                                validTargets = selectLoc(loc(currentPid, discardPloc)).union(selectLoc(loc(currentPid, handPloc))),
                                targetEffect = sacrificeTarget(),
                             }),
                }),
                createAbility({
                    id = "guildMain",
                    trigger = autoTrigger,
                    tags = {allyTag},
                    allyFactions = {guildFaction},
                    effect = gainGoldEffect(2)
                }),
                createAbility({
                    id = "wildMain",
                    trigger = uiTrigger,
                    tags = {allyTag},
                    allyFactions = {wildFaction},
                    effect = gainCombatEffect(2)                        
                }),
                createAbility({
                    id = "impMain",
                    trigger = autoTrigger,
                    tags = {allyTag},
                    allyFactions = {imperialFaction},
                    effect = gainHealthEffect(4)
                })
            }
    })
end
--=========================================
function barbarian_plunder_carddef()
    local cardLayout = createLayout({
        name = "Plunder",
        art = "art/classes/barbarian/plunder",
        frame = "frames/barbarian_frames/barbarian_skill_cardframe",
        acquireCost = 0,
        cardTypeLabel = "Action",
        types = { actionType, barbarianType},
        factions = {},
        layout = cardLayout,
        playLocation = castPloc,
        xmlText = [[<vlayout>
                        <hlayout flexibleheight="3">
                                <tmpro text="You may acquire a card of cost 2 or less for free (or 3 or less if you  are Berserk)." fontsize="24" flexiblewidth="1" />
                        </hlayout>
                    </vlayout>]]
    })
    --
    return createActionDef({
        id = "barbarian_plunder",
        name = "Plunder",
        acquireCost = 0,
        layout = cardLayout,
        types = { actionType, barbarianType},
        factions = {},
        abilities = {
            createAbility({
                id = "barbarian_plunder",
                trigger = autoTrigger,
                activations = sigleActivations,
                cost = noCost,
                effect = ifElseEffect(hasPlayerSlot(currentPid, berserkSlotKey),
                                pushTargetedEffect({
                                    desc="Acquire a card for free.",
                                    min=0,
                                    max=1,
                                    validTargets = selectLoc(centerRowLoc).union(selectLoc(fireGemsLoc)).where(isCardAcquirable().And(getCardCost().lte(3))),
                                    targetEffect = acquireForFreeTarget(),
                                }),
                                pushTargetedEffect({
                                    desc="Acquire a card for free.",
                                    min=0,
                                    max=1,
                                    validTargets = selectLoc(centerRowLoc).union(selectLoc(fireGemsLoc)).where(isCardAcquirable().And(getCardCost().lte(2))),
                                    targetEffect = acquireForFreeTarget(),
                                })
                            )              
            }),
        }
    })
end
--=========================================
function ranger_honed_black_arrow_carddef()
    local cardLayout = createLayout({
        name = "Honed Black Arrow",
        art = "art/t_ranger_honed_black_arrow",
        frame = "frames/Ranger_CardFrame",
        cardTypeLabel = "Item",
        xmlText =[[<vlayout>
                    <hlayout flexibleheight="2">
                            <tmpro text="&lt;space=-0.3em/&gt;{combat_4}" fontsize="60" flexiblewidth="8" />
                    </hlayout>
                    <hlayout flexibleheight="3">
                            <tmpro text="If you have a bow in play, Draw a card." fontsize="28" flexiblewidth="1" />
                    </hlayout>
                </vlayout>]]
    })
    --
    local bowInPlay = selectLoc(loc(currentPid, castPloc)).where(isCardType(bowType)).count()
    --
    return createItemDef({
        id = "ranger_honed_black_arrow",
        name = "Honed Black Arrow",
        acquireCost = 0,
        cardTypeLabel = "Item",
        types = { itemType, noStealType, rangerType, arrowType},
        factions = {},
        layout = cardLayout,
        playLocation = castPloc,
            abilities = {
                createAbility({
                    id = "honedMain",
                    trigger = autoTrigger,
                    playAllType = blockPlayType,
                    check = bowInPlay.gte(1),
                    effect = gainCombatEffect(4).seq(drawCardsEffect(1))
                }),
                createAbility({
                    id = "honedSlot",
                    trigger = autoTrigger,
                    playAllType = blockPlayType,
                    check = bowInPlay.eq(0),
                    effect = gainCombatEffect(4).seq(addSlotToPlayerEffect(currentPid, createPlayerSlot({ key = "bowPlayedSlot", expiry = { endOfTurnExpiry } })))
                }),
                createAbility({
                    id = "honedDraw",
                    trigger = onPlayTrigger,
                    activations = multipleActivations,
                    effect = ifElseEffect(hasPlayerSlot(currentPid, "bowPlayedSlot").And(bowInPlay.gte(1)),
                                            drawCardsEffect(1),
                                            nullEffect()) 
                })
                },
    })
end

--=========================================
function cleric_brightstar_shield_carddef()
    local cardLayout = createLayout({
        name = "Brightstar Shield",
        art = "art/t_cleric_brightstar_shield",
        frame = "frames/Cleric_CardFrame",
        cardTypeLabel = "Item",
        xmlText =[[<vlayout>
                    <hlayout flexibleheight="3">
                            <tmpro text="Draw 1.&lt;br&gt; Attach this to a friendly champion.&lt;br&gt;Prepare it and it has +2 {shield}." fontsize="20" flexiblewidth="1" />
                    </hlayout>
                </vlayout>]]
    })
    local fetchShields = moveTarget(loc(ownerPid, discardPloc)).apply(selectLoc(loc(oppPid, asidePloc)))
    -- local fetchShields = moveTarget(loc(ownerPid, discardPloc)).apply(selectLoc(loc(currentPid, asidePloc)))
                            --.seq(moveTarget(loc(ownerPid, discardPloc)).apply(selectLoc(loc(oppPid, asidePloc))))
    --
    local  oneChamp =  prepareTarget().apply(selectLoc(loc(currentPid,inPlayPloc)))
                        .seq(grantHealthTarget(2, { SlotExpireEnum.LeavesPlay }, fetchShields, "shield").apply(selectLoc(loc(currentPid,inPlayPloc))))
                        .seq(moveTarget(asidePloc).apply(selectLoc(loc(currentPid, castPloc)).where(isCardName("cleric_brightstar_shield"))))
    --
    local  multiChamp = pushTargetedEffect({
                            desc="Choose a champion to prepare and gain +2 defense from brightstar shield",
                            min=1,
                            max=1,
                            validTargets = selectLoc(loc(currentPid,inPlayPloc)).where(isCardChampion()),
                            targetEffect = prepareTarget().seq(grantHealthTarget(2, { SlotExpireEnum.LeavesPlay },fetchShields,"shield").apply(selectTargets())),
                        })
                        .seq(moveTarget(asidePloc).apply(selectLoc(loc(currentPid, castPloc)).where(isCardName("cleric_brightstar_shield"))))
    --
    local numChamps =  selectLoc(loc(currentPid,inPlayPloc)).where(isCardChampion()).count()
    --
    return createItemDef({
        id = "cleric_brightstar_shield",
        name = "Brightstar Shield",
        acquireCost = 0,
        cardTypeLabel = "Item",
        types = { itemType, noStealType, clericType, attachmentType},
        factions = {},
        layout = cardLayout,
        playLocation = castPloc,
            abilities = {
                    createAbility({
                        id = "brightMain",
                        trigger = autoTrigger,
                        playAllType = blockPlayType,
                        effect = drawCardsEffect(1).seq(ifElseEffect(numChamps.eq(0),
                                                            nullEffect(),
                                                            ifElseEffect(numChamps.eq(1),
                                                            oneChamp,
                                                            multiChamp)))
                    }),
                },
    })
end

--=========================================
function cleric_shining_breastplate_carddef()
    local cardLayout = createLayout({
        name = "Shining Breastplate",
        art = "art/t_cleric_shining_breastplate",
        frame = "frames/Cleric_CardFrame",
        cardTypeLabel = "Magical Armor",
        xmlText =[[<vlayout>
                        <hlayout flexibleheight="1">
                            <box flexiblewidth="1">
                                <tmpro text="{requiresHealth_10}" fontsize="72"/>
                            </box>
                            <box flexiblewidth="7">
                                <tmpro text="Put a champion without a cost from your discard into play." fontsize="28" />
                            </box>
                        </hlayout>
                    </vlayout>]]
    })
    local noCostChamps = selectLoc(loc(currentPid, discardPloc)).where(isCardChampion().And(getCardCost().eq(0)))
    --
    return createMagicArmorDef({
        id = "cleric_shining_breastplate",
        name = "Shining Breastplate",
        types = {clericType, magicArmorType, treasureType, chestType},
        layout = cardLayout,
        layoutPath = "icons/cleric_shining_breastplate",
        abilities = {
            createAbility( {
                id = "cleric_shining_breastplate",
                trigger = uiTrigger,
                activations = singleActivation,
                promptType = showPrompt,
                layout = cardLayout,
                effect = pushTargetedEffect(
                    {
                        desc = "Choose a champion without a cost to put in play",
                        validTargets = noCostChamps,
                        min = 0,
                        max = 1,
                        targetEffect = moveTarget(currentInPlayLoc),
                        tags = {toughestTag}                        
                    }
                ),
                cost = expendCost,
                check = minHealthCurrent(10).And(noCostChamps.count().gte(1))
            })
        }        
    })
end

--=========================================
function thief_silent_boots_carddef()
    --
    local cardLayout = createLayout({
						name = "Silent Boots",
						art = "art/t_thief_silent_boots",
						frame = "frames/Thief_armor_frame",
						xmlText = [[<vlayout>
                                    <hlayout flexibleheight="1">
                                        <box flexiblewidth="1.5">
                                            <tmpro text="{requiresHealth_10}" fontsize="72"/>
                                        </box>
                                        <box flexiblewidth="7">
                                            <tmpro text="Reveal the top two cards from the market deck. Sacrifice one, you may acquire the other for &lt;br&gt;1 {gold} less or put it back." fontsize="20" />
                                        </box>
                                    </hlayout>
                                </vlayout>]]
    })
    --
    local cardLayoutBuy = createLayout({
                                    name = "Silent Boots",
                                    art = "art/t_thief_silent_boots",
                                    frame = "frames/Thief_armor_frame",
                                    xmlText = [[<vlayout>
                                                    <hlayout flexibleheight="1">
                                                        <box flexiblewidth="7">
                                                            <tmpro text="Acquire for 1 {gold} less." fontsize="26" />
                                                        </box>
                                                    </hlayout>
                                                </vlayout>]]
                            })
    --
    local cardLayoutTopDeck = createLayout({
                                    name = "Silent Boots",
                                    art = "art/t_thief_silent_boots",
                                    frame = "frames/Thief_armor_frame",
                                    xmlText = [[<vlayout>
                                                    <hlayout flexibleheight="1">
                                                        <box flexiblewidth="7">
                                                            <tmpro text="Put it back on the top the market deck." fontsize="26" />
                                                        </box>
                                                    </hlayout>
                                                </vlayout>]]
                                })
    --                            
    local effReveal =  noUndoEffect().seq(moveTarget(currentRevealLoc).apply(selectLoc(tradeDeckLoc).take(2).reverse())
                            .seq(pushTargetedEffect({
                                    desc="Select one card to Sacrifice. The other card may be acquired for 1 less or put back on top of the market deck.",
                                    min = 1,
                                    max = 1,
                                    validTargets = selectLoc(currentRevealLoc),
                                    targetEffect = sacrificeTarget(),
                                })))
        --
    local checkSelector = selectLoc(currentRevealLoc).Where(isCardAcquirable().And(getCardCost().lte(getPlayerGold(currentPid).add(toIntExpression(1)))))
    --
    local effTopOrBuy = noUndoEffect().seq(pushChoiceEffect({
                                choices={
                                    {
                                        effect = acquireTarget(1,discardPloc).apply(selectLoc(currentRevealLoc)),
                                        layout = cardLayoutBuy,
                                        condition = checkSelector.count().gte(1),                      
                                    },
                                    {
                                        effect = moveTarget(tradeDeckLoc).apply(selectLoc(currentRevealLoc)),            
                                        layout = cardLayoutTopDeck,
                                    }
                                }
                            }))
    --
    return createMagicArmorDef({
        id = "thief_silent_boots",
        name = "Silent Boots",
        types = { magicArmorType, thiefType, feetType, treasureType },
        layout = cardLayout,
        abilities = {
            createAbility({
                id = "triggerBoots",
				trigger = uiTrigger,
                layout = cardLayout,
				promptType = showPrompt,
                check =  minHealthCurrent(10),
                effect = noUndoEffect().seq(effTopOrBuy).seq(effReveal),
        }),
    },
		layoutPath = "icons/thief_silent_boots"
    })
end

--=========================================
function thief_enchanted_garrote_carddef()
    local cardLayout = createLayout({
        name = "Enchanted Garrote",
        art = "art/t_thief_enchanted_garrote",
        frame = "frames/Thief_CardFrame",
        cardTypeLabel = "Item",
        xmlText =[[<vlayout>
                    <hlayout flexibleheight="2.5">
                            <tmpro text="&lt;space=0.2em/&gt;{combat_1} {gold_1}" fontsize="50" flexiblewidth="8" />
                    </hlayout>
                    <hlayout flexibleheight="4">
                            <tmpro text="If you stun a champion this turn, gain {gold_1}" fontsize="20" flexiblewidth="1" />
                    </hlayout>
                </vlayout>]]
    })
    --
    local stunnedChamps = selectLoc(loc(oppPid, discardPloc)).where(isCardStunned()).count()
    --
    return createItemDef({
        id = "thief_enchanted_garrote",
        name = "Enchanted Garrote",
        acquireCost = 0,
        cardTypeLabel = "Item",
        types = { itemType, noStealType, thiefType, garoteType, weaponType},
        factions = {},
        layout = cardLayout,
        playLocation = castPloc,
            abilities = {
                createAbility({
                    id = "garroteMain",
                    trigger = autoTrigger,
                    check = stunnedChamps.eq(0),
                    effect = gainCombatEffect(1).seq(gainGoldEffect(1)).seq(addSlotToPlayerEffect(currentPid, createPlayerSlot({ key = "champStunnedSlot", expiry = { endOfTurnExpiry } })))
                }),
                createAbility({
                    id = "garroteSlot",
                    trigger = autoTrigger,
                    check = hasPlayerSlot(currentPid, "champStunnedSlot").invert().And(stunnedChamps.gte(1)),
                    effect = gainCombatEffect(1).seq(gainGoldEffect(2))
                }),
                createAbility({
                    id = "garroteStun",
                    trigger = onStunGlobalTrigger,
                    activations = singleActivation,
                    effect = ifElseEffect(hasPlayerSlot(currentPid, "champStunnedSlot").And(stunnedChamps.gte(1)),
                                            gainGoldEffect(1),
                                            nullEffect()) 
                })
                },
    })
end

--=========================================
function fighter_helm_of_fury_carddef()
    local cardLayout = createLayout({
        name = "Helm of Fury",
        art = "art/t_fighter_helm_of_fury",
        frame = "frames/Warrior_CardFrame",
        cardTypeLabel = "Magical Armor",
        xmlText =[[<vlayout>
                        <hlayout flexibleheight="1">
                            <box flexiblewidth="1">
                                <tmpro text="{requiresHealth_20}" fontsize="72"/>
                            </box>
                            <box flexiblewidth="7">
                                <tmpro text="If you have a guard in play,&lt;br&gt; gain {gold_1} {combat_1}" fontsize="32" />
                            </box>
                        </hlayout>
                </vlayout>
                    ]]
    })
    local guardChamps = selectLoc(loc(currentPid, inPlayPloc)).where(isGuard()).count()
    local disableHelm = disableTarget({ endOfTurnExpiry }).apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardType(magicArmorType)))
    --local disableHelm = nullEffect()
    --
    return createMagicArmorDef({
        id = "fighter_helm_of_fury",
        name = "Helm of Fury",
        types = {fighterType, magicArmorType, treasureType, headType},
        layout = cardLayout,
        layoutPath = "icons/fighter_helm_of_fury",
        abilities = {
                createAbility({
                    id = "helmGuard",
                    trigger = autoTrigger,
                    check = minHealthCurrent(20).And(guardChamps.gte(1)),
                    effect = gainCombatEffect(1).seq(gainGoldEffect(1)).seq(disableHelm)
                }),
                createAbility({
                    id = "helmLateGuard",
                    trigger = onPlayTrigger,
                    activations = singleActivation,
                    check = minHealthCurrent(20),
                    effect = ifElseEffect(guardChamps.gte(1),
                                            gainCombatEffect(1).seq(gainGoldEffect(1)).seq(disableHelm),
                                            nullEffect()) 
                }),
                createAbility({
                    id = "helmHeal",
                    trigger = gainedHealthTrigger,
                    activations = singleActivation,
                    check = minHealthCurrent(20),
                    effect = ifElseEffect(guardChamps.gte(1),
                                            gainCombatEffect(1).seq(gainGoldEffect(1)).seq(disableHelm),
                                            nullEffect()) 
                })
        }        
    })
end

--=========================================
function alchemist_spectrum_spectacles_carddef()
    local cardLayout = createLayout({
        name = "Spectrum Spectacles",
        art = "art/classes/alchemist/spectrum_spectacles",
        frame = "frames/alchemist_frames/alchemist_skill_cardframe",
        cardTypeLabel = "Magic Armor",
        xmlText =[[<vlayout>
                    <hlayout flexibleheight="10">
                        <box flexiblewidth="2">
                            <tmpro text="{requiresHealth_30}" fontsize="32"/>
                        </box>
                        <box flexiblewidth="2">
                            <tmpro text="{imperial}" fontsize="32" />
                        </box>
                        <box flexiblewidth="1.5">
                            <tmpro text="{imperial}" fontsize="32" />
                        </box>
                        <box flexiblewidth="13">
                            <tmpro text="{health_2}" fontsize="32" />
                        </box>
                    </hlayout>
                    <divider/>
                    <hlayout flexibleheight="10">
                        <box flexiblewidth="2">
                            <tmpro text="{requiresHealth_30}" fontsize="32"/>
                        </box>
                        <box flexiblewidth="2">
                            <tmpro text="{necro}" fontsize="32" />
                        </box>
                        <box flexiblewidth="1.5">
                            <tmpro text="{necro}" fontsize="32" />
                        </box>
                        <box flexiblewidth="13">
                            <tmpro text="{combat_2}" fontsize="32" />
                        </box>
                    </hlayout>
                    <divider/>
                    <hlayout flexibleheight="10">
                        <box flexiblewidth="2">
                            <tmpro text="{requiresHealth_30}" fontsize="32"/>
                        </box>
                        <box flexiblewidth="2">
                            <tmpro text="{wild}" fontsize="32" />
                        </box>
                        <box flexiblewidth="1.5">
                            <tmpro text="{wild}" fontsize="32" />
                        </box>
                        <box flexiblewidth="13">
                            <tmpro text="  Draw a card, then discard a card" fontsize="16" />
                        </box>
                    </hlayout>
                    <divider/>
                    <hlayout flexibleheight="10">
                        <box flexiblewidth="2">
                            <tmpro text="{requiresHealth_30}" fontsize="32"/>
                        </box>
                        <box flexiblewidth="2">
                            <tmpro text="{guild}" fontsize="32" />
                        </box>
                        <box flexiblewidth="1.5">
                            <tmpro text="{guild}" fontsize="32" />
                        </box>
                        <box flexiblewidth="13">
                            <tmpro text="{gold_1}" fontsize="32" />
                        </box>
                    </hlayout>
                </vlayout>]]
        -- xmlText =[[<vlayout>
        --             <hlayout spacing="2" flexibleheight="1.2">
        --                     <text text="{requiresHealth_30}" flexiblewidth="1" fontsize="32"/>
        --                     <vlayout flexiblewidth="0.2" spacing="-115" forceheight="true">
        --                         <text text="{imperial}"  fontsize="32" alignment="right"/>
        --                         <text text="{imperial}"  fontsize="32"/>
        --                     </vlayout>
        --                     <text text="{health_2}" flexiblewidth="1" fontsize="32"/>
        --                     <text text="txt" color="0,0,0,0" fontsize="32"/>
        --                 </hlayout>
        --             <divider/>
        --             <hlayout spacing="2" flexibleheight="1.2">
        --                     <text text="{requiresHealth_30}" flexiblewidth="1" fontsize="32"/>
        --                     <vlayout flexiblewidth="0.2" spacing="-115" forceheight="true">
        --                         <text text="{necro}"  fontsize="32" alignment="right"/>
        --                         <text text="{necro}"  fontsize="32"/>
        --                     </vlayout>
        --                     <text text="{combat_2}" flexiblewidth="1" fontsize="32"/>
        --                     <text text="txt" color="0,0,0,0" fontsize="32"/>
        --                 </hlayout>
        --             <divider/>
        --             <hlayout spacing="2" flexibleheight="1.2">
        --                     <text text="{requiresHealth_30}" flexiblewidth="1" fontsize="32"/>
        --                     <vlayout flexiblewidth="0.2" spacing="-115" forceheight="true">
        --                         <text text="{wild}"  fontsize="32" alignment="right"/>
        --                         <text text="{wild}"  fontsize="32"/>
        --                     </vlayout>
        --                     <text text="Draw a card, then discard a card." flexiblewidth="1" fontsize="18"/>
        --                     <text text="txt" color="0,0,0,0" fontsize="32"/>
        --                 </hlayout>
        --             <divider/>
        --             <hlayout spacing="2" flexibleheight="1.2">
        --                     <text text="{requiresHealth_30}" flexiblewidth="1" fontsize="32"/>
        --                     <vlayout flexiblewidth="0.2" spacing="-115" forceheight="true">
        --                         <text text="{guild}"  fontsize="32" alignment="right"/>
        --                         <text text="{guild}"  fontsize="32"/>
        --                     </vlayout>
        --                     <text text="{gold_1}" flexiblewidth="1" fontsize="32"/>
        --                     <text text="txt" color="0,0,0,0" fontsize="42"/>
        --                 </hlayout>
        --         </vlayout>]]
    })
    --
    return createMagicArmorDef({
        id = "alchemist_spectrum_spectacles",
        name = "Spectrum Spectacles",
        acquireCost = 0,
        cardTypeLabel = "Magic Armor",
        types = { magicArmorType, noStealType, alchemistType},
        factions = {},
        layout = cardLayout,
        playLocation = castPloc,
            abilities = {     
                createAbility({
                    id = "impMain",
                    trigger = autoTrigger,
                    tags = {allyTag},
                    allyFactions = { imperialFaction, imperialFaction },
                    check = minHealthCurrent(30),
                    effect = gainHealthEffect(2)
                }),
                createAbility({
                    id = "necrosMain",
                    trigger = autoTrigger,
                    tags = {allyTag},
                    allyFactions = {necrosFaction,necrosFaction},
                    check = minHealthCurrent(30),
                    effect = gainCombatEffect(2)
                }),
                createAbility({
                    id = "wildMain",
                    trigger = uiTrigger,
                    tags = {allyTag},
                    allyFactions = {wildFaction,wildFaction},
                    check = minHealthCurrent(30),
                    effect = drawCardsEffect(1).seq(pushTargetedEffect({
                                                desc = "Discard a card.",
                                                min = 1,
                                                max = 1,
                                                validTargets = selectLoc(loc(currentPid, handPloc)),
                                                targetEffect = discardTarget(),
                                                }))                    
                }),
                 createAbility({
                    id = "guildMain",
                    trigger = autoTrigger,
                    tags = {allyTag},
                    allyFactions = {guildFaction,guildFaction},
                    check = minHealthCurrent(30),
                    effect = gainGoldEffect(1)
                }),
            }
    })
end

--=========================================
function barbarian_disorienting_headbutt_carddef()
    local cardLayout = createLayout({
        name = "Disorienting Headbutt",
        art = "art/classes/barbarian/disorienting_headbutt",
        frame = "frames/barbarian_frames/barbarian_skill_cardframe",
        acquireCost = 0,
        cardTypeLabel = "Action",
        types = { actionType, barbarianType, currencyType, coinType},
        factions = {},
        layout = cardLayout,
        playLocation = castPloc,
        xmlText = [[<vlayout forceheight="false" spacing="6">
                        <hlayout spacing="10">
                        <icon text="{combat_1}" fontsize="50"/>
                        </hlayout>
                        <hlayout spacing="10">
                        <text text="If you're Berserk, opponent discards 1 and the next card they acquire this turn costs 1 {gold} more." fontsize="22"/>
                        </hlayout>
                    </vlayout>]]
    })
    local isBerserk = hasPlayerSlot(currentPid, berserkSlotKey)
    --
    return createActionDef({
        id = "disorienting_headbutt",
        name = "Disorienting Headbutt",
        acquireCost = 0,
        layout = cardLayout,
        types = { actionType, barbarianType, currencyType, coinType},
        factions = {},
        abilities = {
                createAbility({
                    id = "dhbSlot",
                    trigger = autoTrigger,
                    check = isBerserk.invert(),
                    effect = gainCombatEffect(1).seq(addSlotToPlayerEffect(currentPid, createPlayerSlot({ key = "notBerserkSlot", expiry = { endOfTurnExpiry } })))
                }),
                createAbility({
                    id = "dhbMain",
                    trigger = autoTrigger,
                    check = isBerserk,
                    effect = gainCombatEffect(1).seq(oppDiscardEffect(1)).seq(createCardEffect(disorientingHeadbuttBuff(), oppBuff()))
                }),
                createAbility({
                    id = "dhbBerserkPostPlay",
                    trigger = onPlayTrigger,
                    effect = ifElseEffect(hasPlayerSlot(currentPid, "notBerserkSlot").And(isBerserk),
                                            drawCardsEffect(100),
                                            nullEffect()) 
                })
        }
    })
end

function disorientingHeadbuttBuff()
    local theftCards = selectLoc(loc(oppPid, discardPloc)).where(getCardCost().gte(1)).take(100)
    local acquirableCards = selectLoc(centerRowLoc).union(selectLoc(fireGemsLoc)).union(theftCards).take(100)
    return createGlobalBuff({
        id="disorienting_headbutt_buff",
        name="Disorienting Headbutt",
        abilities = {
            createAbility({
                id = "disorienting_headbutt_buff",
                triggerPriority = 10,
                trigger = startOfTurnTrigger,
                effect = addSlotToTarget(createCostChangeSlot(-1, { endOfTurnExpiry })).apply(acquirableCards)
            }),
            createAbility({
                id = "disorienting_headbutt_buy",
                triggerPriority = 10,
                trigger = onAcquireGlobalTrigger,
                effect = addSlotToTarget(createCostChangeSlot(1, { endOfTurnExpiry })).apply(acquirableCards).seq(sacrificeSelf())
            }),
            createAbility({
                id = "disorienting_headbutt_cleanup",
                triggerPriority = 10,
                trigger = endOfTurnTrigger,
                effect = sacrificeSelf()
            }),
        },
        buffDetails = createBuffDetails({
            name = "Disorienting Headbutt",
            art = "art/classes/barbarian/disorienting_headbutt",
            text = "If you're Berserk, opponent discards 1 and the next card they acquire this turn costs +1 gold."
        })
    })
    end