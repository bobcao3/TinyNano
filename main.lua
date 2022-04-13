-- local console_toggle = require("love2d-console.console.console")

function love.textinput(text)
    -- console_toggle(text)
end

function set_color_white(shade)
    if shade == 4 then
        love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, 1)
    elseif shade == 3 then
        love.graphics.setColor(191 / 255, 191 / 255, 191 / 255, 1)
    elseif shade == 2 then
        love.graphics.setColor(128 / 255, 128 / 255, 128 / 255, 1)
    elseif shade == 1 then
        love.graphics.setColor(64 / 255, 64 / 255, 64 / 255, 1)
    else
        love.graphics.setColor(0 / 255, 0 / 255, 0 / 255, 1)
    end
end

function set_color_red(shade)
    if shade == 4 then
        love.graphics.setColor(235 / 255, 70 / 255, 61 / 255, 1)
    elseif shade == 3 then
        love.graphics.setColor(210 / 255, 55 / 191, 37 / 255, 1)
    elseif shade == 2 then
        love.graphics.setColor(147 / 255, 50 / 255, 33 / 255, 1)
    elseif shade == 1 then
        love.graphics.setColor(92 / 255, 41 / 255, 27 / 255, 1)
    else
        love.graphics.setColor(45 / 255, 25 / 255, 17 / 255, 1)
    end
end

function set_color_blue(shade)
    if shade == 4 then
        love.graphics.setColor(93 / 255, 181 / 255, 249 / 255, 1)
    elseif shade == 3 then
        love.graphics.setColor(70 / 255, 151 / 191, 230 / 255, 1)
    elseif shade == 2 then
        love.graphics.setColor(56 / 255, 115 / 255, 172 / 255, 1)
    elseif shade == 1 then
        love.graphics.setColor(44 / 255, 83 / 255, 121 / 255, 1)
    else
        love.graphics.setColor(32 / 255, 54 / 255, 76 / 255, 1)
    end
end

-- ============================================================================
-- Game States
-- ============================================================================

res_x = 384
res_y = 216

pixel_scale = 3

board = {
    base_x = 30,
    base_y = 21,
    tiles_x = 10,
    tiles_y = 10,
    tile_size = 16,
    state = {}
}

cursor = {
    window_x = 0, window_y = 0,
    x = 0, y = 0,
    selected = { x = 0, y = 0 }
}

pieces = {}

pickedup = {}

transition = 0
board_started = false
start_board = false

-- ============================================================================
-- Game Logic
-- ============================================================================

-- Get cursor location, compute pixel location, and compute location on board
function update_cursor()
    cursor.window_x = love.mouse.getX()
    cursor.window_y = love.mouse.getY()

    cursor.x = math.floor(love.mouse.getX()) / pixel_scale
    cursor.y = math.floor(love.mouse.getY()) / pixel_scale

    if cursor.x >= board.base_x and cursor.y >= board.base_y and
       cursor.x < board.base_x + board.tiles_x * board.tile_size and
       cursor.y < board.base_y + board.tiles_y * board.tile_size then
        cursor.selected.x = math.floor((cursor.x - board.base_x) / board.tile_size)
        cursor.selected.y = math.floor((cursor.y - board.base_y) / board.tile_size)
    end
end

-- Update next action list
function update_next_action_list()
    local list = {}
    for i = 0, board.tiles_x - 1 do
        for j = 0, board.tiles_y - 1 do
            if not is_cell_empty(i, j) then
                local cd = get_cell_cooldown(i, j)
                cd = cd - love.timer.getDelta()
                if cd < 0 then
                    cd = 0
                end
                board.state[i + 1][j + 1].cooldown = cd
                table.insert(list, {x = i, y = j, cooldown = cd})
            end
        end
    end
    table.sort(list, function (k1, k2) return k1.cooldown < k2.cooldown end)
    next_action_list = list
end

-- Get a cell on the board
function get_cell_type(i, j)
    return board.state[i + 1][j + 1].type
end

function get_cell_hp(i, j)
    return board.state[i + 1][j + 1].hp
end

function get_cell_def(i, j)
    return pieces[get_cell_type(i, j)].def
end

