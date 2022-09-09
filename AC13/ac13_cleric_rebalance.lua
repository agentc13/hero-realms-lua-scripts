--[[ NOTES: Cleric with balance changes

Bless has less healing 
Health cap set to 100hp
]]
require "herorealms"
require "decks"
require "stdlib"
require "stdcards"
require "hardai"
require "mediumai"
require "easyai"

function maxHealthBuffDef()
    local ef = gainMaxHealthEffect(currentPid, 45).seq(sacrificeSelf())

    return createGlobalBuff(
        {
            id = "max_health_buff",
            name = "Max Health Increase",
            abilities = {
                createAbility(
                    {
                        id = "max_health_effect",
                        trigger = startOfGameTrigger,
                        effect = ef
                    }
                )
            }
        }
    )
end

function cleric_bless_of_soul_def()
    return createSkillDef(
        {
            id = "cleric_bless_of_soul",
            name = "Bless of Soul",
            types = {skillType},
            abilities = {
                createAbility(
                    {
                        id = "cleric_bless_of_soul",
                        trigger = uiTrigger,
                        promptType = showPrompt,
                        layout = createLayout(
                            {
                                name = "Siphon Life",
                                art = "art/T_The_Rot",
                                text = '<size=150%><sprite name="expend">,<size=130%><sprite name="gold_2">:<br><size=80%>You gain 1<sprite name="health"> and your opponent loses 1<sprite name="health">.<br>This also affects maximum health.'
                            }
                        ),
                        effect = gainMaxHealthEffect(currentPid, 1).seq(gainHealthEffect(1)).seq(hitOpponentEffect(1)).seq(
                            gainMaxHealthEffect(oppPid, -1)
                        ),
                        cost = goldCost(2)
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Bless of Soul",
                    art = "icons/cleric_bless_of_soul",
                    text = '<size=150%><sprite name="expend">,<size=130%><sprite name="gold_2">:<br><size=80%>You gain 1<sprite name="health"> and your opponent loses 1<sprite name="health">.<br>This also affects maximum health.'
                }
            ),
            layoutPath = "icons/cleric_bless_of_soul"
        }
    )
end

function setupGame(g)
    standardSetup(
        g,
        {
            description = "Cleric Rebalance Test",
            playerOrder = {plid1, plid2},
            ai = ai.CreateKillSwitchAi(createAggressiveAI(), createHardAi2()),
            timeoutAi = createTimeoutAi(),
            opponents = {{plid1, plid2}},
            players = {
                {
                    id = plid1,
                    startDraw = 3,
                    init = {
                        fromEnv = plid1
                    },
                    cards = {
                        buffs = {
                            drawCardsAtTurnEndDef(),
                            maxHealthBuffDef(),
                            discardCardsAtTurnStartDef(),
                            fatigueCount(40, 1, "FatigueP1")
                        }
                    }
                },
                {
                    id = plid2,
                    isAi = true,
                    name = "AI",
                    avatar = "skeleton",
                    health = 50,
                    cards = {
                        deck = {
                            {qty = 1, card = dagger_carddef()},
                            {qty = 1, card = shortsword_carddef()},
                            {qty = 1, card = ruby_carddef()},
                            {qty = 7, card = gold_carddef()}
                        },
                        buffs = {
                            drawCardsAtTurnEndDef(),
                            discardCardsAtTurnStartDef(),
                            fatigueCount(40, 1, "FatigueP2")
                        }
                    }
                }
            }
        }
    )
end

function endGame(g)
end
