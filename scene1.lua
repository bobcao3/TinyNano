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
            atk_cd = 3.5,
            move_cd = 2.5,
        }
    },
    initial_pieces = {
        friendly = {
            { type = "A", x = 5, y = 5 }
        },
        enemy = {
            { type = "A", x = 3, y = 3 }
        }
    }
}

return scene
