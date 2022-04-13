-- ============================================================================
-- Scene configuration
-- ----------------------------------------------------------------------------
-- Scene 1: The mushroom forest
-- ============================================================================

local scene = {
    background_img = "scene0_bg.jpg",
    pieces = {
        A = {
            image = "strong_mushroom.png",
            portrait_img = "unit_portrait.png",
            name = "A Mushroom",
            desc = "Place holder mushroom A",
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
        }
    },
    initial_pieces = {
        friendly = {
            { type = "A", x = 5, y = 2 },
            { type = "A", x = 6, y = 2 },
            { type = "A", x = 7, y = 2 },
        },
        enemy = {
            { type = "A", x = 5, y = 9 },
            { type = "A", x = 6, y = 9 },
            { type = "A", x = 7, y = 9 },
        }
    }
}

return scene
