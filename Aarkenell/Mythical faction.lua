require 'herorealms'
require 'decks'
require 'stdlib'
require 'timeoutai'
require 'hardai_2'
require 'aggressiveai'

--[[Mythic Mercs (new 20 card module for market deck
Includes S&R mini-expansion 4 cards plus Parsons the Insider]]

function startOfGameBuffDef()
    return createGlobalBuff({
        id="startOfGameBuff",
        name = "Start of Game Story",
        abilities = {
            createAbility({
                id="SoG_effect",
                trigger = startOfGameTrigger,
                effect = waitForClickEffect("Welcome to the Mythic Mercenaries mod.", "")
		.seq(waitForClickEffect("As Player 1, you may now choose to add the S&R mini-expansion.", ""))
			})
        }   
	})
end

local function P1_chooseTheCardsBuff()
    return cardChoiceSelectorEffect({
        id = "choose_game_options",
        name = "Choose one",
        trigger = startOfTurnTrigger,

        upperTitle  = "Learn what's new in this mod. Or just get playing.",
        lowerTitle  = "",
 
 effectFirst= storyTellEffectWithPortrait("cristov_s_recruits", "This mod introduces 20 new cards to the Market Deck, comprised of 13 new cards - 7 Champions and 6 Actions.")
 .seq(storyTellEffectWithPortrait("cristov_s_recruits", "All of these cards are factionless. Some have the ability to choose a faction. Others come with different, abilities."))
 .seq(storyTellEffectWithPortrait("cristov_s_recruits", "As mercenaries, many of these champions will require payment each turn if you want to benefit from the full extent of their abilities."))
 .seq(leftStoryTellEffectWithPortrait("ambushers", "As Player 1, you also have the option to play with the Sparks & Rec mini-expansion. This adds another 5 custom champions to the market deck."))
 .seq(leftStoryTellEffectWithPortrait("ambushers", "You can make that choice now."))
 .seq(pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = nullEffect(),
                                            layout = layoutCard(
                                                {
                                                    title = "Mythic Mercs",
                                                    art = "icons/thief_sleight_of_hand",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Play with
Mythic Mercs only." fontsize="24" />
            </box>
        </vlayout>
    </hlayout>

    <hlayout flexibleheight="1">

        <box flexiblewidth="7">
            <tmpro text="Adds 20 cards to the Market Deck." fontsize="16" fontstyle="italic" />
        </box>
    </hlayout>
</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },
                                        {
                                            effect = createCardEffect(mythic_mercs_ee_parsons_carddef(), tradeDeckLoc)
													.seq(createCardEffect(mythic_mercs_ee_scrapforks_carddef(), tradeDeckLoc))
													.seq(createCardEffect(mythic_mercs_ee_dblducks_carddef(), tradeDeckLoc))
													.seq(createCardEffect(mythic_mercs_ee_stigmalingpa_carddef(), tradeDeckLoc))
													.seq(createCardEffect(mythic_mercs_ee_agent_th_carddef(), tradeDeckLoc))
													.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4)))),
													
                                            layout = layoutCard(
                                                {
                                                    title = "Add S&R crew",
                                                    art = "art/T_All_Heroes",
                                                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Also add the Sparks and Rec mini-expansion." fontsize="24" />
            </box>
        </vlayout>
    </hlayout>

    <hlayout flexibleheight="1">

        <box flexiblewidth="7">
            <tmpro text="Adds 5 more champions
to the Market Deck." fontsize="16" fontstyle="italic" />
        </box>
    </hlayout>
</vlayout>
													]]
                                                }
                                            ),
                                                                                    }
                                    }
                                }
                        )
		),
 
 effectSecond = pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = nullEffect(),
                                            layout = layoutCard(
                                                {
                                                    title = "Mythic Mercs",
                                                    art = "icons/thief_sleight_of_hand",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Play with
Mythic Mercs only." fontsize="24" />
            </box>
        </vlayout>
    </hlayout>

    <hlayout flexibleheight="1">

        <box flexiblewidth="7">
            <tmpro text="Adds 20 cards to the Market Deck." fontsize="16" fontstyle="italic" />
        </box>
    </hlayout>
</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },
                                        {
                                            effect = createCardEffect(mythic_mercs_ee_parsons_carddef(), tradeDeckLoc)
													.seq(createCardEffect(mythic_mercs_ee_scrapforks_carddef(), tradeDeckLoc))
													.seq(createCardEffect(mythic_mercs_ee_dblducks_carddef(), tradeDeckLoc))
													.seq(createCardEffect(mythic_mercs_ee_stigmalingpa_carddef(), tradeDeckLoc))
													.seq(createCardEffect(mythic_mercs_ee_agent_th_carddef(), tradeDeckLoc))
													.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4)))),
													
                                            layout = layoutCard(
                                                {
                                                    title = "Add S&R crew",
                                                    art = "art/T_All_Heroes",
                                                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Also add the Sparks and Rec mini-expansion." fontsize="24" />
            </box>
        </vlayout>
    </hlayout>

    <hlayout flexibleheight="1">

        <box flexiblewidth="7">
            <tmpro text="Adds 5 more champions
to the Market Deck." fontsize="16" fontstyle="italic" />
        </box>
    </hlayout>
</vlayout>
													]]
                                                }
                                            ),
                                                                                    }
                                    }
                                }
                        )
		,

        layoutFirst = createLayout({
            name = "Learn about the mod",
            art = "art/treasures/T_Magic_Scroll_Souveraine",
            xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Learn how this mod changes the game." fontsize="26"/>
</hlayout>
</vlayout>			
			]]
			}),

        layoutSecond = createLayout({
            name = "Pick Packs & Play",
            art = "icons/thief_sleight_of_hand",
            xmlText=[[
			<vlayout>
<hlayout flexiblewidth="1">
<text text="Choose which expansion sets to use and get playing." fontsize="26"/>
</hlayout>
</vlayout>
			]] }) ,

        turn = 1
    })
end

local function P2_chooseInfoBuff()
    return cardChoiceSelectorEffect({
        id = "choose_game_options",
        name = "Choose one",
        trigger = startOfTurnTrigger,

        upperTitle  = "Learn what's new in this mod. Or just get playing.",
        lowerTitle  = "",
 
 effectFirst= storyTellEffectWithPortrait("cristov_s_recruits", "This mod introduces 20 new cards to the Market Deck, comprised of 13 new cards - 7 Champions and 6 Actions.")
 .seq(storyTellEffectWithPortrait("cristov_s_recruits", "All of these cards are factionless. Some have the ability to choose a faction. Others come with different, abilities."))
 .seq(storyTellEffectWithPortrait("cristov_s_recruits", "As mercenaries, many of these champions will require payment each turn if you want to benefit from the full extent of their abilities."))
 .seq(leftStoryTellEffectWithPortrait("ambushers", "Player 1 also has the option to decide to add in the Sparks & Rec mini-expansion. This adds another 5 custom champions to the market deck."))
 .seq(leftStoryTellEffectWithPortrait("ambushers", "Now, let's get playing.")),
 
 effectSecond = nullEffect(),

        layoutFirst = createLayout({
            name = "Learn about the mod",
            art = "art/treasures/T_Magic_Scroll_Souveraine",
            xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Learn how this mod changes the game." fontsize="26"/>
</hlayout>
</vlayout>			
			]]
			}),

        layoutSecond = createLayout({
            name = "Play",
            art = "icons/thief_sleight_of_hand",
            xmlText=[[
			<vlayout>
<hlayout flexiblewidth="1">
<text text="Get playing." fontsize="26"/>
</hlayout>
</vlayout>
			]] }) ,

        turn = 1
    })
end


function winGameBuffDef()
    return createGlobalBuff({
        id="endOfGameBuff",
        name = "End of Game Story",
        abilities = {
            createAbility({
                id="EoG_effect",
                trigger = endOfGameTrigger,
                effect = waitForClickEffect("Thanks for playing the Mythic Mercenaries mod.", "")
						.seq(waitForClickEffect("Join the Realms Rising server on Discord to share feedback.", ""))
        .seq(waitForClickEffect("For latest news on this and other Lua mods, as well as the latest Hero Realms strats and chats, listen to the Sparks and Recreations podcast.", ""))
				.seq(waitForClickEffect("If you enjoyed this game, be sure to 'Favourite' it so you can play it again. Find out how at: https://www.realmsrising.com/lua/hero-realms-lua-play-at-home-edition/", ""))
            
})
        },
    })
end

function loseGameBuffDef()
    return createGlobalBuff({
        id="LostBuff",
        name = "Lost Story",
        abilities = {
            createAbility({
                id="EoG_lost_effect",
                trigger = endOfGameTrigger,
				effect = waitForClickEffect("Thanks for playing the Mythic Mercenaries mod.", "")
				.seq(waitForClickEffect("Join the Realms Rising server on Discord to share feedback.", ""))
        .seq(waitForClickEffect("For latest news on this and other Lua mods, as well as the latest Hero Realms strats and chats, listen to the Sparks and Recreations podcast.", ""))
				.seq(waitForClickEffect("If you enjoyed this game, be sure to 'Favourite' it so you can play it again. Find out how at: https://www.realmsrising.com/lua/hero-realms-lua-play-at-home-edition/", ""))
           
            })
        },
    })
end

