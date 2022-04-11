-- ============================================================================
-- Scene configuration
-- ----------------------------------------------------------------------------
-- Scene 1: The mushroom forest
-- ============================================================================

local scene = {
    background_img = "scene1_bg.png",
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
        }
    },
    initial_pieces = {
        friendly = {
            { type = "A", x = 5, y = 2 },
            { type = "A", x = 6, y = 2 },
            { type = "A", x = 7, y = 2 },
            { type = "A", x = 8, y = 2 },
            { type = "A", x = 9, y = 2 },
        },
        enemy = {
            { type = "A", x = 5, y = 9 },
            { type = "A", x = 6, y = 9 },
            { type = "A", x = 7, y = 9 },
            { type = "A", x = 8, y = 9 },
            { type = "A", x = 9, y = 9 },
        }
    }
}

return scene
