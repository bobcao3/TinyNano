local dialogue_state = 'final'

local dialogues = {
    final = {
        message = "The bright light wakes you up."   
,
        choice = {
        },
        bright_background = true,
        auto_progress = 'a'
    },
    a = {
        message = "You look around the surrounding...",
            character_bottom = "nano",
        choice = {
            {
                target = 'b',
                text = "Nano: First, mushroom forest, and now is this? A … garden?"
            }
        },
        bright_background = true
    },
    b = {
        message = [[
Nano: These flowers reminded me of the mushroom pieces
     from the battle. 
    I should probably keep it.]],
    character_bottom = "nano",
        choice = {
            {
                target = 'c',
                text = "Pick up the Rose and Lily"
                trigger = function(board)
                    board:add_piece('pointy', 'friendly', 5, 9)
                    board:add_piece('knight', 'friendly', 6, 9)
                end
            },
            {
                target = 'c',
                text = "Pick up the Lily and Lily of the Valley"
                trigger = function(board)
                    board:add_piece('knight', 'friendly', 5, 9)
                    board:add_piece('archer', 'friendly', 6, 9)
                end
            },
            {
                target = 'c',
                text = "Pick up the Rose and Lily of the valley"
                trigger = function(board)
                    board:add_piece('archer', 'friendly', 5, 9)
                    board:add_piece('pointy', 'friendly', 6, 9)
                end
            }
        }
    },
    c = {
        message = "You notice the castle in the back.",
        character_bottom = "nano",
        choice = {
            {
                target = 'd',
                text = [[
Nano: This must be the mysterious castle Chip mentioned. 
      It indeed is mysterious.]]
            }
        }
    },
    d = {
        message = "You see someone familiar.",
        character_bottom = "nano",
        choice = {
            {
                target = 'e',
                text = "Nano: Panda? What are you doing here?"
            }
        }
    },
    e = {
        message = "Panda: I am here to help you escape.",
            character_top = "panda",
            character_bottom = "nano",
        choice = {
            {
                target = 'f',
                text = "Nano: Escape? What do you know about this world?"
            },
            {
                target = 'f',
                text = "Nano: Please help me. "
            },
            {
                target = 'f',
                text = [[
Nano: How do I know if you are not trying to 
        trap me like the way you did to Chip? 
                ]]
            }
        }
    },
    f = {
        message = [[
 Panda: I do not have much time to explain.
    Take these DAISY and ROSE before Nightshade returns.
        ]],
        choice = {
            {
                target = 'g',
                text = "Nano: What? Nightshade is coming?"
                trigger = function(board)
                    board:add_piece('pointy', 'friendly', 4, 9)
                    board:add_piece('healer', 'friendly', 7, 9)
                end
            }
        }
    },
    g = {
        message = [[
Panda: After all, this is its home. 
    After what happened to their family, 
    Nightshade could never let go and become the way it is now...
        ]],
        choice = {
            {
                target = 'h',
                text = "Nano: What about what happened to Chip?"
            }
        }
    },
    h = {
        message = [[
Panda: That is is a long story. 
    Chip did not know about the truth… 
    Nano, you have to trust me. 
        ]],
        choice = {
            {
                target = 'i',
                text = "Nano: I am so confused."
            }
        }
    },
    i = {
        message = [[
Nightshade appeared
Nightshade: Look at who is here? 
    Nano is still looking as lost as ever.
        ]],
        choice = {
            {
                target = 'advance',
                text = "Nano: Oh No."
            }
        }
    },
    advance = {
        message = [[
Panda: Fight and escape before it is too late. 
Nightshade: Nano, you think I will let you go? 
    It looks like someone needs a lesson. {}]],
        choice = {
        },
        auto_progress = 'summon'
    },
    summon = {
        message = "You have been summoned to battle{{",
            character_center = "boss",
        choice = {},
        bright_background = true,
        auto_progress = 'start'
    },
    start = {
        message = "",
        choice = {},
        bright_background = true,
        auto_progress = 'start'
    }
}

return dialogue_state, dialogues