function setupGame(g)
	registerCards(g, {
        mythic_exp_fairy_base_carddef(),
		mythic_exp_fairy_gold_carddef(),
		mythic_exp_fairy_combat_carddef(),
		mythic_exp_fairy_health_carddef(),
	
		mythic_exp_fairy_null_carddef(),
		mythic_exp_trickery_carddef(),
		mythic_exp_fake_ruby_carddef(),
		mythic_exp_hobgoblin_carddef(),
		mythic_exp_banshees_wail_carddef(),
		mythic_exp_green_man_carddef(),
		mythic_exp_feeding_frenzy_carddef(),
		mythic_exp_feeding_frenzy2_carddef(),
		mythic_exp_feeding_frenzy3_carddef(),
		mythic_exp_feeding_frenzy4_carddef(),
		mythic_exp_feeding_frenzy5_carddef(),
		mythic_exp_feeding_frenzy6_carddef(),
		mythic_exp_feeding_frenzy7_carddef(),
		mythic_exp_feeding_frenzy8_carddef(),
		mythic_exp_feeding_frenzy9_carddef(),
		mythic_exp_feeding_frenzy_full_carddef(),
		mythic_exp_mysterious_merc_carddef(),
		mythic_exp_werewolf_merc2_carddef(),
		mythic_exp_stone_skin_carddef(),
		mythic_exp_wyvern_carddef(),
		mythic_exp_shapeshift_carddef(),
		mythic_exp_troll_merc_carddef(),
		mythic_exp_basilisks_gaze_carddef(),
		mythic_exp_golem_for_hire_carddef(),
		mythic_mercs_ee_scrapforks_carddef(),
		mythic_mercs_ee_dblducks_carddef(),
		mythic_mercs_ee_parsons_carddef(),
		mythic_mercs_ee_stigmalingpa_carddef(),
		mythic_mercs_ee_agent_th_carddef(),
		cat_familiar_token_carddef(),
		kit_cat_token_carddef(),
		chunky_cat_token_carddef(),
		big_bad_kitty_token_carddef(),
		surprise_dragon_token_carddef()
	})

    standardSetup(g, {
        description = "Mythic creatures - 20 extra market cards. (13 unique new cards.) Created by Aarkenell.",
        playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(),  createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } }, 
		centerRow = {}, 
		tradeDeckExceptions = {
            -- here we set which cards populate market deck
            { qty=3, cardId="fairy_base" },
            { qty=3, cardId="trickery" },
			{ qty=2, cardId="hobgoblin" },
			{ qty=2, cardId="banshee's_wail" },
			{ qty=2, cardId="green_man" },
			{ qty=1, cardId="feeding_frenzy" },
			{ qty=1, cardId="mysterious_merc" },
			{ qty=1, cardId="stone_skin" },
			{ qty=1, cardId="wyvern" },
			{ qty=1, cardId="shapeshift" },
			{ qty=1, cardId="troll_merc" },
			{ qty=0, cardId="basilisks_gaze" },
			{ qty=1, cardId="golem_for_hire" }
        },
        players = {
            {
                id = plid1,
				init = {
                    fromEnv = plid1
                },
                   cards = {
                    buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
                        fatigueCount(40, 1, "FatigueP1"),
						startOfGameBuffDef(),
						winGameBuffDef(),
						P1_chooseTheCardsBuff()
                    }
                }
            }, 
            {

                id = plid2,
                isAi = false,
				init = {
                    fromEnv = plid2
                },
                cards = {
					buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
						fatigueCount(40, 1, "FatigueP2"),
						startOfGameBuffDef(),
						loseGameBuffDef(),
						P2_chooseInfoBuff()
					}
                }
            },          
        }
    })
end

--=======================================================================================================

function mythic_exp_fairy_base_carddef()
    return createChampionDef(
        {
            id = "fairy_base",
            name = "Fairy",
			types = {championType},
            acquireCost = 1,
            health = 2,
            isGuard = false,
            abilities = {
                
				createAbility(
                    {
                        id = "fairy_base_switch",
                        trigger = startOfTurnTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = randomEffect({
					valueItem(1, transformTarget("fairy_gold").apply(selectSource())),
					valueItem(1, transformTarget("fairy_combat").apply(selectSource())),
					valueItem(1, transformTarget("fairy_health").apply(selectSource())),
				
					valueItem(1, transformTarget("fairy_null").apply(selectSource()))
})
						
						
						
                    }
                ),
				createAbility(
                    {
                        id = "fairy_base_switch",
                        trigger = onPlayTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = randomEffect({
					valueItem(1, transformTarget("fairy_gold").apply(selectSource())),
					valueItem(1, transformTarget("fairy_combat").apply(selectSource())),
					valueItem(1, transformTarget("fairy_health").apply(selectSource())),
					
					valueItem(1, transformTarget("fairy_null").apply(selectSource()))
})
						
						
						
                    }
                )
				
            },
            layout = createLayout(
                {
                    name = "Fairy",
                    art = "art/T_Fairy",
                    frame = "frames/Treasure_CardFrame",
					cost = 1,
                    xmlText=[[
					<vlayout>

<box flexibleheight="2">
        <tmpro text="When played, and at the start of your turn, randomly select:
" fontsize="18"/>
    </box>

    <hlayout flexibleheight="2">
        <box flexiblewidth="7">
             <tmpro text="{gold_2}&lt;size=60%&gt; or &lt;/size&gt;{combat_3}&lt;size=60%&gt; or &lt;/size&gt;{health_4}
&lt;size=60%&gt; or No Effect" fontsize="46" />
        </box>
    </hlayout>



</vlayout>
					]],
                    health = 2,
                    isGuard = false
                }
            )
        }
    )
end

function mythic_exp_fairy_gold_carddef()
    return createChampionDef(
        {
            id = "fairy_gold",
            name = "Fairy",
			types = {championType},
            acquireCost = 1,
            health = 2,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "fairy_gold_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainGoldEffect(2)
						
                    }
                ),
				createAbility(
                    {
                        id = "fairy_gold_switch",
                        trigger = endOfTurnTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = transformTarget("fairy_base").apply(selectSource())
						
                    }
                )
				
            },
            layout = createLayout(
                {
                    name = "Fairy",
                    art = "art/T_Fairy",
                    frame = "frames/Treasure_CardFrame",
					cost = 1,
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="{gold_2}" fontsize="60" flexiblewidth="12" />
       </hlayout>

<divider/>
<tmpro text="At the start of your turn, randomly change ability." fontsize="20" flexibleheight="1" />
</vlayout>
					]],
                    health = 2,
                    isGuard = false
                }
            )
        }
    )
end

function mythic_exp_fairy_combat_carddef()
    return createChampionDef(
        {
            id = "fairy_combat",
            name = "Fairy",
			types = {championType},
            acquireCost = 1,
            health = 2,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "fairy_combat_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(3)
						
                    }
                ),
				createAbility(
                    {
                        id = "fairy_combat_switch",
                        trigger = endOfTurnTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = transformTarget("fairy_base").apply(selectSource())
						
                    }
                )
				
            },
            layout = createLayout(
                {
                    name = "Fairy",
                    art = "art/T_Fairy",
                    frame = "frames/Treasure_CardFrame",
					cost = 1,
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="{combat_3}" fontsize="60" flexiblewidth="12" />
       </hlayout>

<divider/>
<tmpro text="At the start of your turn, randomly change ability." fontsize="20" flexibleheight="1" />
</vlayout>
					]],
                    health = 2,
                    isGuard = false
                }
            )
        }
    )
end

function mythic_exp_fairy_health_carddef()
    return createChampionDef(
        {
            id = "fairy_health",
            name = "Fairy",
			types = {championType},
            acquireCost = 1,
            health = 2,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "fairy_health_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainHealthEffect(4)
						
                    }
                ),
				createAbility(
                    {
                        id = "fairy_health_switch",
                        trigger = endOfTurnTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = transformTarget("fairy_base").apply(selectSource())
						
                    }
                )
				
            },
            layout = createLayout(
                {
                    name = "Fairy",
                    art = "art/T_Fairy",
                    frame = "frames/Treasure_CardFrame",
					cost = 1,
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="{health_4}" fontsize="60" flexiblewidth="12" />
       </hlayout>

<divider/>
<tmpro text="At the start of your turn, randomly change ability." fontsize="20" flexibleheight="1" />
</vlayout>
					]],
                    health = 2,
                    isGuard = false
                }
            )
        }
    )
end

function mythic_exp_fairy_null_carddef()
    return createChampionDef(
        {
            id = "fairy_null",
            name = "Fairy",
			types = {championType},
            acquireCost = 1,
            health = 2,
            isGuard = false,
            abilities = {
				createAbility(
                    {
                        id = "fairy_null_switch",
                        trigger = endOfTurnTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = transformTarget("fairy_base").apply(selectSource())
						
                    }
                )
				
            },
            layout = createLayout(
                {
                    name = "Fairy",
                    art = "art/T_Fairy",
                    frame = "frames/Treasure_CardFrame",
					cost = 1,
                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
            <tmpro text="Come back later.
I'm on lunch."  fontstyle="italic" fontsize="20" flexiblewidth="12" />
       </hlayout>

<divider/>
<tmpro text="At the start of your turn, randomly change ability." fontsize="20" flexibleheight="1" />
</vlayout>
					]],
                    health = 2,
                    isGuard = false
                }
            )
        }
    )
end

function mythic_exp_trickery_carddef()

