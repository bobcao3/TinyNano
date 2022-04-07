-- ============================================================================
-- Game States
-- ============================================================================

res_x = 384
res_y = 216

pixel_scale = 3

board = {
    base_x = 6,
    base_y = 6,
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

-- Draw the circular cursor on the window
function draw_cursor()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.circle("line", cursor.window_x, cursor.window_y, 5)
end

-- Draw the background
function draw_background()
    love.graphics.setBackgroundColor(0.7, 0.7, 0.7)
    love.graphics.clear()
    love.graphics.draw(background_img, 0, 0)
end

-- Draw the board
function draw_board()
    -- love.graphics.setColor(0, 0, 0, 1)
    -- love.graphics.rectangle('fill', board.base_x, board.base_y, board.tile_size * board.tiles_x, board.tile_size * board.tiles_y)
    
    for i, column in ipairs(board.state) do
        for j, p in ipairs(column) do
            if p.type then
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.draw(
                    pieces[p.type].image,
                    board.base_x + board.tile_size * (i - 1),
                    board.base_y + board.tile_size * (j - 1))
            end
        end
    end
end

-- Draw the board cursor
function draw_board_cursor()
    love.graphics.setColor(0, 0, 1, 1)
    love.graphics.rectangle(
        'line',
        board.base_x + cursor.selected.x * board.tile_size,
        board.base_y + cursor.selected.y * board.tile_size,
        board.tile_size, board.tile_size)
end

-- Draw the scene
function draw_scene()
    draw_background()
    draw_board()
    draw_board_cursor()
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
    end

    for i, p in ipairs(loaded.initial_pieces.friendly) do
        board.state[p.x][p.y] = {
            type = p.type,
            team = 'friendly'
        }
    end
end

function love.load()
    love.window.setMode(res_x * pixel_scale, res_y * pixel_scale)
    love.mouse.setVisible(false)

    font = love.graphics.newFont("minecraft.ttf")

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
end

function love.draw()
    love.graphics.setCanvas(canvas)
    draw_scene()

    love.graphics.setCanvas()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(canvas, 0, 0, 0, pixel_scale, pixel_scale)
    draw_cursor()
end
