require 'herorealms'
require 'decks'
require 'stdlib'
require 'stdcards'
require 'hardai'
require 'mediumai'
require 'easyai'

-- Custom reskin of Spiked Pauldrons
function orc_pauldrons_carddef()
    local cardLayout = createLayout({
        -- Name of card
        name = "Orc Pauldrons",
        -- Art for card
        art = "icons/battle_cry",
        -- frame for card
        frame = "frames/Warrior_CardFrame",
        text = (
            "<size=300%><line-height=0%><voffset=-.8em> <pos=-75%><sprite name=\"requiresHealth_25\"></size><line-height=80%> \n <voffset=1.8em><size=80%> If you have dealt 5 <sprite name=\"combat\"> to an opponent this turn. \n Draw 1 then \n discard 1 or, \n Gain 2 <sprite name=\"health\"> </size>"
            ),
    })

    return createMagicArmorDef({
        id = "orc_pauldrons",
        -- card name as it appears in top banner
        name = "Orc Pauldrons",
        layout = cardLayout,
        -- card art
        layoutPath = "icons/battle_cry",
        -- card effects
        abilities = {
            createAbility({
                id = "orc_pauldrons",
                layout = cardLayout,
                effect = pushChoiceEffect({
                    choices = {
                        {
                            effect = drawCardsEffect(1).seq(
                                pushTargetedEffect({
                                    desc = "Discard a card",
                                    min = 1,
                                    max = 1,
                                    validTargets = selectLoc(currentHandLoc),
                                    targetEffect = discardTarget()
                                })),
                            layout = layoutCard({
                                title = "Orc Pauldrons",
                                art = "icons/battle_cry",
                                text = ("Draw 1 then discard 1."),
                            }),
                            tags = { draw1Tag }

                        },
                        {
                            effect = gainHealthEffect(2),
                            layout = layoutCard({
                                title = "Orc Pauldrons",
                                art = "icons/battle_cry",
                                text = ("{2 health}"),
                            }),
                            tags = { gainHealth2Tag }
                        }
                    }
                }),
                -- trigger to activate ability
                trigger = uiTrigger,
                -- conditions to check to activate ability
                check = minDamageTakenOpp(5).And(minHealthCurrent(25)),
                -- cost to use ability
                cost = expendCost,
                tags = { draw1Tag, gainHealthTag, gainHealth2Tag },
            })
        }
    })
end

function setupGame(g)
    -- register newly created cards for further use
    -- no need to register overridden cards, like shining breastplate here
    registerCards(g, {
        orc_pauldrons_carddef()
    })

    standardSetup(g, {
        description = "Orc Pauldrons Armor test", -- script description - displayed in in-game menu
        playerOrder = { plid1, plid2 }, -- order in which players take turns
        ai = createHardAi(), -- sets AI for ai players
        -- randomOrder = true, -- if true, randomizes players order
        opponents = { { plid1, plid2 } }, -- pairs of opponents
        players = { -- array of players
            {
                id = plid1, -- sets up id for the player. options are plid1, plid2, plid3, plid4
                startDraw = 3, -- sets how many cards player draws at the start of the game. If not set, first player will draw 3, second player - 5
                init = { -- sets how hero get initialized
                    fromEnv = plid1 -- takes hero data from the selection (VS AI or Online)
                },
                cards = { -- cards allows to add any cards to any of hero location at the start of the game
                    buffs = {
                        drawCardsAtTurnEndDef(),
                        discardCardsAtTurnStartDef(),
                        fatigueCount(40, 1, "FatigueP1"),
                    },
                    skills = {
                        orc_pauldrons_carddef(),
                    }
                }
            },
            {
                id = plid2,
                isAi = true,
                startDraw = 5,
                name = "Sackforce",
                avatar = "tentacles",
                health = 50,
                cards = {
                    deck = {
                        { qty = 1, card = tentacle_carddef() },
                        { qty = 1, card = tentacle_whip_carddef() },
                        { qty = 3, card = elixir_of_fortune_carddef() },
                        { qty = 5, card = gold_male_dark_carddef() },
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

function endGame(g) -- more info on this later
end