-- You need to add local buff, and then reference it down in createAbility effect (see below).
    local trickeryBuff = createGlobalBuff({
        id="trickery_buff",
        name = "Trickery",
        abilities = {
            createAbility({
                id="trickery_effect",
                trigger = startOfTurnTrigger,
                effect = gainGoldEffect(-1).seq(sacrificeSelf())
            })
        },
		buffDetails = createBuffDetails({
					name = "Trickery",
                    art = "art/T_Feisty_Orcling",
					text = "-1 gold this turn."
							})
    })

    return createDef(
        {
            id = "trickery",
            name = "Trickery",
			types = {actionType},
			cardTypeLabel = "Action",
			playLocation = castPloc,
            acquireCost = 2,
            abilities = {
                createAbility(
                    {
                        id = "trickery_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
						-- see effect here - createCardEffect(trickeryBuff...
                        effect = gainCombatEffect(3).seq(createCardEffect(trickeryBuff, loc(oppPid, buffsPloc)))
						
                    }
                ),
				createAbility(
                    {
                        id = "trickery_sac",
                        trigger = uiTrigger,
                        cost = sacrificeSelfCost,
						promptType = showPrompt,
						layout = createLayout({
							name = "Trickery",
							art = "art/T_Feisty_Orcling",
							frame = "frames/Treasure_CardFrame",
							xmlText=[[
							<vlayout>
        <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="36"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Add a Fake Ruby to your opponent's discard pile." fontsize="20" />
        </box>
    </hlayout>
</vlayout>
		]]
							}),
                        activations = singleActivations,
                        effect = createCardEffect(mythic_exp_fake_ruby_carddef(), loc(oppPid, discardPloc))
						
                    }
                )
            },
			
            layout = createLayout(
                {
                    name = "Trickery",
                    art = "art/T_Feisty_Orcling",
                    frame = "frames/Treasure_CardFrame",
					cost = 2,
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="{combat_3}" fontsize="30"/>
    </box>
    <hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <tmpro text="Opponent gets -{gold_1} next turn." fontsize="20" />
        </box>
    </hlayout>
    <divider/>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="36"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Add a Fake Ruby to your opponent's discard pile." fontsize="20" />
        </box>
    </hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

function mythic_exp_fake_ruby_carddef()
    return createDef(
        {
            id = "fake_ruby",
            name = "Fake Ruby",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "fake_ruby_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = nullEffect()
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Fake Ruby",
                    art = "art/T_ruby",
                    frame = "frames/Treasure_CardFrame",
					cost = 0,
                    xmlText=[[
<vlayout>
    <box flexibleheight="10">
        <tmpro text="I'm sorry.
This is worthless." fontstyle="italic" fontsize="20"/>
    </box>
    <hlayout flexibleheight="1">
    </hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

function mythic_exp_hobgoblin_carddef()
    return createChampionDef(
        {
            id = "hobgoblin",
            name = "Hobgoblin",
			types = {championType},
            acquireCost = 2,
            health = 2,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "hobgoblin_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = pushChoiceEffect({
							choices = {
								{
                                effect = gainGoldEffect(2),
                                layout = createLayout({
									name = "Hobgoblin",
									art = "art/T_Goblin",
                                    frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{gold_2}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            },
							{
                                effect = gainGoldEffect(1).seq(pushChoiceEffect({
                        choices = {
                            {
                                effect = addSlotToTarget(createFactionsSlot({ imperialFaction }, { endOfTurnExpiry, leavesPlayExpiry })).apply(selectSource()),
                                layout = createLayout({
									name = "Hobgoblin",
									art = "art/T_Goblin",
                                    frame = "frames/Imperial_Champion_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{imperial}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            },
                            {
                                effect = addSlotToTarget(createFactionsSlot({ wildFaction }, { endOfTurnExpiry, leavesPlayExpiry })).apply(selectSource()),
                                layout = createLayout({
									name = "Hobgoblin",
									art = "art/T_Goblin",
                                    frame = "frames/Wild_Champion_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{wild}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            },
                            {
                                effect = addSlotToTarget(createFactionsSlot({ guildFaction }, { endOfTurnExpiry, leavesPlayExpiry })).apply(selectSource()),
                                layout = createLayout({
									name = "Hobgoblin",
									art = "art/T_Goblin",
                                    frame = "frames/Guild_Champion_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{guild}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            },
                            {
                                effect = addSlotToTarget(createFactionsSlot({ necrosFaction }, { endOfTurnExpiry, leavesPlayExpiry })).apply(selectSource()),
                                layout = createLayout({
									name = "Hobgoblin",
									art = "art/T_Goblin",
                                    frame = "frames/Necros_Champion_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{necro}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            }
                        }
                    })),
                                layout = createLayout({
									name = "Hobgoblin",
									art = "art/T_Goblin",
                                    frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
<vlayout  forceheight="true">
<tmpro text="{gold_1}" fontsize="40" />
 <tmpro text="Choose a faction for this card to have this turn." fontsize="20" />
</vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            }
									}
												})
						
                    }
                )
				
            },
            layout = createLayout(
                {
                    name = "Hobgoblin",
                    art = "art/T_Goblin",
                    frame = "frames/Treasure_CardFrame",
					cost = 2,
                    xmlText=[[
					
<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="2">
            <tmpro text="{expend}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="1">
                <tmpro text="{gold_2}" fontsize="36" />
            </box>
            <box flexibleheight="2">
                <tmpro text="or
{gold_1} and choose a faction for this card to have this turn." fontsize="20" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
					]],
                    health = 2,
                    isGuard = false
                }
            )
        }
    )
end


function mythic_exp_banshees_wail_carddef()
    return createDef(
        {
            id = "banshee's_wail",
            name = "Banshee's Wail",
			types = {actionType},
			cardTypeLabel = "Action",
			playLocation = castPloc,
            acquireCost = 3,
            abilities = {
                createAbility(
                    {
                        id = "banshee's_wail_main",
                        trigger = autoTrigger,
						playAllType = noPlayPlayType,
                        cost = noCost,
                        activations = singleActivations,
                        effect = gainCombatEffect(4).seq(moveTarget(revealLoc).apply(selectLoc(loc(oppPid, deckPloc)).take(3)).seq(noUndoEffect())		
								.seq(promptSplit({
									selector = selectLoc(revealLoc),
									take = const(3), -- number of cards to take for split
									sort = const(1), -- number of cards to be sorted for ef2
									ef1 =moveTarget(loc(oppPid, deckPloc)).seq(shuffleEffect(loc(oppPid, deckPloc))), -- effect to be applied to cards left
									ef2 = moveTarget(loc(oppPid, deckPloc)), -- effect to be applied to sorted cards
									header = "Banshee's Wail", -- prompt header
									description = "Return 2 cards to opponent's deck. Shuffle the deck. Place the 3rd card on top of their deck.",
									rightPileDesc = "Text explaining right pile rules, e.g. ordering",
									pile1Name = "Return 2 cards before shuffle.",
									pile2Name = "Place 1 on top of deck after shuffle.",
									eff1Tags = {  },
									eff2Tags = {  }
								})))
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Banshee's Wail",
                    art = "art/T_Banshee",
                    frame = "frames/Treasure_CardFrame",
					cost = 3,
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="{combat_4}" fontsize="42"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="Look at the top 3 cards of opponent's deck (or as many remain). Put 2 back and shuffle their deck. Put the third card on top of their deck." fontsize="18" />
    </box>
</vlayout>
					]],

                }
            )
        }
    )
end

function mythic_exp_green_man_carddef()
    return createChampionDef(
        {
            id = "green_man",
            name = "Green Man",
			types = {championType},
            acquireCost = 3,
            health = 3,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "green_man_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
						promptType = showPrompt,
						layout = createLayout(
                {
                    name = "Green Man",
                    art = "art/T_Orc",
                    frame = "frames/Treasure_CardFrame",
					cost = 3,
                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="2">
            <tmpro text="{expend}" fontsize="36" flexiblewidth="2"/>
<vlayout>
            <icon text="{combat_3}" fontsize="36" flexibleheight="1" flexiblewidth="9"/>
 <tmpro text="Draw 1 then put 1 card on either the top or bottom of your deck." fontsize="20" flexibleheight="1" flexiblewidth="1"/>

</vlayout>

</hlayout>
</vlayout>
					]],
                    health = 3,
                    isGuard = false
                }
            ),
                        effect = gainCombatEffect(3).seq(drawCardsEffect(1)).seq(
								pushChoiceEffect({
									choices = {
                            {
                                effect = pushTargetedEffect({
												  desc="Put a card on the top of your deck.",
												  min=1,
												  max=1,
												  validTargets= selectLoc(loc(currentPid, handPloc)),
												  targetEffect= moveToTopDeckTarget(true),
												  tags = {}
												}),
                                layout = createLayout({
									name = "Green Man",
									art = "art/T_Orc",
									frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <tmpro text="Put a card on the top of your deck." fontsize="28" />
                                        </vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            },
							{
                                effect = pushTargetedEffect({
												  desc="Put a card on the bottom of your deck.",
												  min=1,
												  max=1,
												  validTargets= selectLoc(loc(currentPid, handPloc)),
												  targetEffect= moveToBottomDeckTarget(true, 0),
												  tags = {}
												}),
                                layout = createLayout({
									name = "Green Man",
									art = "art/T_Orc",
									frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <tmpro text="Put a card on the bottom of your deck." fontsize="28" />
                                        </vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            }}
												})
						
						)
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Green Man",
                    art = "art/T_Orc",
                    frame = "frames/Treasure_CardFrame",
					cost = 3,
                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="{combat_3}&lt;size=50%&gt;
Draw 1 then put 1 card on either the top or bottom of your deck." fontsize="42" flexiblewidth="12" />
    </hlayout>
</vlayout>
					]],
                    health = 3,
                    isGuard = false
                }
            )
        }
    )
end

function mythic_exp_feeding_frenzy_carddef()
    return createDef(
        {
            id = "feeding_frenzy",
            name = "Feeding Frenzy",
			types = {actionType, nostealType},
			cardTypeLabel = "Action",
			playLocation = castPloc,
            acquireCost = 4,
            abilities = {
                createAbility(
                    {
                        id = "feeding_frenzy_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = gainCombatEffect(1).seq(drawCardsEffect(1)).seq(createCardEffect(mythic_exp_feeding_frenzy2_carddef(), currentDiscardLoc)),
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Feeding Frenzy",
                    art = "art/T_Lesser_Vampire",
                    frame = "frames/Treasure_CardFrame",
					cost = 4,
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="{combat_1}" fontsize="42"/>
    </box>
<box flexibleheight="2.2">
        <tmpro text="Draw a card.
Create a copy of this card in your discard pile." fontsize="20"/>
    </box>
<divider/>
    <box flexibleheight="1">
        <tmpro text="This card and its copies cannot be stolen." fontsize="14" />
    </box>
</vlayout> 
					]],

                }
            )
        }
    )
end

function mythic_exp_feeding_frenzy2_carddef()
    return createDef(
        {
            id = "feeding_frenzy2",
            name = "Feeding Frenzy",
			types = {actionType, nostealType},
			cardTypeLabel = "Action",
			playLocation = castPloc,
            acquireCost = 4,
            abilities = {
                createAbility(
                    {
                        id = "feeding_frenzy_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = gainCombatEffect(1).seq(drawCardsEffect(1)).seq(createCardEffect(mythic_exp_feeding_frenzy3_carddef(), currentDiscardLoc)),
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Feeding Frenzy",
                    art = "art/T_Lesser_Vampire",
                    frame = "frames/Treasure_CardFrame",
					cost = 4,
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="{combat_1}" fontsize="42"/>
    </box>
<box flexibleheight="2.2">
        <tmpro text="Draw a card.
Create a copy of this card in your discard pile." fontsize="20"/>
    </box>
<divider/>
    <box flexibleheight="1">
        <tmpro text="This card and its copies cannot be stolen." fontsize="14" />
    </box>
</vlayout> 
					]],

                }
            )
        }
    )
end

function mythic_exp_feeding_frenzy3_carddef()
    return createDef(
        {
            id = "feeding_frenzy3",
            name = "Feeding Frenzy",
			types = {actionType, nostealType},
			cardTypeLabel = "Action",
			playLocation = castPloc,
            acquireCost = 4,
            abilities = {
                createAbility(
                    {
                        id = "feeding_frenzy_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = gainCombatEffect(1).seq(drawCardsEffect(1)).seq(createCardEffect(mythic_exp_feeding_frenzy4_carddef(), currentDiscardLoc)),
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Feeding Frenzy",
                    art = "art/T_Lesser_Vampire",
                    frame = "frames/Treasure_CardFrame",
					cost = 4,
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="{combat_1}" fontsize="42"/>
    </box>
<box flexibleheight="2.2">
        <tmpro text="Draw a card.
Create a copy of this card in your discard pile." fontsize="20"/>
    </box>
<divider/>
    <box flexibleheight="1">
        <tmpro text="This card and its copies cannot be stolen." fontsize="14" />
    </box>
</vlayout> 
					]],

                }
            )
        }
    )
end

function mythic_exp_feeding_frenzy4_carddef()
    return createDef(
        {
            id = "feeding_frenzy4",
            name = "Feeding Frenzy",
			types = {actionType, nostealType},
			cardTypeLabel = "Action",
			playLocation = castPloc,
            acquireCost = 4,
            abilities = {
                createAbility(
                    {
                        id = "feeding_frenzy_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = gainCombatEffect(1).seq(drawCardsEffect(1)).seq(createCardEffect(mythic_exp_feeding_frenzy5_carddef(), currentDiscardLoc)),
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Feeding Frenzy",
                    art = "art/T_Lesser_Vampire",
                    frame = "frames/Treasure_CardFrame",
					cost = 4,
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="{combat_1}" fontsize="42"/>
    </box>
<box flexibleheight="2.2">
        <tmpro text="Draw a card.
Create a copy of this card in your discard pile." fontsize="20"/>
    </box>
<divider/>
    <box flexibleheight="1">
        <tmpro text="This card and its copies cannot be stolen." fontsize="14" />
    </box>
</vlayout> 
					]],

                }
            )
        }
    )
end

function mythic_exp_feeding_frenzy5_carddef()
    return createDef(
        {
            id = "feeding_frenzy5",
            name = "Feeding Frenzy",
			types = {actionType, nostealType},
			cardTypeLabel = "Action",
			playLocation = castPloc,
            acquireCost = 4,
            abilities = {
                createAbility(
                    {
                        id = "feeding_frenzy_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = gainCombatEffect(1).seq(drawCardsEffect(1)).seq(createCardEffect(mythic_exp_feeding_frenzy6_carddef(), currentDiscardLoc)),
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Feeding Frenzy",
                    art = "art/T_Lesser_Vampire",
                    frame = "frames/Treasure_CardFrame",
					cost = 4,
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="{combat_1}" fontsize="42"/>
    </box>
<box flexibleheight="2.2">
        <tmpro text="Draw a card.
Create a copy of this card in your discard pile." fontsize="20"/>
    </box>
<divider/>
    <box flexibleheight="1">
        <tmpro text="This card and its copies cannot be stolen." fontsize="14" />
    </box>
</vlayout> 
					]],

                }
            )
        }
    )
end

function mythic_exp_feeding_frenzy6_carddef()
    return createDef(
        {
            id = "feeding_frenzy6",
            name = "Feeding Frenzy",
			types = {actionType, nostealType},
			cardTypeLabel = "Action",
			playLocation = castPloc,
            acquireCost = 4,
            abilities = {
                createAbility(
                    {
                        id = "feeding_frenzy_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = gainCombatEffect(1).seq(drawCardsEffect(1)).seq(createCardEffect(mythic_exp_feeding_frenzy7_carddef(), currentDiscardLoc)),
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Feeding Frenzy",
                    art = "art/T_Lesser_Vampire",
                    frame = "frames/Treasure_CardFrame",
					cost = 4,
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="{combat_1}" fontsize="42"/>
    </box>
<box flexibleheight="2.2">
        <tmpro text="Draw a card.
Create a copy of this card in your discard pile." fontsize="20"/>
    </box>
<divider/>
    <box flexibleheight="1">
        <tmpro text="This card and its copies cannot be stolen." fontsize="14" />
    </box>
</vlayout> 
					]],

                }
            )
        }
    )
end

function mythic_exp_feeding_frenzy7_carddef()
    return createDef(
        {
            id = "feeding_frenzy7",
            name = "Feeding Frenzy",
			types = {actionType, nostealType},
			cardTypeLabel = "Action",
			playLocation = castPloc,
            acquireCost = 4,
            abilities = {
                createAbility(
                    {
                        id = "feeding_frenzy_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = gainCombatEffect(1).seq(drawCardsEffect(1)).seq(createCardEffect(mythic_exp_feeding_frenzy8_carddef(), currentDiscardLoc)),
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Feeding Frenzy",
                    art = "art/T_Lesser_Vampire",
                    frame = "frames/Treasure_CardFrame",
					cost = 4,
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="{combat_1}" fontsize="42"/>
    </box>
<box flexibleheight="2.2">
        <tmpro text="Draw a card.
Create a copy of this card in your discard pile." fontsize="20"/>
    </box>
<divider/>
    <box flexibleheight="1">
        <tmpro text="This card and its copies cannot be stolen." fontsize="14" />
    </box>
</vlayout> 
					]],

                }
            )
        }
    )
end

function mythic_exp_feeding_frenzy8_carddef()
    return createDef(
        {
            id = "feeding_frenzy8",
            name = "Feeding Frenzy",
			types = {actionType, nostealType},
			cardTypeLabel = "Action",
			playLocation = castPloc,
            acquireCost = 4,
            abilities = {
                createAbility(
                    {
                        id = "feeding_frenzy_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = gainCombatEffect(1).seq(drawCardsEffect(1)).seq(createCardEffect(mythic_exp_feeding_frenzy9_carddef(), currentDiscardLoc)),
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Feeding Frenzy",
                    art = "art/T_Lesser_Vampire",
                    frame = "frames/Treasure_CardFrame",
					cost = 4,
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="{combat_1}" fontsize="42"/>
    </box>
<box flexibleheight="2.2">
        <tmpro text="Draw a card.
Create a copy of this card in your discard pile." fontsize="20"/>
    </box>
<divider/>
    <box flexibleheight="1">
        <tmpro text="This card and its copies cannot be stolen." fontsize="14" />
    </box>
</vlayout> 
					]],

                }
            )
        }
    )
end

function mythic_exp_feeding_frenzy9_carddef()
    return createDef(
        {
            id = "feeding_frenzy9",
            name = "Feeding Frenzy",
			types = {actionType, nostealType},
			cardTypeLabel = "Action",
			playLocation = castPloc,
            acquireCost = 4,
            abilities = {
                createAbility(
                    {
                        id = "feeding_frenzy_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = gainCombatEffect(1).seq(drawCardsEffect(1)).seq(createCardEffect(mythic_exp_feeding_frenzy_full_carddef(), currentDiscardLoc)),
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Feeding Frenzy",
                    art = "art/T_Lesser_Vampire",
                    frame = "frames/Treasure_CardFrame",
					cost = 4,
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="{combat_1}" fontsize="42"/>
    </box>
<box flexibleheight="2.2">
        <tmpro text="Draw a card.
Create a copy of this card in your discard pile." fontsize="20"/>
    </box>
<divider/>
    <box flexibleheight="1">
        <tmpro text="This card and its copies cannot be stolen." fontsize="14" />
    </box>
</vlayout> 
					]],

                }
            )
        }
    )
end

function mythic_exp_feeding_frenzy_full_carddef()
    return createDef(
        {
            id = "feeding_frenzy_full",
            name = "Surely you've eaten enough?",
			types = {actionType, nostealType},
			cardTypeLabel = "Action",
			playLocation = castPloc,
            acquireCost = 4,
            abilities = {
                createAbility(
                    {
                        id = "feeding_frenzy_full_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = gainCombatEffect(1).seq(drawCardsEffect(1)),
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Surely you've eaten enough?",
                    art = "art/T_Lesser_Vampire",
                    frame = "frames/Treasure_CardFrame",
					cost = 4,
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="{combat_1}" fontsize="42"/>
    </box>
<box flexibleheight="2.2">
        <tmpro text="Draw a card.

&lt;size=80%&gt;You're too full to create more copies." fontstyle="italic" fontsize="20"/>
    </box>
<divider/>
    <box flexibleheight="1">
        <tmpro text="This card and its copies cannot be stolen." fontsize="14" />
    </box>
</vlayout> 
					]],

                }
            )
        }
    )
end

function mythic_exp_mysterious_merc_carddef()
    return createChampionDef(
        {
            id = "mysterious_merc",
            name = "Mysterious Mercenary",
			types = {championType},
            acquireCost = 4,
            health = 4,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "werewolf_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = gainCombatEffect(4).seq(
                    pushChoiceEffect({
                        choices = {
                            {
                                effect = addSlotToTarget(createFactionsSlot({ imperialFaction }, { endOfTurnExpiry, leavesPlayExpiry })).apply(selectSource()),
                                layout = createLayout({
								name = "Mysterious Mercenary",
								art = "art/T_man_at_arms_old",
								frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{imperial}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            },
                            {
                                effect = addSlotToTarget(createFactionsSlot({ wildFaction }, { endOfTurnExpiry, leavesPlayExpiry })).apply(selectSource()),
                                layout = createLayout({
								name = "Mysterious Mercenary",
								art = "art/T_man_at_arms_old",
								frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{wild}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            },
                            {
                                effect = addSlotToTarget(createFactionsSlot({ guildFaction }, { endOfTurnExpiry, leavesPlayExpiry })).apply(selectSource()),
                                layout = createLayout({
								name = "Mysterious Mercenary",
								art = "art/T_man_at_arms_old",
								frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{guild}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            },
                            {
                                effect = addSlotToTarget(createFactionsSlot({ necrosFaction }, { endOfTurnExpiry, leavesPlayExpiry })).apply(selectSource()),
                                layout = createLayout({
								name = "Mysterious Mercenary",
								art = "art/T_man_at_arms_old",
								frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{necro}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            }
                        }
                    })
                ),
                                            layout = createLayout(
                {
					name = "Mysterious Mercenary",
                    art = "art/T_man_at_arms_old",
                    frame = "frames/Treasure_CardFrame",
					cost = 4,
                    xmlText=[[
<vlayout>

    <hlayout flexibleheight="7.7">
         <tmpro text="{expend}" fontsize="36" flexiblewidth="1.5"/>

 <vlayout flexiblewidth="8">
            <tmpro text="{combat_4}" fontsize="46" flexibleheight="1"/>

<tmpro text="Give this card a faction
until next turn." fontsize="20" flexibleheight="1"/>
</vlayout> 

    </hlayout> 
</vlayout>

					]],
                    health = 4,
                    isGuard = false
                }
            ),
                                            tags = {gainCombat2Tag}
                                        },
                                        {
                                            effect = transformTarget("werewolf_merc2").apply(selectSource()).seq(gainGoldEffect(-1).seq(prepareTarget().apply(selectSource()))),
											condition = getPlayerGold(currentPid).gte(1),
                                            layout = createLayout(
                {
                    name = "Transform into Werewolf",
                    art = "art/T_Wolf_Form",
                    frame = "frames/Treasure_CardFrame",
					cost = 4,
                    xmlText=[[
<vlayout>
<hlayout flexibleheight="5">
        <box flexiblewidth="1">
         <tmpro text="{expend_1}" fontsize="60"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="{combat_6}" fontsize="46" />
               
        </box>
    </hlayout> 
    <divider/>
<hlayout flexibleheight="1">
        <box flexiblewidth="1">

<tmpro text="Flip this card at the start of your turn." fontsize="15" />
         </box>
    </hlayout>    
</vlayout>

					]],
                    health = 6,
                    isGuard = false
                }
            ),
                                            tags = {gainHealth2Tag}
                                        }
                                    }
                                }
												),
						
                    }
						),
			},
            layout = createLayout(
                {
                    name = "Mysterious Mercenary",
                    art = "art/T_man_at_arms_old",
                    frame = "frames/Treasure_CardFrame",
					cost = 4,
                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
         <tmpro text="{expend}" fontsize="30" flexiblewidth="1" />
        </box>
        <box flexiblewidth="3">
         <tmpro text="{combat_4}" fontsize="30" flexiblewidth="1" />
        </box>
        <box flexiblewidth="7">
            <tmpro text="Give this card a faction
until next turn." fontsize="16" />
        </box>
    </hlayout>  
    <divider/>
    
     <hlayout flexibleheight="1">
        <box flexiblewidth="1">
         <tmpro text="{expend_1}" fontsize="50" flexiblewidth="1" />
        </box>
        <box flexiblewidth="3">
         <tmpro text="{combat_6}" fontsize="30" flexiblewidth="1" />
        </box>
        <box flexiblewidth="7">
            <tmpro text="+1{shield} until next turn." fontsize="16" />
        </box>
    </hlayout> 
</vlayout>

					]],
                    health = 4,
                    isGuard = false
                }
            )
        }
    )
end

function mythic_exp_werewolf_merc2_carddef()
    return createChampionDef(
        {
            id = "werewolf_merc2",
            name = "Werewolf Mercenary",
			types = {championType},
            acquireCost = 4,
            health = 5,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "werewolf_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(6) -- add flip
						
                    }
                ),
				createAbility(
                    {
                        id = "werewolf_revert1",
                        trigger = startOfTurnTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = transformTarget("mysterious_merc").apply(selectSource())
						
                    }
                ),
				createAbility(
                    {
                        id = "werewolf_revert2",
                        trigger = onLeavePlayTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = transformTarget("mysterious_merc").apply(selectSource())
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Werewolf Mercenary",
                    art = "art/T_Wolf_Form",
                    frame = "frames/Treasure_CardFrame",
					cost = 4,
                    xmlText=[[
<vlayout>
<hlayout flexibleheight="5">
        <box flexiblewidth="1">
         <tmpro text="{expend}" fontsize="36"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="{combat_6}" fontsize="46" />
               
        </box>
    </hlayout> 
    <divider/>
<hlayout flexibleheight="1">
        <box flexiblewidth="1">

<tmpro text="Flip this card at the start of your turn." fontsize="15" />
         </box>
    </hlayout>    
</vlayout>

					]],
                    health = 5,
                    isGuard = false
                }
            )
        }
    )
end

function mythic_exp_stone_skin_carddef()
    return createDef(
        {
            id = "stone_skin",
            name = "Stone skin",
			types = {actionType},
			cardTypeLabel = "Action",
			f
            acquireCost = 5,
            abilities = {
                createAbility(
                    {
                        id = "stone_skin_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,

effect = pushChoiceEffectWithTitle({
                        choices = {
							--1st option
							{
                               effect = gainToughnessEffect(5).seq(gainHealthEffect(5)),
											
                                            layout = layoutCard(
                                                {
                                                    title = "Stone Skin",
                                                    art = "art/T_Granite_Smasher",
													frame = "frames/Generic_CardFrame",
                                                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="&lt;size=60%&gt;Gain 5 Toughness

&lt;/size&gt;{health_5}" fontsize="40"/>
    </box>
</vlayout> 
					]]
                                                }
                                            ),
                                            tags = {}
                                        },
										
								
                                layout = createLayout({
                                    name = "Stone Skin",
                                    art = "art/T_Granite_Smasher",
                                    frame = "frames/Generic_CardFrame",
                                    xmlText = [[
                                        <vlayout>
    <box flexibleheight="1">
        <tmpro text="Give +3{shield} to a
factionless champion.

Draw a card." fontsize="20"/>
    </box>
</vlayout> 
                                    ]],
                                }),
                                tags = {  }
								
                            ,
							--2nd option
                            {
                               effect = pushTargetedEffect(
															{
																desc = "Choose a factionless champion to get +3 defense. Draw a card.",
																validTargets =  s.CurrentPlayer(CardLocEnum.InPlay).Where(isCardFactionless()),
																min = 1,
																max = 1,
																targetEffect = grantHealthTarget(3, { SlotExpireEnum.LeavesPlay }, nullEffect(), "shield").seq(drawCardsEffect(1)), -- add prepare
																tags = {toughestTag}                        
															}
														),
											condition = selectLoc(loc(currentPid, inPlayPloc)).where(isCardChampion().And(isCardFactionless())).count().gte(1),
                                            layout = layoutCard(
                                                {
                                                    title = "Stone Skin",
                                                    art = "art/T_Granite_Smasher",
													frame = "frames/Generic_CardFrame",
                                                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="If the champion is factionless:
		
Draw a card." fontsize="20"/>
    </box>
</vlayout> 
					]]
                                                }
                                            ),
                                            tags = {}
                                        },
										
								
                                layout = createLayout({
                                    name = "Stone Skin",
                                    art = "art/T_Granite_Smasher",
                                    frame = "frames/Generic_CardFrame",
                                    xmlText = [[
                                        <vlayout>
    <box flexibleheight="1">
        <tmpro text="Give +3{shield} to a
factionless champion.

Draw a card." fontsize="20"/>
    </box>
</vlayout> 
                                    ]],
                                }),
                                tags = {  }
								
                            ,
							--3rd option
                            {
                                effect = pushChoiceEffectWithTitle({
											choices = {
											--2.1
												{
                                            effect = pushTargetedEffect(
															{
																desc = "Choose an Imperial champion to get +3 defense. Prepare that champion",
																validTargets =  s.CurrentPlayer(CardLocEnum.InPlay).Where(isCardFaction(imperialFaction)),
																min = 1,
																max = 1,
																targetEffect = grantHealthTarget(3, { SlotExpireEnum.LeavesPlay }, nullEffect(), "shield").seq(prepareTarget()), -- add prepare
																tags = {toughestTag}                        
															}
														),
											condition = selectLoc(loc(currentPid, inPlayPloc)).where(isCardChampion().And(isCardFaction(imperialFaction))).count().gte(1),
                                            layout = layoutCard(
                                                {
                                                    title = "Stone Skin",
                                                    art = "art/T_Granite_Smasher",
													frame = "frames/Imperial_Action_CardFrame",
                                                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="Give +3{shield} to an
Imperial champion.

Prepare that champion" fontsize="20"/>
    </box>
</vlayout> 
					]]
                                                }
                                            ),
                                            tags = {}
                                        },
													--2.2
												{
                                            effect = pushTargetedEffect(
															{
																desc = "Choose a Wild champion to get +3 defense. Gain 3 combat this turn.",
																validTargets =  s.CurrentPlayer(CardLocEnum.InPlay).Where(isCardFaction(wildFaction)),
																min = 1,
																max = 1,
																targetEffect = grantHealthTarget(3, { SlotExpireEnum.LeavesPlay }, nullEffect(), "shield").seq(gainCombatEffect(3)), -- add prepare
																tags = {toughestTag}                        
															}
														),
											condition = selectLoc(loc(currentPid, inPlayPloc)).where(isCardChampion().And(isCardFaction(wildFaction))).count().gte(1),
                                            layout = layoutCard(
                                                {
                                                    title = "Stone Skin",
                                                    art = "art/T_Granite_Smasher",
													frame = "frames/Wild_Action_CardFrame",
                                                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="Give +3{shield} to a
Wild champion.

{combat_3}" fontsize="20"/>
    </box>
</vlayout> 
					]]
                                                }
                                            ),
                                            tags = {}
                                        },
												--2.3
												{
                                            effect = pushTargetedEffect(
															{
																desc = "Choose a Guild champion to get +3 defense. Put a card from your discard to the top of your deck.",
																validTargets =  s.CurrentPlayer(CardLocEnum.InPlay).Where(isCardFaction(guildFaction)),
																min = 1,
																max = 1,
																targetEffect = grantHealthTarget(3, { SlotExpireEnum.LeavesPlay }, nullEffect(), "shield")
																.seq(pushTargetedEffect(
															{
																desc = "Move to top deck",
																validTargets =  s.CurrentPlayer(CardLocEnum.discard),
																min = 1,
																max = 1,
																targetEffect = moveToTopDeckTarget(false),
																tags = {toughestTag}                        
															}
														)),
																tags = {toughestTag}                        
															}
														),
											condition = selectLoc(loc(currentPid, inPlayPloc)).where(isCardChampion().And(isCardFaction(guildFaction))).count().gte(1),
                                            layout = layoutCard(
                                                {
                                                    title = "Stone Skin",
													frame = "frames/Guild_Action_CardFrame",
                                                    art = "art/T_Granite_Smasher",
                                                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="Give +3{shield} to a
Guild champion.

Put a card from your discard on top of your deck." fontsize="20"/>
    </box>
</vlayout> 
					]]
                                                }
                                            ),
                                            tags = {}
                                        },
												--2.4
												{
                                            effect = pushTargetedEffect(
															{
																desc = "Choose a Necros champion to get +3 defense. Sacrifice a card from your hand or discard pile.",
																validTargets =  s.CurrentPlayer(CardLocEnum.InPlay).Where(isCardFaction(necrosFaction)),
																min = 1,
																max = 1,
																targetEffect = grantHealthTarget(3, { SlotExpireEnum.LeavesPlay }, nullEffect(), "shield")
																.seq(pushTargetedEffect(
															{
																desc = "Sacrfice a card from your hand or discard pile.",
																validTargets =  selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, discardPloc))),
																min = 1,
																max = 1,
																targetEffect = sacrificeTarget(),
																tags = {toughestTag}                        
															}
														)),
																tags = {toughestTag}                        
															}
														),
											condition = selectLoc(loc(currentPid, inPlayPloc)).where(isCardChampion().And(isCardFaction(necrosFaction))).count().gte(1),
                                            layout = layoutCard(
                                                {
                                                    title = "Stone Skin",
                                                    art = "art/T_Granite_Smasher",
													frame = "frames/Necros_Action_CardFrame",
                                                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="Give +3{shield} to a
Necros champion.

Sacrifice a card from your hand or discard pile." fontsize="20"/>
    </box>
</vlayout> 
					]]
                                                }
                                            ),
                                            tags = {}
                                        }
												
												},
												upperTitle = "Target a champion with a faction.",
												lowerTitle = "Gain a bonus based on that champion's faction."
												}),
								condition = selectLoc(loc(currentPid, inPlayPloc)).where(isCardChampion().And(isCardFactionless().invert())).count().gte(1),
                                layout = createLayout(
                {
                    name = "Stone skin",
                    art = "art/T_Granite_Smasher",
                    frame = "frames/Treasure_CardFrame",
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="If the champion is:

{imperial} Prepare that champion.
{wild} {combat_3}
{guild} Put a card from your discard on top of your deck.
{necro} Sacrifice 1 from your hand or discard." fontsize="15"/>
</box>
</vlayout> 
					]],

                }
            ),
                                tags = { addFactionTag }
                            },
                         					
							
                        },
						upperTitle = "Give a champion +3 defense until it leaves play.",
						lowerTitle = "Gain a bonus based on that champion's faction."
                    })
					}
                )
            },
			layout = createLayout(
                {
                    name = "Stone skin",
                    art = "art/T_Granite_Smasher",
                    frame = "frames/Treasure_CardFrame",
					cost = 5,
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="Gain 5 Toughness and {health_5} or
Give a champion +3{shield}
until it leaves play. If it is:
Factionless: Draw a card.
{imperial} Prepare that champion.
{wild} {combat_3}
{guild} Top-deck one card from your discard.
{necro} Sacrifice 1 from your hand or discard." fontsize="15"/>
</box>
</vlayout>  
					]],

                }
            )
        }
    )