function get_cell_atk(i, j)
    return pieces[get_cell_type(i, j)].atk
end

function kill_cell(i, j)
    if pieces[get_cell_type(i, j)].death_effect then
        pieces[get_cell_type(i, j)].death_effect(board, i, j)
    end
    board.state[i + 1][j + 1] = {}
end

function attack_cell(i, j, dmg)
    local hp = get_cell_hp(i, j)
    local dmg_comp = dmg - get_cell_def(i, j)
    if dmg > 0 and dmg_comp < 1 then
        dmg_comp = 1
    end
    hp = hp - dmg_comp
    if hp <= 0 then
        kill_cell(i, j)
    else
        board.state[i + 1][j + 1].hp = hp
    end
end

function get_cell_team(i, j)
    return board.state[i + 1][j + 1].team
end

function get_cell_cooldown(i, j)
    return board.state[i + 1][j + 1].cooldown
end

-- Check if something exists on the board
function is_cell_empty(i, j)
    if get_cell_type(i, j) then
        return false
    else
        return true
    end
end

-- Select Object
function is_pickedup()
    if pickedup.coord then
        return true
    else
        return false
    end
end

function game_mousepressed(x, y, button)
    if button == 1 then
        if is_pickedup() then
            if action(pickedup.coord.x, pickedup.coord.y, cursor.selected.x, cursor.selected.y) then
                pickedup = {}
            end
        else
            if is_cell_empty(cursor.selected.x, cursor.selected.y) then
                pickedup = {}
            elseif get_cell_cooldown(cursor.selected.x, cursor.selected.y) <= 0 then
                pickedup.coord = {
                    x = cursor.selected.x,
                    y = cursor.selected.y
                }
            end
        end
    end
end

-- Action
function is_move_allowed(from_x, from_y, to_x, to_y)
    if not is_cell_empty(to_x, to_y) then
        return false
    end
    local off_x = to_x - from_x
    local off_y = to_y - from_y
    local type = get_cell_type(from_x, from_y)
    for i, m in ipairs(pieces[type].allowed_moves) do
        if off_x == m.x and off_y == m.y then
            return true
        end
    end
    return false
end

function is_attack_allowed(from_x, from_y, to_x, to_y)
    if is_cell_empty(to_x, to_y) then
        return false
    end
    if get_cell_team(from_x, from_y) == get_cell_team(to_x, to_y) then
        return false
    end
    local off_x = to_x - from_x
    local off_y = to_y - from_y
    local type = get_cell_type(from_x, from_y)
    for i, m in ipairs(pieces[type].allowed_attacks) do
        if off_x == m.x and off_y == m.y then
            return true
        end
    end
    return false
end

function action(from_x, from_y, to_x, to_y)
    if not is_cell_empty(from_x, from_y) then
        local pawn = board.state[from_x + 1][from_y + 1]
        if is_attack_allowed(from_x, from_y, to_x, to_y) then
            -- Attack
            attack_cell(to_x, to_y, get_cell_atk(from_x, from_y))
            board.state[from_x + 1][from_y + 1].cooldown = pieces[pawn.type].atk_cd
            board.state[from_x + 1][from_y + 1].last_cooldown = pieces[pawn.type].atk_cd
            return true
        elseif is_move_allowed(from_x, from_y, to_x, to_y) then
            -- Move
            pawn.cooldown = pieces[pawn.type].move_cd
            pawn.last_cooldown = pieces[pawn.type].move_cd
            board.state[from_x + 1][from_y + 1] = {}
            board.state[to_x + 1][to_y + 1] = pawn
            return true
        else
            return false
        end
end

    return false
end

-- Draw the circular cursor on the window
function draw_cursor()
    set_color_white(2)
    love.graphics.circle("line", cursor.window_x + 1, cursor.window_y + 1, 7)
    set_color_white(4)
    love.graphics.circle("line", cursor.window_x, cursor.window_y, 7)
end

-- Draw the background
function draw_background()
    love.graphics.setBackgroundColor(1, 1, 1)
    love.graphics.clear()
    love.graphics.draw(background_img, -384, 0)
end

-- Draw the board

