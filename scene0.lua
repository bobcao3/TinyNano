-- ============================================================================
-- Scene configuration
-- ----------------------------------------------------------------------------
-- Scene 1: The mushroom forest
-- ============================================================================

local scene = {
    background_img = "Art/L0-Original.png",
    characters = {
        nano = "Art/Nano.png",
        panda = "Art/Panda.png",
        teacup = "Art/Teacup.png",
        paper = "Art/Pieces/Level0Rock-Paper-Scissor/L0-Paper.png",
        rock = "Art/Pieces/Level0Rock-Paper-Scissor/L0-RockGreen.png",
        scissor = "Art/Pieces/Level0Rock-Paper-Scissor/L0-Scissor.png",
    },
    pieces = {
        knight = {
            image = "strong_mushroom.png",
            portrait_img = "Art/Pieces/Level1Mushroom/L1-KnightGreen.png",
            portrait_img_enemy = "Art/Pieces/Level1Mushroom/L1-KnightRed.png",
            name = "Chunky",
            desc = "",
            max_hp = 80,
            atk = 15,
            def = 3,
            atk_cd = 7.5,
            move_cd = 5.5,
            allowed_moves = {
                { x = -2, y = 0 },
                { x = -1, y = 0 },
                { x = 1, y = 0 },
                { x = 2, y = 0 },
                { x = 0, y = 0 },
                { x = 0, y = -2 },
                { x = 0, y = -1 },
                { x = 0, y = 1 },
                { x = 0, y = 2 }
            },
            allowed_attacks = {
                { x = -1, y = 0 },
                { x = 1, y = 0 },
                { x = 0, y = -1 },
                { x = 0, y = 1 },
            }
        },
        archer = {
            image = "archer_mushroom.png",
            portrait_img = "Art/Pieces/Level1Mushroom/L1-ArcherGreen.png",
            portrait_img_enemy = "Art/Pieces/Level1Mushroom/L1-ArcherRed.png",
            name = "Poison",
            desc = "",
            max_hp = 35,
            atk = 11,
            def = 0,
            atk_cd = 4.0,
            move_cd = 4.0,
            allowed_moves = {
                { x = -1, y = 0 },
                { x = 1, y = 0 },
                { x = 0, y = 0 },
                { x = 0, y = -1 },
                { x = 0, y = 1 },
            },
            allowed_attacks = {
                { x = -2, y = 0 },
                { x = -1, y = -1 },
                { x = 0, y = -2 },
                { x = 1, y = -1 },
                { x = 2, y = 0 },
                { x = 1, y = 1 },
                { x = 0, y = 2 },
                { x = -1, y = 1 },
            },
            bonus = {
                { target = 'pointy', multiplier = 2.0 }
            }
        },
        pointy = {
            image = "pointy_mushroom.png",
            portrait_img = "Art/Pieces/Level1Mushroom/L1-SpearGreen.png",
            portrait_img_enemy = "Art/Pieces/Level1Mushroom/L1-SpearRed.png",
            name = "Sharp",
            desc = "",
            max_hp = 50,
            atk = 9,
            def = 0,
            atk_cd = 5.5,
            move_cd = 3.5,
            allowed_moves = {
                { x = -1, y = 0 },
                { x = 1, y = 0 },
                { x = 0, y = 0 },
                { x = 0, y = -1 },
                { x = 0, y = 1 },
            },
            allowed_attacks = {
                { x = -1, y = 0 },
                { x = 1, y = 0 },
                { x = 0, y = -1 },
                { x = 0, y = 1 },
            },
            bonus = {
                { target = 'knight', multiplier = 2.5 }
            }
        },
        healer = {
            image = "healer_mushroom.png",
            portrait_img = "Art/Pieces/Level1Mushroom/L1-HealerGreen.png",
            portrait_img_enemy = "Art/Pieces/Level1Mushroom/L1-HealerRed.png",
            name = "Fine",
            desc = "",
            max_hp = 50,
            atk = 0,
            def = 1,
            atk_cd = 5.5,
            move_cd = 3.0,
            allowed_moves = {
                { x = -1, y = 0 },
                { x = 1, y = 0 },
                { x = 0, y = 0 },
                { x = 0, y = -1 },
                { x = 0, y = 1 },
            },
            allowed_attacks = {
            }
        }
    },
    initial_pieces = {
        enemy = {
            { type = "pointy", x = 7, y = 4 },
        },
        friendly = {
            { type = "pointy", x = 7, y = 7 },
        }
    }
}

return scene