end

function mythic_exp_wyvern_carddef()
    return createChampionDef(
        {
            id = "wyvern",
            name = "Wyvern",
			types = {championType},
            acquireCost = 5,
            health = 4,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "wyvern_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = pushChoiceEffect({
                        choices = {
                            {
                                effect = gainCombatEffect(4),
                                layout = createLayout({
								name = "Wyvern",
								art = "art/T_Wyvern",
								frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
                                        <vlayout>

    <hlayout flexibleheight="7.7">
         <tmpro text="{expend}" fontsize="40" flexiblewidth="1.5"/>

 <vlayout flexiblewidth="8">
            <tmpro text="{combat_4}" fontsize="46" flexibleheight="7"/>

</vlayout> 

    </hlayout> 
</vlayout>
                                    ]],
                                }),
                                tags = { }
                            },
                            {
                                effect = gainCombatEffect(4).seq(gainGoldEffect(-1)).seq(drawCardsEffect(1)),
                                condition = getPlayerGold(currentPid).gte(1),
								layout = createLayout({
								name = "Wyvern",
								art = "art/T_Wyvern",
								frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
                                        <vlayout>
    <hlayout flexibleheight="7.7">
         <tmpro text="{expend_1}" fontsize="72" flexiblewidth="1.5"/>

 <vlayout flexiblewidth="8">
            <tmpro text="{combat_4}" fontsize="46" flexibleheight="7"/>

<tmpro text="Draw 1" fontsize="20" flexibleheight="7"/>
</vlayout> 

    </hlayout> 
</vlayout>
                                    ]],
                                }),
                                tags = { }
                            }
                        }
                    })
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Wyvern",
                    art = "art/T_Wyvern",
                    frame = "frames/Treasure_CardFrame",
					cost = 5,
                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
         <tmpro text="{expend}" fontsize="30" flexiblewidth="1" />
        </box>
        <box flexiblewidth="3">
         <tmpro text="{combat_4}" fontsize="30" alignment="center" flexiblewidth="1" />
        </box>

    </hlayout>  
    <divider/>
    
     <hlayout flexibleheight="1">
        <box flexiblewidth="1">
         <tmpro text="{expend_1}" fontsize="50" flexiblewidth="1" />
        </box>
        <box flexiblewidth="3">
         <tmpro text="{combat_4}" fontsize="30" flexiblewidth="7" alignment="center" />

            <tmpro text="Draw 1" fontsize="16" alignment="left"/>
        </box>
    </hlayout> 
