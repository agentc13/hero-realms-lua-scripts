require 'herorealms'
require 'decks'
require 'stdlib'
require 'stdcards'
require 'hardai'
require 'mediumai'
require 'easyai'

-- existing cards can be completely overridden within script
-- just create a function with same name as original card has
-- and it would be replaced for your hero
function cleric_shining_breastplate_carddef()
    local cardLayout = createLayout({
        name = "Shining Breastplate",
        art = "icons/cleric_shining_breastplate",
        frame = "frames/Cleric_armor_frame",
        text = "Champion gets +1 defense permanently\n(requires 40 health)"
    })

    return createMagicArmorDef({
        id = "cleric_shining_breastplate",
        name = "Shining Breastplate of Hope",
        types = { clericType, magicArmorType, treasureType, chestType },
        layout = cardLayout,
        layoutPath = "icons/cleric_shining_breastplate",
        abilities = {
            createAbility({
                id = "cleric_shining_breastplate",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
                effect = pushTargetedEffect(
                    {
                        desc = "Choose a champion to get +1 defense (permanent)",
                        validTargets = s.CurrentPlayer(CardLocEnum.InPlay),
                        min = 1,
                        max = 1,
                        targetEffect = grantHealthTarget(1, { SlotExpireEnum.Never }, nullEffect(), "shield"),
                        tags = { toughestTag }
                    }
                ),
                cost = AbilityCosts.Expend,
                check = minHealthCurrent(40).And(selectLoc(currentInPlayLoc).where(isCardChampion()).count().gte(1))
            })
        }
    })
end

function orc_guardian_carddef()
    return createChampionDef({
        id = "orc_guardian",
        name = "Orc Guardian",
        types = { orcType, noStealType },
        acquireCost = 0,
        health = 3,
        isGuard = true,
        abilities = {
            createAbility({
                id = "feisty_orcling_auto",
                trigger = autoTrigger,
                effect = nullEffect()
            })
        },
        layout = createLayout({
            name = "Orc Guardian",
            art = "art/T_Orc_Guardian",
            frame = "frames/Coop_Campaign_CardFrame",
            text = "<i>He's quite defensive.</i>",
            health = 3,
            isGuard = true
        })
    })
end

--given to the players at the start of the game, triggers at the start of first player's turn then sacrifices itself
function doubleHealthBuffDef()
    -- here we define an effect for the buff
    local ef = gainMaxHealthEffect(currentPid, getPlayerMaxHealth(currentPid))
        -- order is important here. If you heal player before increasing max health
        -- it would heal only up to current max health
        .seq(healPlayerEffect(currentPid, getPlayerMaxHealth(currentPid)))
        .seq(gainMaxHealthEffect(oppPid, getPlayerMaxHealth(oppPid)))
        .seq(healPlayerEffect(oppPid, getPlayerMaxHealth(oppPid)))
        -- now we sacrifice the card, so we don't bother it triggering at the start of next turn
        -- useful for one time effects
        .seq(sacrificeSelf())

    return createGlobalBuff({
        id = "double_health_buff",
        name = "Double health",
        abilities = {
            createAbility({
                id = "double_health_effect",
                trigger = startOfGameTrigger,
                effect = ef
            })
        }
    })
end

function setupGame(g)
    -- register newly created cards for further use
    -- no need to register overridden cards, like shining breastplate here
    registerCards(g, {
        orc_guardian_carddef()
    })

    -- startardSetup function accepts a table with all data required to set the game up
    standardSetup(g, {
        -- script description - displayed in in-game menu
        description = "Custom no heroes game",
        -- order in which players take turns
        playerOrder = { plid1, plid2 },
        -- sets AI for ai players
        ai = createHardAi(),
        -- if true, randomizes players order
        randomOrder = true,
        -- pairs of opponents
        opponents = { { plid1, plid2 } },
        -- specify up to 5 cards to appear in the center row at the start of the game
        centerRow = { "arkus__imperial_dragon", "fire_bomb", "grak__storm_giant", "tyrannor__the_devourer", "domination" },
        -- this allows to change market deck.
        tradeDeckExceptions = {
            -- here we set 0 quantity for cards we added to center row, so they don't appear in market deck
            { qty = 0, cardId = "arkus__imperial_dragon" },
            { qty = 0, cardId = "fire_bomb" },
            { qty = 0, cardId = "grak__storm_giant" },
            { qty = 0, cardId = "tyrannor__the_devourer" },
            { qty = 0, cardId = "domination" },
            -- and 3 orc guardians go into deck
            { qty = 3, cardId = "orc_guardian" },
        },
        -- set to true if you don't want trade deck
        noTradeDeck = false,
        -- set to true if you don't want fire gems
        noFireGems = false,
        -- array of players
        players = {
            {
                -- sets up id for the player. options are plid1, plid2, plid3, plid4
                id = plid1,
                -- sets how many cards player draws at the start of the game. If not set, first player will draw 3, second player - 5
                -- commented out as we have random order enabled.
                -- startDraw = 3,
                -- sets how hero get initialized
                init = {
                    -- takes hero data from the selection (VS AI or Online)
                    fromEnv = plid1
                },
                -- cards allows to add any cards to any of hero location at the start of the game
                cards = {
                    buffs = {
                        -- mandatory card: discards cards at the end of turn and draws next hand
                        drawCardsAtTurnEndDef(),
                        -- mandatory card: processes discards at the start of turn
                        discardCardsAtTurnStartDef(),
                        -- grants increased by 1 combat starting from turn 40
                        fatigueCount(40, 1, "FatigueP1"),
                        -- custom buff we created to double health
                        doubleHealthBuffDef()
                    }
                }
            },
            {
                id = plid2,
                -- should always be true for player 2 when playing around with local scripts
                isAi = true,
                -- startDraw = 5,
                name = "AI",
                -- sets avatar for the player
                avatar = "assassin",
                -- starting health
                health = 500,
                -- if not set - equals to starting health
                maxHealth = 500,
                -- you may also set cards for "hand", "inPlay", "discard", "skills"
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


function setupMeta(meta)
    meta.name = "ExampleVsAI"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/timot/HR scripts/ExampleVsAI.lua"
     meta.features = {
}

end