local dialogue_state = 'a'

local dialogues = {
    a = {
        message = "place-holder thingy here pls click\n buttons",
        choice = {
            {
                target = 'b',
                text = "Show other thing"
            },
            {
                target = 'start',
                text = "Nah do the game"
            }
        }
    },
    b = {
        message = "another thingy here pls click buttons",
        choice = {
            {
                target = 'a',
                text = "Show the other thing"
            },
            {
                target = 'start',
                text = "sure do the game"
            }
        }
    },
    start = {
        message = "starting game",
        choice = {}
    }
}

return dialogue_state, dialogues
