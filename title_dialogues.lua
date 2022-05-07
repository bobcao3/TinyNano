local dialogue_state = 'final'

local dialogues = {
    final = {
        message = "",
        choice = {
            {
                target = 'scene_scene0',
                text = "                         Start Game                         "
            }
        },
        character_center = 'nano',
        bright_background = true
    }
}

return dialogue_state, dialogues