function draw_unit_background(base_x, base_y, border_shade, shade, prog, p)
    if p.type then
        if p.team == 'friendly' then
            set_color_blue(border_shade)
            love.graphics.rectangle(
                'fill',
                base_x,
                base_y,
                board.tile_size,
                board.tile_size)
        else
            set_color_red(border_shade)
            love.graphics.rectangle(
                'fill',
                base_x,
                base_y,
                board.tile_size,
                board.tile_size)
        end
        set_color_white(shade)
        local prog_l = (board.tile_size - 2) * prog
        love.graphics.rectangle(
                'fill',
                base_x + board.tile_size - 1,
                base_y + 1,
                -prog_l,
                board.tile_size - 2)
    else
        set_color_white(shade)
        love.graphics.rectangle(
            'fill',
            base_x,
            base_y,
            board.tile_size,
            board.tile_size)
    end 
end

function draw_unit(base_x, base_y, p)
    if p.type then
        local sprite_used = enemy_sprite
        if p.team == 'friendly' then
            sprite_used = friendly_sprite
        end
        love.graphics.draw(
            pieces[p.type].image,
            sprite_used,
            base_x,
            base_y)
    end
end

function draw_board()
    -- set_color_white(0)
    -- love.graphics.rectangle('fill', board.base_x, board.base_y, board.tile_size * board.tiles_x, board.tile_size * board.tiles_y)
    
    for i = 1, board.tiles_x do
        for j = 1, board.tiles_y do
            local base_x = board.base_x + board.tile_size * (i - 1)
            local base_y = board.base_y + board.tile_size * (j - 1)
            local shade = (i + j) % 2 + 1
            draw_unit_background(base_x, base_y, shade, shade, 0, {})
            if is_pickedup() then
                local p = board.state[pickedup.coord.x + 1][pickedup.coord.y + 1]
                if is_move_allowed(pickedup.coord.x, pickedup.coord.y, i - 1, j - 1) then
                    draw_unit_background(base_x, base_y, 4, shade, 1, p)
                end
            end
        end
    end

    for i, column in ipairs(board.state) do
        for j, p in ipairs(column) do
            local base_x = board.base_x + board.tile_size * (i - 1)
            local base_y = board.base_y + board.tile_size * (j - 1)
            local shade = (i + j) % 2 + 3
            set_color_white(4)
            draw_unit(base_x, base_y, p)
            if is_pickedup() then
                local p = board.state[pickedup.coord.x + 1][pickedup.coord.y + 1]
                if is_attack_allowed(pickedup.coord.x, pickedup.coord.y, i - 1, j - 1) then
                    love.graphics.draw(attack_arrow, base_x, base_y)
                end
            end
        end
    end

    if is_pickedup() then
        if board.state[pickedup.coord.x + 1][pickedup.coord.y + 1].type then
            local p = board.state[pickedup.coord.x + 1][pickedup.coord.y + 1]
            set_color_white(3)
            draw_unit(board.base_x + board.tile_size * cursor.selected.x, board.base_y + board.tile_size * cursor.selected.y, p)
        end
    end
end

-- Draw next action list
function draw_next_action_list()
    for i, a in ipairs(next_action_list) do
        local x = a.x
        local y = a.y
        local p = board.state[x + 1][y + 1]
        local shade = 2
        if p.cooldown <= 0 then
            if math.sin(love.timer.getTime() * 8) > 0 then
                shade = 0
            end 
        end
        local base_x = 30 + (i - 1) * board.tile_size
        local base_y = 184
        draw_unit_background(base_x, base_y, shade, shade, p.cooldown / p.last_cooldown, p)
        set_color_white(4)
        draw_unit(base_x, base_y, p)
    end
end

-- Draw the board cursor
function draw_board_cursor()
    if (is_pickedup() and get_cell_team(pickedup.coord.x, pickedup.coord.y) ~= 'friendly') or
       ((not is_cell_empty(cursor.selected.x, cursor.selected.y)) and
        (get_cell_team(cursor.selected.x, cursor.selected.y) ~= 'friendly')) then
        set_color_red(3)
    else
        set_color_blue(3)
    end
    love.graphics.rectangle(
        'line',
        board.base_x + cursor.selected.x * board.tile_size,
        board.base_y + cursor.selected.y * board.tile_size,
        board.tile_size, board.tile_size)
