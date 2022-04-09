local console_toggle = require("love2d-console.console.console")

function love.textinput(text)
    console_toggle(text)
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
    base_x = 6,
    base_y = 6,
    tiles_x = 11,
    tiles_y = 11,
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
                table.insert(list, {x = i, y = j, cooldown = get_cell_cooldown(i, j)})
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

function love.mousepressed(x, y, button)
    if button == 1 then
        if is_cell_empty(cursor.selected.x, cursor.selected.y) then
            pickedup = {}
        else
            pickedup.coord = {
                x = cursor.selected.x,
                y = cursor.selected.y
            }
        end
    end
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
    love.graphics.draw(background_img, 0, 0)
end

-- Draw the board
function draw_board()
    -- set_color_white(0)
    -- love.graphics.rectangle('fill', board.base_x, board.base_y, board.tile_size * board.tiles_x, board.tile_size * board.tiles_y)
    
    for i, column in ipairs(board.state) do
        for j, p in ipairs(column) do
            if p.type then
                if p.team == 'friendly' then
                    set_color_blue((i + j) % 2 + 3)
                    love.graphics.rectangle(
                        'fill',
                        board.base_x + board.tile_size * (i - 1),
                        board.base_y + board.tile_size * (j - 1),
                        board.tile_size,
                        board.tile_size)
                else
                    set_color_red((i + j) % 2 + 3)
                    love.graphics.rectangle(
                        'fill',
                        board.base_x + board.tile_size * (i - 1),
                        board.base_y + board.tile_size * (j - 1),
                        board.tile_size,
                        board.tile_size)
                end
                set_color_white(4)
                love.graphics.draw(
                    pieces[p.type].image,
                    board.base_x + board.tile_size * (i - 1),
                    board.base_y + board.tile_size * (j - 1))
            else
                set_color_white((i + j) % 2 + 3)
                love.graphics.rectangle(
                    'fill',
                    board.base_x + board.tile_size * (i - 1),
                    board.base_y + board.tile_size * (j - 1),
                    board.tile_size,
                    board.tile_size)
            end
        end
    end

    if is_pickedup() then
        if board.state[pickedup.coord.x + 1][pickedup.coord.y + 1].type then
            type = board.state[pickedup.coord.x + 1][pickedup.coord.y + 1].type
            set_color_white(4)
            love.graphics.draw(
                pieces[type].image,
                board.base_x + board.tile_size * cursor.selected.x,
                board.base_y + board.tile_size * cursor.selected.y)
        end
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

        set_color_white(3)
        love.graphics.rectangle('fill', 219, 147, 64, 64)

        set_color_white(4)
        love.graphics.draw(pieces[type].portrait_img, 219, 147)

        set_color_white(1)
        love.graphics.rectangle('fill', 284, 147, 95, 64)

        name_text = love.graphics.newText(font, pieces[type].name)
        hp_text = love.graphics.newText(font, 
            tostring(get_cell_hp(cursor.selected.x, cursor.selected.y)) .. "/" ..
            tostring(pieces[type].max_hp))
        atk_text = love.graphics.newText(font, "ATK:" .. tostring(pieces[type].atk))
        def_text = love.graphics.newText(font, "DEF:" .. tostring(pieces[type].def))

        set_color_white(4)
        love.graphics.draw(name_text, 285, 148)
        if get_cell_team(cursor.selected.x, cursor.selected.y) == 'friendly' then
            set_color_blue(4)
        else
            set_color_red(4)
        end
        love.graphics.draw(hp_text, 285, 148 + 16)
        set_color_white(3)
        love.graphics.draw(atk_text, 285, 148 + 32)
        love.graphics.draw(def_text, 285, 148 + 48)

    end
end

-- Draw the scene
function draw_scene()
    draw_background()
    draw_board()
    draw_board_cursor()
    draw_unit_details()
end

-- Update logic
function game_update()
    update_next_action_list()
end

-- ============================================================================
-- Initialization
-- ============================================================================

function load_scene(theme_file)
    local loaded = love.filesystem.load(theme_file)()
    background_img = love.graphics.newImage(loaded.background_img)

    pieces = loaded.pieces

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
            cooldown = 0
        }
    end

    for i, p in ipairs(loaded.initial_pieces.enemy) do
        board.state[p.x][p.y] = {
            type = p.type,
            team = 'enemy',
            hp = pieces[p.type].max_hp,
            cooldown = 0
        }
    end
end

function love.load()
    love.window.setMode(res_x * pixel_scale, res_y * pixel_scale)
    love.mouse.setVisible(false)

    font = love.graphics.newImageFont("imagefont.png",
        " abcdefghijklmnopqrstuvwxyz" ..
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
        "123456789.,!?-+/():;%&`'*#=[]\"")

    canvas = love.graphics.newCanvas(res_x, res_y)
    canvas:setFilter("nearest", "nearest")

    for i=0,board.tiles_x do
        board.state[i] = {}
        for j=0,board.tiles_y do
            board.state[i][j] = {}
        end
    end

    load_scene("scene1.lua")
end

-- ============================================================================
-- Main Loop
-- ============================================================================

function love.update()
    update_cursor()
    game_update()
end

function love.draw()
    love.graphics.setCanvas(canvas)
    draw_scene()

    love.graphics.setCanvas()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(canvas, 0, 0, 0, pixel_scale, pixel_scale)
    draw_cursor()
end
