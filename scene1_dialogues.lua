local dialogue_state = 'intro'

local dialogues = {
    intro = {
        message = "You woke up in a weird place...{{ ",
        choice = {
        },
        bright_background = true,
        auto_progress = 'a'
    },
    a = {
        message = "You seem to have lost the panda.",
        choice = {
            {
                target = 'b',
                text = [[
Nano: Where is this place?
      I have never seen glowing mushrooms before.]]
            }
        },
        bright_background = true
    },
    b = {
        message = "Stranger: hehehe",
        choice = {
            {
                target = 'c',
                text = "Nano: Who is there?"
            },
            {
                target = 'c',
                text = "Nano: I know you're hiding."
            },
            {
                target = 'c',
                text = "Nano: Panda, is that you?"
            }
        }
    },
    c = {
        message = "Stranger: I am the famous Tea Cup, Chip. ",
        choice = {
            {
                target = 'd',
                text = "Nano: Where is this place?"
            },
            {
                target = 'd',
                text = [[
Nano: Chip? Are you famous?
      I never heard of you.]]
            },
            {
                target = 'd',
                text = [[
Nano: I never met anyone famous before!
      Nice to meet you.]]
            }
        }
    },
    d = {
        message = "Chip: You are not from around here, are you?",
        choice = {
            {
                target = 'e',
                text = "Nano: No, can you tell me where the panda went?"
            },
            {
                target = 'e',
                text = "Nano: I am from a different forest far from here."
            },
            {
                target = 'e',
                text = "Nano: ..."
            }
        }
    },
    e = {
        message = [[
Chip: It must be a trap of the Panda that you're lost in
      this place.]],
        choice = {
            {
                target = 'f',
                text = "Nano: ..."
            }
        }
    },
    f = {
        message = [[
Chip: That Panda is one of a kind who tried to lock me up in
      the mysterious castle countless times.]],
        choice = {
            {
                target = 'g',
                text = "Nano: ..."
            }
        }
    },
    g = {
        message = "Chip: Don't be fooled by that Panda.",
        choice = {
            {
                target = 'poison',
                text = "Nano: I don't trust you. Panda seems nice."
            },
            {
                target = 'sharp',
                text = [[
Nano: It all makes sense now! That is why I am trapped in
      this strange forest.]]
            },
            {
                target = 'chunky',
                text = "Nano: ..."
            }
        }
    },
    poison = {
        message = [[
Chip: Anyways. Trust me, that Faceless one is really
      something you should avoid at all costs.
      Someone like me should not be wasting my time at this
      boring Mushroom Forest.
      Here, take these.]],
        choice = {
            {
                target = 'poison_desc',
                text = "You received some Poison Mushrooms.",
                trigger = function(board)
                    board:add_piece('archer', 'friendly', 5, 9)
                    board:add_piece('archer', 'friendly', 6, 9)
                end
            }
        }
    },
    poison_desc = {
        message = [[
Chip: A Poison Mushroom is a mushroom that is scary looking
      from a distance and spits poison from two distances
      away. It doesn't seem very strong up-close.]],
        choice = {
            {
                target = 'panda',
                text = "Nano: Dangerous and interesting looking mushrooms!"
            }
        }
    },    
    sharp = {
        message = [[
Chip: Anyways. Trust me, that Faceless one is really something
      you should avoid at all costs.
      Someone like me should not be wasting my time at this
      boring Mushroom Forest.
      Here, take these.]],
        choice = {
            {
                target = 'sharp_desc',
                text = "You received some Sharp Mushrooms",
                trigger = function(board)
                    board:add_piece('pointy', 'friendly', 5, 9)
                    board:add_piece('pointy', 'friendly', 6, 9)
                end
            }
        }
    },
    sharp_desc = {
        message = [[
Chip: A Sharp Mushroom is a mushroom that is very sharp and grows
      really tall, it seems to always be moving at a fast, making
      quite some damage.]],
        choice = {
            {
                target = 'panda',
                text = "Nano: Wow, these mushrooms are so sharp!"
            }
        }
    },
    chunky = {
        message = [[
Chip: Anyways. Trust me, that Faceless one is really something
      you should avoid at all costs.
      Someone like me should not be wasting my time at this
      boring Mushroom Forest.
      Here, take these.]],
        choice = {
            {
                target = 'chunky_desc',
                text = "You received some Chunky Mushrooms.",
                trigger = function(board)
                    board:add_piece('knight', 'friendly', 5, 9)
                    board:add_piece('knight', 'friendly', 6, 9)
                end
            }
        }
    },
    chunky_desc = {
        message = [[
Chip: A Sharp Mushroom is a mushroom that is very sharp and grows
      really tall, it seems to always be moving at a fast, making
      quite some damage.]],
        choice = {
            {
                target = 'panda',
                text = "Nano: These mushrooms are so heavy!"
            }
        }
    },
    panda = {
        message = "Panda appear.",
        choice = {
            {
                target = 'exchange',
                text = "Chip: Chip: uh. Speak of the devil. Look at who is here? \n I am leaving this place now."
            }
        }
    },
    exchange = {
        message = [[
Panda: Nano! I was looking for you. It seems like Chip gave
       you a Mushroom?
       I have a better mushroom.
       Do you want to trade with me?]],
        choice = {
            {
                target = 'yes',
                text = "Nano: Sure, I will trade with you."
            },
            {
                target = 'no',
                text = "Nano: No, I want to keep these."
            }
        }
    },
    yes = {
        message = [[
Panda: Here just take this.
        A Fine Mushroom is shiny can often heal other mushrooms
       around it. I will let you explore the forest, and come
       find me at the House of Fairy when you're ready, ok?]],
        choice = {
            {
                target = 'sleep',
                text = "You received a Fine Mushroom. ",
                trigger = function (board)
                    board:add_piece('healer', 'friendly', 7, 9)
                end
            }
        }
    },
    no = {
        message = [[
Panda: No worries, it's ok if you want to keep your mushroom from Chip.
       Come find me at the House of Fairy when you need me.]],
        choice = {
            {
                target = 'sleep',
                text = "Panda disappeared."
            }
        }
    },
    sleep = {
        message = [[
The Mushroom Forest is quiet.
You sit down and try to reflect on what has happened thus far.
You fall asleep.{}]],
        choice = {
        },
        auto_progress = 'summon'
    },
    summon = {
        message = "You have been summoned{{",
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