</vlayout>

					]],
                    health = 4,
                    isGuard = false
                }
            )
        }
    )
end

function mythic_exp_shapeshift_carddef()
    return createDef(
        {
            id = "shapeshift",
            name = "Shapeshift",
			types = {actionType},
			cardTypeLabel = "Action",
			playLocation = castPloc,
            acquireCost = 6,
            abilities = {
                createAbility(
                    {
                        id = "shapeshift_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = pushChoiceEffect({
                        choices = {
                            {
                                effect = addSlotToTarget(createFactionsSlot({ imperialFaction }, { endOfTurnExpiry, leavesPlayExpiry })).apply(selectSource()).seq(gainHealthEffect(8)),
                                layout = createLayout({
								name = "Shapeshift",
								art = "art/T_Confused_apparition",
								frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
                                        <vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
         <tmpro text="{imperial}" fontsize="60" flexiblewidth="1" />
        </box>
        <box flexiblewidth="3">
         <tmpro text="{health_8}" fontsize="60" alignment="center" flexiblewidth="1" />
        </box>

    </hlayout>  
</vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            },
                            {
                                effect = addSlotToTarget(createFactionsSlot({ wildFaction }, { endOfTurnExpiry, leavesPlayExpiry })).apply(selectSource()).seq(drawCardsEffect(2)).seq(forceDiscard(1)),
                                layout = createLayout({
								name = "Shapeshift",
								art = "art/T_Confused_apparition",
								frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
                                        <vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
         <tmpro text="{wild}" fontsize="60" flexiblewidth="1" />
        </box>
        <box flexiblewidth="3">
         <tmpro text="Draw 2.
Discard 1." fontsize="30" alignment="center" flexiblewidth="1" />
        </box>

    </hlayout>  
</vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            },
                            {
                                effect = addSlotToTarget(createFactionsSlot({ guildFaction }, { endOfTurnExpiry, leavesPlayExpiry })).apply(selectSource()).seq(gainGoldEffect(3)),
                                layout = createLayout({
								name = "Shapeshift",
								art = "art/T_Confused_apparition",
								frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
                                        <vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
         <tmpro text="{guild}" fontsize="60" flexiblewidth="1" />
        </box>
        <box flexiblewidth="3">
         <tmpro text="{gold_3}" fontsize="60" alignment="center" flexiblewidth="1" />
        </box>

    </hlayout>  
</vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            },
                            {
                                effect = addSlotToTarget(createFactionsSlot({ necrosFaction }, { endOfTurnExpiry, leavesPlayExpiry })).apply(selectSource()).seq(gainCombatEffect(5)),
                                layout = createLayout({
								name = "Shapeshift",
								art = "art/T_Confused_apparition",
								frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
                                        <vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
         <tmpro text="{necro}" fontsize="60" flexiblewidth="1" />
        </box>
        <box flexiblewidth="3">
         <tmpro text="{combat_5}" fontsize="60" alignment="center" flexiblewidth="1" />
        </box>

    </hlayout>  
</vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            }
                        }
                    })
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Shapeshift",
                    art = "art/T_Confused_apparition",
                    frame = "frames/Treasure_CardFrame",
					cost = 6,
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="Choose 1:

{imperial} {health_8}
{wild} Draw 2. Discard 1.
{guild} {gold_3}
{necro} {combat_5}
" fontsize="20"/>
    </box>
</vlayout> 
					]],

                }
            )
        }
    )
end


function mythic_exp_troll_merc_carddef()
    return createChampionDef(
        {
            id = "troll_merc",
            name = "Troll Mercenary",
			types = {championType},
            acquireCost = 6,
            health = 5,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "troll_merc_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = pushChoiceEffect({
                        choices = {
                            {
                                effect = gainCombatEffect(6),
                                layout = createLayout({
								name = "Troll Mercenary",
								art = "art/T_Flesh_Ripper",
								frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
                                        <vlayout>

    <hlayout flexibleheight="7.7">
         <tmpro text="{expend}" fontsize="40" flexiblewidth="1.5"/>

 <vlayout flexiblewidth="8">
            <tmpro text="{combat_6}" fontsize="46" flexibleheight="7"/>

</vlayout> 

    </hlayout> 
</vlayout>
                                    ]],
                                }),
                                tags = { }
                            },
                            {
                                effect = gainCombatEffect(9).seq(gainGoldEffect(-1)),
                                condition = getPlayerGold(currentPid).gte(1),
								layout = createLayout({
								name = "Troll Mercenary",
								art = "art/T_Flesh_Ripper",
								frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
<vlayout>

    <hlayout flexibleheight="7.7">
         <tmpro text="{expend_1}" fontsize="72" flexiblewidth="1.5"/>

 <vlayout flexiblewidth="8">
            <tmpro text="{combat_9}" fontsize="46" flexibleheight="7"/>

</vlayout> 

    </hlayout> 
</vlayout>
                                    ]],
                                }),
                                tags = { }
                            }
                        }
                    })
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Troll Mercenary",
                    art = "art/T_Flesh_Ripper",
                    frame = "frames/Treasure_CardFrame",
					cost = 6,
                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
         <tmpro text="{expend}" fontsize="30" flexiblewidth="1" />
        </box>
        <box flexiblewidth="3">
         <tmpro text="{combat_6}" fontsize="30" alignment="center" flexiblewidth="1" />
        </box>

    </hlayout>  
    <divider/>
    
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
         <tmpro text="{expend_1}" fontsize="50" flexiblewidth="1" />
        </box>
        <box flexiblewidth="3">
         <tmpro text="{combat_9}" fontsize="30" alignment="center" flexiblewidth="1" />
        </box>

    </hlayout>  
</vlayout>

					]],
                    health = 5,
                    isGuard = true
                }
            )
        }
    )
