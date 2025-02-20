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
                        --{ qty = 1, card = wizard_treasure_map_carddef() },
                        --{ qty = 1, card = influence_carddef() },
                        --{ qty = 1, card = elven_curse_carddef() }
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
                    },
                    deck = {
                    },
                    hand = {
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
                meta.minLevel = 0
                meta.maxLevel = 0
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
                            <tmpro text="{gold_1}   {combat_1}" fontsize="52"/>
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
                effect = gainCombatEffect(1).seq(gainGoldEffect(1))
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
function ranger_parrot_carddef()
    local cardLayout = createLayout({
        name = "Parrot",
        art = "art/treasures/t_parrot",
        frame = "frames/Ranger_CardFrame",
        cardTypeLabel = "Champion",
        isGuard = false,
        health = 1,
        types = { championType, rangerType, reserveType, noKillType,  parrotType},
        xmlText = [[<vlayout>
                    <hlayout flexibleheight="1.8">
                    <box flexiblewidth="1">
                    <tmpro text="{expend}" fontsize="42"/>
                    </box>
                    <vlayout flexiblewidth="7">
                    <box flexibleheight="0.5">
                    <tmpro text="Reserve  1" fontsize="18" />
                    </box>
                    <box flexibleheight="1">
                    <tmpro text="{gold_2}  {combat_1}" fontsize="50" />
                    </box>
                    </vlayout>
                    </hlayout>
                    <divider/>
                    <hlayout flexibleheight="1">
                    <box flexiblewidth="7">
                    <tmpro text="When this card enters your discard pile (except end of turn) draw a card." fontsize="16" />
                    </box>
                    </hlayout>
                    </vlayout>
                    ]]
    })
    return createChampionDef({
        id = "ranger_parrot",
        name = "Parrot",
        acquireCost = 0,
        health = 1,
        isGuard = false,
        layout = cardLayout,
        factions = {},
        types = { championType, rangerType, reserveType, noKillType, parrotType},
        abilities = {
            createAbility({
                id = "ranger_parrot",
                trigger = autoTrigger,
                activations = multipleActivations,
                cost = expendCost,
                effect = gainGoldEffect(2).seq(gainCombatEffect(1))
            }),
            createAbility({
                id = "ranger_parrot_discarded",
                trigger = onDiscardTrigger,
                activations = multipleActivations,
                effect = drawCardsEffect(1)
            }),
            createAbility({
                id = "ranger_parrot_killed",
                trigger = onLeavePlayTrigger,
                activations = multipleActivations,
                effect = createCardEffect(parrotDrawBuff(), oppBuff()).seq(simpleMessageEffect("Drawing a card next turn."))
            })
        }
    })
end   

function parrotDrawBuff()
    return createGlobalBuff({
        id="ranger_parrot_stunned",
        name="Parrot Draw",
        abilities = {
            createAbility({
                id = "parrot_draw",
                triggerPriority = 10,
                trigger = startOfTurnTrigger,
                cost = sacrificeSelfCost,
                effect = drawCardsEffect(1)
            }),
        },
        buffDetails = createBuffDetails({
            name = "Parrot",
            art = "art/treasures/t_parrot",
            text = "Draw a card."
        })
    })
    end
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
                                                    art = "art/t_the_rot",
                                                    text = "Scrap a card",
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
                                                    art = "art/t_elven_gift",
                                                    text = "Draw a card and then discard a card.",
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
                check = hasPlayerSlot(currentPid, berserkSlotKey).invert(),
                effect = pushTargetedEffect({
                                desc="Acquire a card for free.",
                                min=0,
                                max=1,
                                validTargets = selectLoc(centerRowLoc).union(selectLoc(fireGemsLoc)).where(isCardAcquirable().And(getCardCost().lte(2))),
                                targetEffect = acquireForFreeTarget(),
                            }),
            }),
            createAbility({
                id = "barbarian_plunder_rage",
                trigger = autoTrigger,
                activations = sigleActivations,
                cost = noCost,
                check = hasPlayerSlot(currentPid, berserkSlotKey),
                effect = pushTargetedEffect({
                    desc="Acquire a card for free.",
                    min=0,
                    max=1,
                    validTargets = selectLoc(centerRowLoc).union(selectLoc(fireGemsLoc)).where(isCardAcquirable().And(getCardCost().lte(3))),
                    targetEffect = acquireForFreeTarget(),
                }),
            }),
        }
    })
end
--=========================================