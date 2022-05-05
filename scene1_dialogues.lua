local dialogue_state = 'intro'

local dialogues = {
    intro = {
        message = [[
Panda: Nano, it is time to wake up. You cannot sleep here.
       Oh, it seems like you are not ready to wake up yet.
       Don't move and wait for me here, ok?
        ]],
        choice = {
        },
        bright_background = true,
        auto_progress = 'a'
    },
    a = {
        message = [[You woke up and started to look for Panda. 
    There is no one around. ]],
        character_bottom = "nano",
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
        character_top = "teacup",
        character_bottom = "nano",
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
        message = "Stranger: I am the famous Tea Cup, Chip.",
        character_top = "teacup",
        character_bottom = "nano",
        choice = {
            {
                target = 'd',
                text = "Nano: You are a teacup?"
            },
            {
                target = 'd',
                text = [[
Nano: Chip? Famous?
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
        message = "Chip: You are so tiny. You must be from somewhere else?",
        character_top = "teacup",
        character_bottom = "nano",
        choice = {
            {
                target = 'e',
                text = "Nano: Can you please just tell me where the panda went?"
            },
            {
                target = 'e',
                text = "Nano: I am from a different land far from here."
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
        character_top = "teacup",
        character_bottom = "nano",
        choice = {
            {
                target = 'f',
                text = "Nano: What do you mean?"
            }
        }
    },
    f = {
        message = [[
Chip: That Panda is one of a kind who tried to lock me up in
      the Mysterious Castle countless times.]],
        character_top = "teacup",
        character_bottom = "nano",
        choice = {
            {
                target = 'g',
                text = "Nano: Mysterious Castle?"
            }
        }
    },
    g = {
        message = "Chip: Don't be fooled by that Panda.",
        character_top = "teacup",
        character_bottom = "nano",
        choice = {
            {
                target = 'poison',
                text = "Nano: Panda seems to look after me. Why should I trust you?"
            },
            {
                target = 'sharp',
                text = [[
Nano: Is that why I saw Panda before I got lost here? 
      It all makes sense now! ]]
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
      Here, take these. 
      I can try to be a nice person for my new tiny friend.]],
        character_top = "teacup",
        character_bottom = "nano",
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
        character_top = "teacup",
        character_center = "archer",
        character_bottom = "nano",
        choice = {
            {
                target = 'panda',
                text = "Nano: Why are you giving me thses dangerous mushrooms?"
            }
        }
    },    
    sharp = {
        message = [[
Chip: Anyways. Trust me, that Faceless one is really
    something you should avoid at all costs.
    Here, take these. 
    I can try to be a nice person for my new tiny friend.]],
        character_top = "teacup",
        character_bottom = "nano",
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
Chip: A Sharp Mushroom is a mushroom that is very sharp and 
      grows really tall, it seems to always be moving at 
      a fast speed, making quite some damage.]],
        character_top = "teacup",
        character_center = "spear",
        character_bottom = "nano",
        choice = {
            {
                target = 'panda',
                text = "Nano: Wow, these mushrooms are so sharp!"
            }
        }
    },
    chunky = {
        message = [[
Chip: Anyways. Trust me, that Faceless one is really
    something you should avoid at all costs.
    Here, take these. 
    I can try to be a nice person for my new tiny friend.]],
        character_top = "teacup",
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
Chip: A Chunky Mushroom is heavy and chunky mushroom 
      that accidentally grown too large, 
      doesn't seem to move very fast,
      but sure has a lot of health.]],
        character_top = "teacup",
        character_center = "knight",
        character_bottom = "nano",
        choice = {
            {
                target = 'panda',
                text = "Nano: These mushrooms are so heavy!"
            }
        }
    },
    panda = {
        message = [[
Panda appear.
Chip: uh. Speak of the devil. 
      Look at who is here? I am leaving this place now.]],
        character_top = "panda",
        character_bottom = "nano",
        choice = {
            {
                target = 'panda_talk',
                text = 
                [[
Nano: Panda, why did you left me in this weird place?
      Is everything just a dream?]]
            }
        }
    },
    panda_talk = {
        message = [[
Chip disappeared. 
Panda: Nano! I was looking for you. Is everything alright?
       This is not just a dream, 
       Nano. You don't remember what happened?]],
        character_top = "panda",
        character_bottom = "nano",
        choice = {
            {
                target = 'exchange',
                text = "Nano: I cannot remember anything."
            }
        }
    },
    exchange = {
        message = [[
Panda: You will remember when the time comes.
       Oh, it seems like Chip gave you some mushrooms? 
       I have some better ones, do you want to trade?]],
        character_top = "panda",
        character_bottom = "nano",
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
       I am running out of preperation time.
       A Fine Mushroom is shiny can often heal other mushrooms
       around it. I am sure we will meet again!]],
        character_top = "panda",
        character_center = "healer",
        character_bottom = "nano",
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
Panda: I have to get going. 
       I am running out of time for preperation.
       I am sure we will meet again!]],
        character_top = "panda",
        character_bottom = "nano",
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
You feel the strage atmosphere approaching.{}]],
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