end

function mythic_exp_basilisks_gaze_carddef()
    return createDef(
        {
            id = "basilisks_gaze",
            name = "Basilisk's Gaze",
			types = {actionType},
			cardTypeLabel = "Action",
			playLocation = castPloc,
            acquireCost = 7,
            abilities = {
                createAbility(
                    {
                        id = "basilisks_gaze_main",
                        trigger = uiTrigger,
						playAllType = noPlayPlayType,
                        cost = noCost,
                        activations = singleActivations,
                        effect = stunTarget().apply(selectLoc(loc(oppPid, inPlayPloc)).where(isCardChampion().And(getCardCost().lte(4))))
						.seq(hitOpponentEffect(6))
						-- add You may move up 2 cards from your opponent's discard pile - one to the top of their deck, one to the bottom. 
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Basilisk's Gaze",
                    art = "art/T_Basilisk",
                    frame = "frames/Treasure_CardFrame",
					cost = 7,
                    xmlText=[[
<vlayout>
        <box flexibleheight="1">
        <tmpro text="
Deal 6 damage to opponent.

Stun all of target
opponent's champions
that cost {gold_4} or less.
" fontsize="20"/>
    </box>
</vlayout> 
					]],

                }
            )
        }
    )
end

function mythic_exp_golem_for_hire_carddef()


    return createChampionDef(
        {
            id = "golem_for_hire",
            name = "Coin-operated Golem",
			types = {championType},
            acquireCost = 8,
            health = 7,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "golem_for_hire",
                        trigger = uiTrigger,
                        cost = combineCosts({ expendCost, goldCost(1) }),
                        activations = singleActivations,
                        effect = pushChoiceEffect({
                        choices = {
                            {
                                effect = gainCombatEffect(7),
                                layout = createLayout({
								name = "Golem for Hire",
								art = "art/T_Stone_Guardian",
								frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
    <vlayout>
<hlayout flexibleheight="7.7">
         <tmpro text="{expend_1}" fontsize="72" flexiblewidth="1.5"/>

 <vlayout flexiblewidth="8">
            <tmpro text="{combat_7}" fontsize="60" flexibleheight="7"/>

</vlayout> 

    </hlayout> 
</vlayout>
                                    ]],
                                }),
                                tags = { }
                            },
                            {
                                effect = grantHealthTarget(3, { SlotExpireEnum.startOfOwnerTurn }, nullEffect(), "Grounded").apply(selectSource())
								.seq(addSlotToTarget(createGuardSwitchSlot(true, { startOfOwnerTurnExpiry })).apply(selectSource())),

								layout = createLayout({
								name = "Golem for Hire",
								art = "art/T_Stone_Guardian",
								frame = "frames/Treasure_CardFrame",
                                    xmlText = [[

<vlayout>
    <hlayout flexibleheight="3">
            <tmpro text="{expend_1}" fontsize="70" flexiblewidth="2"/>
            <tmpro text="{combat_7}&lt;size=60%&gt;
or
+3{shield} and {guard}
until next turn." fontsize="40" flexiblewidth="10" />
    </hlayout> 
</vlayout>
                                    ]],
                                }),
                                tags = { }
                            }
                        }
                    })
						
                    }
                )
				
            },
			
			
            layout = createLayout(
                {
                    name = "Coin-operated Golem",
                    art = "art/T_Stone_Guardian",
                    frame = "frames/Treasure_CardFrame",
					cost = 8,
                    xmlText=[[

<vlayout>
    <hlayout flexibleheight="3">
            <tmpro text="{expend_1}" fontsize="70" flexiblewidth="2"/>
            <tmpro text="{combat_7}&lt;size=60%&gt;
or
+3{shield} and {guard}
until next turn." fontsize="40" flexiblewidth="10" />
    </hlayout> 
</vlayout>

					]],
                    health = 7,
                    isGuard = false
                }
            )
        }
    )
