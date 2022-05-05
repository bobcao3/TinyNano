local dialogue_state = 'final'

local dialogues = {
    final = {
        message = "You have defeated night shade.     ",
        choice = {
            {
                target = 'final',
                text = "Nano: Yay!"
            }
        },
        bright_background = true
    }
}

return dialogue_state, dialogues
