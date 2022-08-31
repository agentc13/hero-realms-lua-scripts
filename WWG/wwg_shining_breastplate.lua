require 'herorealms'
require 'decks'
require 'stdlib'
require 'stdcards'
require 'hardai'
require 'mediumai'
require 'easyai'

function cleric_shining_breastplate_carddef()
    local cardLayout = createLayout({
        name = "Shining Breastplate",
        art = "icons/cleric_shining_breastplate",
        frame = "frames/Cleric_armor_frame",
        text = "Elite<br><voffset=1em><space=-3.7em><voffset=0.2em><size=200%><sprite name=\"expend\"></size></voffset><pos=30%> <voffset=0.5em><line-height=40><space=-3.7em>Stun a<br>champion</voffset></voffset>"
    })

    return createMagicArmorDef({
        id = "cleric_shining_breastplate",
        name = "Shining Breastplate",
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

function setupGame(g)
    -- startardSetup function accepts a table with all data required to set the game up
    standardSetup(g, {
        description = "Shining Breastplate experiment", -- script description - displayed in in-game menu
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
                    }
                }
            },
            {
                id = plid2,
                isAi = true,
                startDraw = 5,
                name = "Meta Cleric",
                avatar = "cleric_alt_02", -- sets avatar for the player
                health = 62, -- starting heath
                cards = { -- you may also set cards for "hand", "inPlay", "discard", "skills"
                    deck = {
                        { qty = 1, card = cleric_follower_a_carddef() },
                        { qty = 1, card = cleric_follower_b_carddef() },
                        { qty = 1, card = cleric_prayer_beads_carddef() },
                        { qty = 1, card = cleric_spiked_mace_carddef() },
                        { qty = 1, card = cleric_everburning_candle_carddef() },
                        { qty = 1, card = cleric_redeemed_ruinos_carddef() },
                        { qty = 1, card = cleric_talisman_of_renewal_carddef() },
                        { qty = 4, card = gold_carddef() },
                    },
                    skills = {
                        cleric_mass_resurrect_carddef(),
                        cleric_bless_the_flock_carddef(),
                        cleric_shining_breastplate_carddef()
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


function setupMeta(meta)
    meta.name = "Shining breastplate"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/timot/HR scripts/Shining breastplate.lua"
     meta.features = {
}

end