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
        boss = "Art/Boss.png",
        paper = "Art/Pieces/Level0Rock-Paper-Scissor/L0-Paper.png",
        rock = "Art/Pieces/Level0Rock-Paper-Scissor/L0-RockGreen.png",
        scissor = "Art/Pieces/Level0Rock-Paper-Scissor/L0-Scissor.png",
    },
    pieces = {
        rock = {
            image = "rock.png",
            portrait_img = "Art/Pieces/Level0Rock-Paper-Scissor/L0-RockGreen.png",
            portrait_img_enemy = "Art/Pieces/Level0Rock-Paper-Scissor/L0-RockRed.png",
            name = "Rock",
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
                { x = -1, y = 0 },
                { x = 1, y = 0 },
                { x = 0, y = -1 },
                { x = 0, y = 1 },
            },
            bonus = {
                { target = 'scissor', multiplier = 2.0 }
            }
        },
        paper = {
            image = "paper.png",
            portrait_img = "Art/Pieces/Level0Rock-Paper-Scissor/L0-PaperGreen.png",
            portrait_img_enemy = "Art/Pieces/Level0Rock-Paper-Scissor/L0-PaperRed.png",
            name = "Paper",
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
                { x = -1, y = 0 },
                { x = 1, y = 0 },
                { x = 0, y = -1 },
                { x = 0, y = 1 },
            },
            bonus = {
                { target = 'rock', multiplier = 2.0 }
            }
        },
        scissor = {
            image = "scissor.png",
            portrait_img = "Art/Pieces/Level0Rock-Paper-Scissor/L0-ScissorGreen.png",
            portrait_img_enemy = "Art/Pieces/Level0Rock-Paper-Scissor/L0-ScissorRed.png",
            name = "Scissor",
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
                { x = -1, y = 0 },
                { x = 1, y = 0 },
                { x = 0, y = -1 },
                { x = 0, y = 1 },
            },
            bonus = {
                { target = 'paper', multiplier = 2.0 }
            }
        }
    },
    initial_pieces = {
        enemy = {
            { type = "rock", x = 6, y = 4 },
            { type = "scissor", x = 7, y = 4 },
        },
        friendly = {
            { type = "paper", x = 7, y = 7 },
            { type = "rock", x = 8, y = 8 },
        }
    }
}

return scene
