require 'herorealms'
require 'decks'
require 'stdlib'
require 'stdcards'
require 'hardai'
require 'mediumai'
require 'easyai'

function rallying_flag_carddef()
    return createActionDef({
        id = "flag",
        name = "Rallying Flag",
        types = { actionType, noStealType },
        acquireCost = 0,
        abilities = {
            createAbility({
                id = "flag",
                trigger = autoTrigger,
                effect = gainGoldEffect(1).seq(gainHealthEffect(3)),
            })
        },
        layout = createLayout({
            name = "Rallying Flag",
            art = "art/T_Devotion",
            frame = "frames/Warrior_CardFrame",
            text = "<size=200%><sprite name=\"gold_1\">   <sprite name=\"health_3\">",
        })
    })
end



function setupGame(g)
    registerCards(g, {
        rallying_flag_carddef()
    })
    standardSetup(g, {
        description = "Vanilla (No Heroes)",
        playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(), createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
        players = {
            {
                id = plid1,
                startDraw = 3,
                name = "Player 1",
                avatar = "avatars/krythos",
                health = 50,
                cards = { -- cards allows to add any cards to any of hero location at the start of the game
                    buffs = {
                        drawCardsAtTurnEndDef(),
                        discardCardsAtTurnStartDef(),
                        fatigueCount(40, 1, "FatigueP1"),
                    },
                    deck = {
                        { qty = 1, card = rallying_flag_carddef() },
                },
                    skills = {
                        fighter_devastating_blow_carddef(),
                        fighter_shoulder_crush_carddef()
                    }
                }
            },
            {
                id = plid2,
                isAi = true,
                startDraw = 5,
                name = "Player 2",
                avatar = "avatars/assassin",
                health = 50,
                cards = {
                    deck = {
                        { qty = 1, card = dagger_carddef() },
                        { qty = 1, card = shortsword_carddef() },
                        { qty = 1, card = ruby_carddef() },
                        { qty = 7, card = gold_carddef() },
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