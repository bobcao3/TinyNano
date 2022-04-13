-- ============================================================================
-- Scene configuration
-- ----------------------------------------------------------------------------
-- Scene 1: The mushroom forest
-- ============================================================================

local scene = {
    background_img = "scene1_bg.png",
    pieces = {
        knight = {
            image = "strong_mushroom.png",
            portrait_img = "unit_portrait.png",
            name = "Chunky",
            desc = "",
            max_hp = 80,
            atk = 9,
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
            portrait_img = "unit_portrait.png",
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
            }
        },
        pointy = {
            image = "pointy_mushroom.png",
            portrait_img = "unit_portrait.png",
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
            }
        },
        healer = {
            image = "healer_mushroom.png",
            portrait_img = "unit_portrait.png",
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
            { type = "knight", x = 5, y = 2 },
            { type = "knight", x = 6, y = 2 },
            { type = "pointy", x = 7, y = 2 },
        },
        friendly = {
            { type = "healer", x = 5, y = 9 },
            { type = "pointy", x = 6, y = 9 },
            { type = "archer", x = 7, y = 9 },
        }
    }
}

return scene
