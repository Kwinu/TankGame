-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

-- Returns the distance between two points.
function math.dist(x1, y1, x2, y2)
    return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5
end

-- Returns the angle between two vectors assuming the same origin.
function math.angle(x1, y1, x2, y2)
    return math.atan2(y2 - y1, x2 - x1)
end

local GUI = require("GUI")

function love.load()
    --Mes parametres de fenêtre
    love.window.setMode(1000, 800)
    love.window.setTitle("Tank Master - © Kwinu 2023")
    screenW = love.graphics.getWidth()
    screenH = love.graphics.getHeight()
    midScreenW = screenW / 2
    midScreenH = screenH / 2

    GUI.load()
end

function love.update(dt)
    GUI.update(dt)
end

function love.draw()
    love.graphics.setBackgroundColor(0.5, 0.5, 0.5)
    GUI.draw()
end

function love.keypressed(key)
    GUI.keypressed(key)
end

function love.mousepressed(px, py, pb)
    GUI.mousepressed(px, py, pb)
end