end



function mythic_mercs_ee_scrapforks_carddef()
    return createChampionDef(
        {
            id = "scrapforks",
            name = "Scrapforks",
			types = {championType},
            acquireCost = 4,
            health = 5,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "scrapforks_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = randomEffect({
					valueItem(4, gainCombatEffect(5)),
					valueItem(1, moveTarget(loc(currentPid, deckPloc)).apply(selectSource()).seq(shuffleEffect(loc(currentPid, deckPloc))))
                    }
                ).seq(noUndoEffect())
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Scrapforks",
                    art = "art/T_Fighter_Male",
                    frame = "frames/Treasure_CardFrame",
					cost = 4,
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="50" flexiblewidth="2"/>
            <tmpro text="80% chance: {combat_5}
20% chance to not show up: shuffle back into deck" fontsize="20
" flexiblewidth="12" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
            <tmpro text="His pauldrons are made from old cutlery." fontsize="20" fontstyle="italic" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]],
                    health = 5,
                    isGuard = false
                }
            )
        }
    )
end


function mythic_mercs_ee_dblducks_carddef()
    return createChampionDef(
        {
            id = "dblducks",
            name = "Dbl Ducks",
			types = {championType},
            acquireCost = 4,
            health = 5,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "dblducks",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(4).seq(moveTarget(myRevealPloc).apply(selectLoc(loc(currentPid, deckPloc)).take(2)).seq(noUndoEffect()).seq(promptSplit({
    selector = selectLoc(currentRevealLoc),
    take = const(2), -- number of cards to take for split
    sort = const(1), -- number of cards to be sorted for ef2
    ef1 = moveToTopDeckTarget(true), -- effect to be applied to cards left
    ef2 = moveToBottomDeckTarget(true, 1), -- effect to be applied to sorted cards
    header = "Gaze into the future", -- prompt header
    description = "Look at the top two cards of your deck. Put one on the top and one on the bottom of your deck.",
    rightPileDesc = "Right card on top.",
    pile1Name = "Top of Deck",
    pile2Name = "Bottom of Deck",
    eff1Tags = { buytopdeckTag },
    eff2Tags = { cheapestTag }
})))
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "DblDucks",
                    art = "art/T_Influence",
                    frame = "frames/Treasure_CardFrame",
					cost = 4,
                    xmlText=[[
					
<vlayout>
    <hlayout flexibleheight="1.8">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="1">
                <tmpro text="{combat_4}" fontsize="36" />
            </box>
            <box flexibleheight="2">
                <tmpro text="Gaze into the future:
Draw 2. Put one on top and one on bottom of your deck." fontsize="18" />
            </box>
        </vlayout>
    </hlayout>
    <divider/>
    <hlayout flexibleheight="1">
        
        <box flexiblewidth="7">
            <tmpro text="Beware the man with two mallards on his crest." fontsize="18" fontstyle="italic"/>
        </box>
    </hlayout>
</vlayout>
					]],
                    health = 5,
                    isGuard = true
                }
            )
        }
    )
end