end

-- Draw
function draw_unit_details()
    if not is_cell_empty(cursor.selected.x, cursor.selected.y) then
        type = get_cell_type(cursor.selected.x, cursor.selected.y)

        local base_x = 193
        local base_y = 136

        set_color_white(3)
        love.graphics.rectangle('fill', base_x, base_y, 64, 64)

        set_color_white(4)
        love.graphics.draw(pieces[type].portrait_img, base_x, base_y)

        set_color_white(1)
        love.graphics.rectangle('fill', base_x + 65, base_y, 95, 64)

        name_text = love.graphics.newText(font14, pieces[type].name)
        hp_text = love.graphics.newText(font14, 
            tostring(get_cell_hp(cursor.selected.x, cursor.selected.y)) .. "/" ..
            tostring(pieces[type].max_hp))
        atk_text = love.graphics.newText(font, "ATK:" .. tostring(pieces[type].atk))
        def_text = love.graphics.newText(font, "DEF:" .. tostring(pieces[type].def))

        base_x = base_x + 67
        base_y = base_y + 2

        set_color_white(2)
        love.graphics.draw(name_text, base_x + 1, base_y + 1)
        set_color_white(4)
        love.graphics.draw(name_text, base_x, base_y)

        if get_cell_team(cursor.selected.x, cursor.selected.y) == 'friendly' then
            set_color_blue(2)
        else
            set_color_red(2)
        end
        love.graphics.draw(hp_text, base_x + 1, base_y + 17)
        if get_cell_team(cursor.selected.x, cursor.selected.y) == 'friendly' then
            set_color_blue(4)
        else
            set_color_red(4)
        end
        love.graphics.draw(hp_text, base_x, base_y + 16)

        set_color_white(3)
        love.graphics.draw(atk_text, base_x, base_y + 32)
        love.graphics.draw(def_text, base_x, base_y + 42)

    end
end

-- Draw the scene
function draw_scene()
    draw_background()
    draw_board()
    draw_next_action_list()
    draw_board_cursor()
    draw_unit_details()
end

-- Update logic
function game_update()
    update_next_action_list()
end

-- Draw dialogue scene
dialogue_state = 0
dialogues = {}
selected = 1

function draw_dialogs()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setBackgroundColor(1, 1, 1)
    love.graphics.clear()
    love.graphics.draw(background_img, 0, 0)

    -- Draw dialogue message
    set_color_white(1)
    love.graphics.draw(dialogues[dialogue_state].message, 10 + 1, 10 + 1)
    set_color_white(4)
    love.graphics.draw(dialogues[dialogue_state].message, 10, 10)

    local total_height = 0

    for i, c in ipairs(dialogues[dialogue_state].choice) do
        total_height = total_height + c.text:getHeight() + 12
    end

    local accum_height = 0

    for i, c in ipairs(dialogues[dialogue_state].choice) do
        local base_y = 216 - total_height + accum_height

        if selected == i then
            set_color_blue(4)
            love.graphics.rectangle('line', 10, base_y, c.text:getWidth() + 6, c.text:getHeight() + 6)
        end

        set_color_blue(0)
        love.graphics.rectangle('fill', 10 + 1, base_y + 1, c.text:getWidth() + 4, c.text:getHeight() + 4)
        set_color_white(1)
        love.graphics.draw(c.text, 14, base_y + 4)
        set_color_white(4)
        love.graphics.draw(c.text, 13, base_y + 3)

        accum_height = accum_height + c.text:getHeight() + 12
    end

    if dialogue_state == 'start' then
        start_board = true
    end

end

-- Mouse interaction of dialogues

function dialog_update()
    local total_height = 0

    for i, c in ipairs(dialogues[dialogue_state].choice) do
        total_height = total_height + c.text:getHeight() + 12
    end

    local accum_height = 0

    for i, c in ipairs(dialogues[dialogue_state].choice) do
        local base_y = 216 - total_height + accum_height
        local base_x = 10
        local width = c.text:getWidth() + 6
        local height = c.text:getHeight() + 6
        if cursor.x >= base_x and cursor.x < base_x + width and cursor.y >= base_y and cursor.y < base_y + height then
            selected = i
            return
        end

        accum_height = accum_height + c.text:getHeight() + 12
    end
