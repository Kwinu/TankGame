local tank = {}
--Mes modules
local myFunctions = require("myFunctions")
local treeManager = require("treeManager")
local bulletManager = require("bulletManager")
local enemyManager = require("enemyManager")

local tankImage = love.graphics.newImage("images/tank.png")

tank.x = 100
tank.y = 100
tank.image = tankImage
tank.rotateSpeed = 2
tank.angle = 0
tank.movespeed = 100
tank.r = tankImage:getWidth() / 2

tank.life = {}
tank.life.numb = 10
tank.life.heartLimg = nil
tank.life.heartRimg = nil

tank.time = 45
tank.timer = tank.time

function tank.InitGame()
    tank.x = 100
    tank.y = 100
    tank.angle = 0
    tank.life.numb = 10

    treeManager.trees = {}
    while (#treeManager.trees < 100) do
        local treeX = love.math.random(1, screenW)
        local treeY = love.math.random(1, screenH)
        if math.dist(tank.x, tank.y, treeX, treeY) > tank.image:getWidth() * 2 then
            treeManager.CreateTree(treeX, treeY)
        end
    end
    enemyManager.enemyDead = {}
    enemyManager.enemy = {}
end

function tank.PV(pX, pY)
    tank.life.heartLw = tank.life.heartLimg:getWidth()
    tank.life.heartRw = tank.life.heartRimg:getWidth()
    -- heart left right left right
    for n = 1, tank.life.numb do
        tank.life.heartL = (n % 2) ~= 0

        if tank.life.heartL == true then
            love.graphics.draw(tank.life.heartLimg, pX, pY)
        else
            love.graphics.draw(tank.life.heartRimg, pX, pY)
        end
        if tank.life.heartL == false then
            pX = pX + tank.life.heartLw
        end
    end
end

function tank.load()
    if tank.timer >= 0 then
        tank.InitGame()
        tank.life.heartLimg = love.graphics.newImage("images/heartL.png")
        tank.life.heartRimg = love.graphics.newImage("images/heartR.png")
    end
end

function tank.update(dt)
    if tank.timer >= 0 then
        tank.timer = tank.timer - dt
        if tank.life.numb > 0 then
            local oldX = tank.x
            local oldY = tank.y
            if love.keyboard.isDown("left") then
                tank.angle = tank.angle - tank.rotateSpeed * dt
            elseif love.keyboard.isDown("right") then
                tank.angle = tank.angle + tank.rotateSpeed * dt
            end
            if love.keyboard.isDown("up") then
                tank.x = tank.x + (tank.movespeed * math.cos(tank.angle)) * dt
                tank.y = tank.y + (tank.movespeed * math.sin(tank.angle)) * dt
            elseif love.keyboard.isDown("down") then
                tank.x = tank.x - (tank.movespeed * math.cos(tank.angle)) * dt
                tank.y = tank.y - (tank.movespeed * math.sin(tank.angle)) * dt
            elseif love.keyboard.isDown("x") then
                tank.x = tank.x + (tank.movespeed * math.cos(tank.angle)) * dt * 2
                tank.y = tank.y + (tank.movespeed * math.sin(tank.angle)) * dt * 2
            end

            local bcollision = false
            for k, v in ipairs(treeManager.trees) do
                if myFunctions.isRadiusCollide(tank, v) then
                    bcollision = true
                    break
                end
            end
            if bcollision then
                tank.x = oldX
                tank.y = oldY
            end
            enemyManager.update(dt, tank)
        end
    elseif tank.timer <= 0 then
        tank.timer = tank.time
        tank.InitGame()
    end
end

function tank.draw()
    if tank.timer >= 0 then
        love.graphics.print(math.floor(tank.timer), midScreenW - 10, 20, 0, 2, 2)
        love.graphics.print("ECHAP : pour quitter le jeu", 50, screenH - 50, 0, 1, 1)
        if tank.life.numb > 0 then
            myFunctions.AfficheCentree(tank)
        end
        tank.PV(10, 10)
    end
end

function tank.keypressed(key)
    if tank.timer >= 0 then
        if tank.life.numb > 0 then
            if key == "space" then
                bulletManager.CreateBullet(tank.x, tank.y, tank.angle, 300, "hero")
            end
        end
    end
    if key == "i" then
        tank.InitGame()
    end
    if key == "escape" then
        love.event.quit(0)
    end
end

return tank
