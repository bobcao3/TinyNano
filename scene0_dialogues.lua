local dialogue_state = 'tutorial'

local dialogues = {
    tutorial = {
        message = [[
There is darkness, and something feels off about this body.
The atmosphere is so tense. 
A strong presence appeared, 
and everything seemed off about this character.    
        ]],
        choice = {
        },
        bright_background = true,
        auto_progress = 'a'
    },
    a = {
        message = "Nightshade: Welcome to my world, Nano.",
            character_top = "boss",
            character_bottom = "nano",
        choice = {
            {
                target = 'b',
                text = "Nano: Nano? Is that my name? I cannot remember anything."
            }
        },
        bright_background = true
    },
    b = {
        message = "Nightshade:I shall not let you escape this time.",
            character_top = "boss",
            character_bottom = "nano",
        choice = {
            {
                target = 'c',
                text = "Nano: Have I been here before?"
            },
            {
                target = 'c',
                text = "Nano: Escape from what?"
            },
            {
                target = 'c',
                text = "Nano: I am not scared of you."
            }
        }
    },
    c = {
        message = [[
Nightshade: Be careful to choose your responses wisely, 
    or you shall face the consequences. 
        ]],
            character_top = "boss",
            character_bottom = "nano",
        choice = {
            {
                target = 'd',
                text = "Nano: Whatever that means does not sound positive." 
            },
            {
                target = 'd',
                text = "Nano: Ummm, ok?"
            },
            {
                target = 'd',
                text = "Nano: Let me out of this place."
            }
        }
    },
    d = {
        message = [[
Nightshade: In this world, I make the rules.
    Nano, entertain me. Show me what you got.]],
            character_top = "boss",
            character_bottom = "nano",
        choice = {
            {
                target = 'e',
                text = "Nano: What is going on?"
            },
            {
                target = 'e',
                text = "Nano: Bring it on!"
            },
            {
                target = 'e',
                text = "Nano: Wait, I recognize the weird shpaes behind you."
            }
        }
    },
    e = {
        message = [[
Nightshade: Here, take this piece and place it on the board.
     Look at you being so lost. 
    I will give you a hint that each piece 
    has a different ability.]],
            character_top = "boss",
            character_bottom = "nano",
        choice = {
            {
                target = 'f',
                text = "Nano: Different abilities? Interesting."
            }
        }
    },
    f = {
        message = [[
Nightshade: I hope you would not disappoint me 
    and end the fun so fast.]],
        character_top = "boss",
        character_bottom = "nano",
        choice = {
            {
                target = 'g',
                text = "Nano: How do I know about their abilities? "
            }
        }
    },
    g = {
        message = [[
Nightshade: You can manage the pieces 
    by looking at the botton right dashboard.]],
        character_top = "boss",
        character_bottom = "nano",
        choice = {
            {
                target = 'advance',
                text = "Nano: I am ready to battle and get out of this place!"
            }
        }
    },
    advance = {
        message = [[
Nightshade: Now, let the show begin. 
You feel the strage atmosphere approaching.{}]],
    character_top = "boss",
    character_bottom = "nano",
        choice = {
        },
        auto_progress = 'summon'
    },
    summon = {
        message = "You have been summoned{{",
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