function mythic_mercs_ee_parsons_carddef()
    return createChampionDef(
        {
            id = "parsons_merc",
            name = "Parsons the Insider",
			types = {championType},
            acquireCost = 5,
            health = 5,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "parsons_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainGoldEffect(2)
						.seq(pushTargetedEffect({
												  desc="Move a card from your discard to the top of your deck.",
												  min=0,
												  max=1,
												  validTargets= selectLoc(loc(currentPid, discardPloc)),
												  targetEffect= moveToBottomDeckTarget(false, 0),
												  tags = {}
												}))
						
                    }
                ),
				createAbility({
                id = "parsons_faction",
                effect = pushChoiceEffect({
                        choices = {
                            {
                                effect = addSlotToTarget(createFactionsSlot({ imperialFaction }, { leavesPlayExpiry })).apply(selectSource()),
                                layout = createLayout({
                                    name = "Parons the Insider",
                                    art = "art/T_Thief_Male_Alternate",
                                    frame = "frames/Imperial_Champion_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{imperial}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            },
                            {
                                effect = addSlotToTarget(createFactionsSlot({ wildFaction }, { leavesPlayExpiry })).apply(selectSource()),
                                layout = createLayout({
                                    name = "Parons the Insider",
                                    art = "art/T_Thief_Male_Alternate",
                                    frame = "frames/Wild_Champion_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{wild}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            },
                            {
                                effect = addSlotToTarget(createFactionsSlot({ guildFaction }, { leavesPlayExpiry })).apply(selectSource()),
                                layout = createLayout({
                                    name = "Parons the Insider",
                                    art = "art/T_Thief_Male_Alternate",
                                    frame = "frames/Guild_Champion_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{guild}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            },
                            {
                                effect = addSlotToTarget(createFactionsSlot({ necrosFaction }, { leavesPlayExpiry })).apply(selectSource()),
                                layout = createLayout({
                                    name = "Parons the Insider",
                                    art = "art/T_Thief_Male_Alternate",
                                    frame = "frames/Necros_Champion_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{necro}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            }
                        }
                    }
                ),
                cost = noCost,
                trigger = onPlayTrigger,
                promptType = showPrompt,
                tags = { gainGoldTag }
            })
				
            },
            layout = createLayout(
                {
                    name = "Parsons the Insider",
                    art = "art/T_Thief_Male_Alternate",
                    frame = "frames/Treasure_CardFrame",
					cost = 5,
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
            <tmpro text="Choose a faction as you play this card. It has the chosen faction until it leaves play." fontsize="14" fontstyle="italic" flexiblewidth="4" />
    </hlayout>     
  <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="50" flexiblewidth="2"/>
            <tmpro text="{gold_2}
You may put a card from your discard pile onto the bottom of your deck" fontsize="20
" flexiblewidth="12" />
    </hlayout>


</vlayout>
					]],
                    health = 5,
                    isGuard = false
                }
            )
        }
    )
end


function mythic_mercs_ee_stigmalingpa_carddef()
    return createChampionDef(
        {
            id = "stigmalingpa",
            name = "Stigmalingpa",
			types = {championType},
            acquireCost = 4,
            health = 4,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "stigmalingpa",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainHealthEffect(4)
						.seq(pushTargetedEffect({
								desc = "Transform a Gold in your discard pile into a Ruby.",
								validTargets = selectLoc(loc(currentPid, discardPloc)).where(isCardType(coinType)),
								min = 0,
								max = 1,
								targetEffect = transformTarget("ruby"),
									
								}))
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Stigmalingpa",
                    art = "art/T_Wizard_Runic_Robes",
                    frame = "frames/Treasure_CardFrame",
					cost = 4,
                    xmlText=[[
					
<vlayout>
    <hlayout flexibleheight="1.8">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="1">
                <tmpro text="{health_4}" fontsize="36" />
            </box>
            <box flexibleheight="2">
                <tmpro text="Transform a Gold in your discard pile into a Ruby." fontsize="20" />
            </box>
        </vlayout>
    </hlayout>
    <divider/>
    <hlayout flexibleheight="1">
        
        <box flexiblewidth="7">
            <tmpro text="I've been saying for a while now, 'It needs another Ruby.'" fontsize="18" fontstyle="italic"/>
        </box>
    </hlayout>
</vlayout>
					]],
                    health = 4,
                    isGuard = true
                }
            )
        }
    )
end

function mythic_mercs_ee_agent_th_carddef()
    return createChampionDef(
        {
            id = "agent_th",
            name = "Agent Teeth Hurting",
			types = {championType},
            acquireCost = 4,
            health = 5,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "agent_th",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = randomEffect({
					valueItem(27, createCardEffect(cat_familiar_token_carddef(), currentInPlayLoc)),
					valueItem(27, createCardEffect(kit_cat_token_carddef(), currentInPlayLoc)),
					valueItem(27, createCardEffect(chunky_cat_token_carddef(), currentInPlayLoc)),
					valueItem(14, createCardEffect(big_bad_kitty_token_carddef(), currentInPlayLoc)),
					valueItem(5, createCardEffect(surprise_dragon_token_carddef(), currentInPlayLoc))
					
}).seq(noUndoEffect())
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Agent Teeth Hurting",
                    art = "art/T_Elven_Curse",
                    frame = "frames/Treasure_CardFrame",
					cost = 4,
                    xmlText=[[
					
<vlayout>
    <hlayout flexibleheight="1.8">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Put a random cat token into play." fontsize="24" />
            </box>
        </vlayout>
    </hlayout>
    <divider/>
    <hlayout flexibleheight="1">
        
        <box flexiblewidth="7">
            <tmpro text="The elves cursed him. Now he lives with eternal tooth ache." fontsize="20" fontstyle="italic"/>
        </box>
    </hlayout>
</vlayout>
					]],
                    health = 5,
                    isGuard = false
                }
            )
        }
    )
end


function cat_familiar_token_carddef()
--This is a token champion, that self-sacrifices when it leaves play
    return createChampionDef(
        {
            id = "familiar_cat_token",
            name = "Familiar Cat",
			types = {minionType, championType, nostealType, tokenType},
            acquireCost = 0,
            health = 2,
            isGuard = false,
            abilities = {
			--base ability
                createAbility(
                    {
                        id = "familiar_cat_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = pushChoiceEffect({
							choices = {
								{
                                effect = gainCombatEffect(1),
                                layout = createLayout({
									name = "Familiar Cat",
									art = "art/T_Cat_Familiar",
                                    frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{combat_1}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                            
                            },
							{
                                effect = gainGoldEffect(1),
                                layout = createLayout({
									name = "Familiar Cat",
									art = "art/T_Cat_Familiar",
                                    frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{gold_1}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                               
                            },
							{
                                effect = gainHealthEffect(1),
                                layout = createLayout({
									name = "Familiar Cat",
									art = "art/T_Cat_Familiar",
                                    frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{health_1}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                               
                            }
							
												}})
						
                    }
                )
            ,
			--self-sac ability
                createAbility(
                    {
                        id = "familiar_cat_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )},
            layout = createLayout(
                {
                    name = "Familiar Cat",
                    art = "art/T_Cat_Familiar",
                    frame = "frames/Treasure_CardFrame",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="35"/>
        </box>
        <box flexiblewidth="7">
            <icon text="{combat_1}or{gold_1}or{health_1}" fontsize="40"/>
</box>
</hlayout>
</vlayout>
					]],
                    health = 2,
                    isGuard = false
                }
            )
        }
    )
end

function kit_cat_token_carddef()
--This is a token champion, that self-sacrifices when it leaves play
    return createChampionDef(
        {
            id = "kit_cat_token",
            name = "Kit Cat",
			types = {minionType, championType, nostealType, tokenType},
            acquireCost = 0,
            health = 2,
            isGuard = false,
            abilities = {
			--base ability
                createAbility(
                    {
                        id = "kit_cat_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = hitOpponentEffect(2)
						
                    }
                )
            ,
			--self-sac ability
                createAbility(
                    {
                        id = "kit_cat_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )},
            layout = createLayout(
                {
                    name = "Kit Cat",
                    art = "art/treasures/T_Wise_Cat_Familiar",
                    frame = "frames/Treasure_CardFrame",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="40"/>
        </box>
        <box flexiblewidth="6">
            <icon text="Deal 2 damage to opponent." fontsize="30"/>
</box>
</hlayout>
</vlayout>
					]],
                    health = 2,
                    isGuard = false
                }
            )
        }
    )
end

function chunky_cat_token_carddef()
--This is a token champion, that self-sacrifices when it leaves play
    return createChampionDef(
        {
            id = "chunky_cat_token",
            name = "Kit Cat Chunky",
			types = {minionType, championType, nostealType, tokenType},
            acquireCost = 0,
            health = 2,
            isGuard = true,
            abilities = {
			--base ability
                createAbility(
                    {
                        id = "chunky_cat_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = drawCardsEffect(1)
						
                    }
                )
            ,
			--self-sac ability
                createAbility(
                    {
                        id = "chunky_cat_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )},
            layout = createLayout(
                {
                    name = "Kit Cat Chunky",
                    art = "art/treasures/T_Fat_Cat_Familiar",
                    frame = "frames/Treasure_CardFrame",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="35"/>
        </box>
        <box flexiblewidth="7">
            <icon text="Draw 1" fontsize="40"/>
</box>
</hlayout>
</vlayout>
					]],
                    health = 2,
                    isGuard = true
                }
            )
        }
    )
end


function big_bad_kitty_token_carddef()
--This is a token champion, that self-sacrifices when it leaves play
    return createChampionDef(
        {
            id = "big_bad_kitty_token",
            name = "Big Bad Kitty",
			types = {minionType, championType, nostealType, tokenType},
            acquireCost = 0,
            health = 3,
            isGuard = true,
            abilities = {
			--base ability
                createAbility(
                    {
                        id = "big_bad_kitty_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(3)
						
                    }
                )
            ,
			--self-sac ability
                createAbility(
                    {
                        id = "big_bad_kitty_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )},
            layout = createLayout(
                {
                    name = "Big Bad Kitty",
                    art = "art/T_Strength_of_the_wolf",
                    frame = "frames/Treasure_CardFrame",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="40"/>
        </box>
        <box flexiblewidth="6">
            <icon text="{combat_3}" fontsize="60"/>
</box>
</hlayout>
</vlayout>
					]],
                    health = 3,
                    isGuard = true
                }
            )
        }
    )
end

function surprise_dragon_token_carddef()
--This is a token champion, that self-sacrifices when it leaves play
    return createChampionDef(
        {
            id = "surprise_dragon_token",
            name = "Surprise Dragon",
			types = {minionType, championType, nostealType, tokenType},
            acquireCost = 0,
            health = 5,
            isGuard = true,
            abilities = {
			--base ability
                createAbility(
                    {
                        id = "surprise_dragon_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = damageTarget(2).apply(selectLoc(loc(oppPid, inPlayPloc)))
						
                    }
                )
            ,
			--self-sac ability
                createAbility(
                    {
                        id = "surprise_dragon_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )},
            layout = createLayout(
                {
                    name = "Surprise Dragon",
                    art = "art/T_Arkus_Imperial_Dragon",
                    frame = "frames/Treasure_CardFrame",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Deal 2 damage to each opposing champion." fontsize="22" />
            </box>
        </vlayout>
    </hlayout>
    <divider/>
    <hlayout flexibleheight="1">
        
        <box flexiblewidth="7">
            <tmpro text="Surprise!
Cats aren't the only critters he keeps around the house." fontsize="18" fontstyle="italic"/>
        </box>
    </hlayout>
</vlayout>
					]],
                    health = 5,
                    isGuard = true
                }
            )
        }
    )
end