end

function dialog_mousepressed(x, y, button)
    local total_height = 0

    for i, c in ipairs(dialogues[dialogue_state].choice) do
        total_height = total_height + c.text:getHeight() + 12
    end

    local accum_height = 0

    for i, c in ipairs(dialogues[dialogue_state].choice) do
        local base_y = 216 - total_height + accum_height
        local base_x = 10
        local width = c.text:getWidth() + 6
        local height = c.text:getHeight() + 6
        if cursor.x >= base_x and cursor.x < base_x + width and cursor.y >= base_y and cursor.y < base_y + height then
            dialogue_state = c.target
            return
        end

        accum_height = accum_height + c.text:getHeight() + 12
    end
end

-- ============================================================================
-- Initialization
-- ============================================================================

function load_scene(theme_file)
    local loaded = love.filesystem.load(theme_file)()
    background_img = love.graphics.newImage(loaded.background_img)

    pieces = loaded.pieces
    friendly_sprite = love.graphics.newQuad(16, 0, 16, 16, 32, 16)
    enemy_sprite = love.graphics.newQuad(0, 0, 16, 16, 32, 16)

    for name, p in pairs(pieces) do
        p.image = love.graphics.newImage(p.image)
        p.portrait_img = love.graphics.newImage(p.portrait_img)
    end

    next_action_list = {}

    for i, p in ipairs(loaded.initial_pieces.friendly) do
        board.state[p.x][p.y] = {
            type = p.type,
            team = 'friendly',
            hp = pieces[p.type].max_hp,
            cooldown = 0,
            last_cooldown = 1
        }
    end

    for i, p in ipairs(loaded.initial_pieces.enemy) do
        board.state[p.x][p.y] = {
            type = p.type,
            team = 'enemy',
            hp = pieces[p.type].max_hp,
            cooldown = 0,
            last_cooldown = 1
        }
    end
end

function load_dialogues(dialogue_file)
    dialogue_state, dialogues = love.filesystem.load(dialogue_file)()

    for s, d in pairs(dialogues) do
        d.message = love.graphics.newText(font, d.message)
        for i, c in pairs(d.choice) do
            c.text = love.graphics.newText(font, c.text)
        end
    end
end

function love.load()
    love.window.setMode(res_x * pixel_scale, res_y * pixel_scale)
    love.mouse.setVisible(false)

    font14 = love.graphics.newFont("font14.fnt")
    font = love.graphics.newFont("font10.fnt")

    attack_arrow = love.graphics.newImage("attack_arrow.png")

    canvas = love.graphics.newCanvas(res_x, res_y)
    canvas:setFilter("nearest", "nearest")

    canvas_dialog = love.graphics.newCanvas(res_x, res_y)
    canvas_dialog:setFilter("nearest", "nearest")

    for i=0,board.tiles_x do
        board.state[i] = {}
        for j=0,board.tiles_y do
            board.state[i][j] = {}
        end
    end

    load_scene("scene1.lua")
    load_dialogues("scene1_dialogues.lua")
end

-- ============================================================================
-- Main Loop
-- ============================================================================

function love.mousepressed(x, y, button)
    if board_started then
        game_mousepressed(x, y, button)
    else
        dialog_mousepressed(x, y, button)
    end
end

function love.update()
    update_cursor()
    if board_started then
        game_update()
    else
        dialog_update()
    end

    if start_board and (not board_started) then
        transition = transition + love.timer.getDelta()
        if transition >= 1.0 then
            board_started = true
            transition = 1.0
        end
    end
end

function love.draw()
    love.graphics.setCanvas(canvas)
    draw_scene()

    love.graphics.setCanvas(canvas_dialog)
    draw_dialogs()

    love.graphics.setCanvas()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(canvas_dialog, (-transition) * love.graphics.getWidth(), 0, 0, pixel_scale, pixel_scale)
    love.graphics.draw(canvas, (1.0 - transition) * love.graphics.getWidth(), 0, 0, pixel_scale, pixel_scale)
    draw_cursor()
end
