local bulletManager = {}

--Mes modules
local myFunctions = require("myFunctions")

local bulletImage = love.graphics.newImage("images/bullet.png")
local bulletEnemyImage = love.graphics.newImage("images/enemyBullet.png")

bulletManager.bullets = {}

function bulletManager.CreateBullet(pX, pY, pAngle, pSpeed, pType)
    local b = {}
    b.x = pX
    b.y = pY
    b.angle = pAngle
    b.speed = pSpeed
    if pType == "hero" then
        b.image = bulletImage
        b.r = bulletImage:getWidth() / 2
    elseif pType == "enemy" then
        b.image = bulletEnemyImage
        b.r = bulletEnemyImage:getWidth() / 2
    end
    table.insert(bulletManager.bullets, b)
end

function bulletManager.update(dt)
    for n = #bulletManager.bullets, 1, -1 do
        local b = bulletManager.bullets[n]
        if collide == false then
            if b.x < 0 - b.image:getWidth() / 2 or b.x > screenW + b.image:getWidth() / 2 then
                table.remove(bulletManager.bullets, n)
            elseif b.y < 0 - b.image:getWidth() / 2 or b.y > screenH + b.image:getHeight() / 2 then
                table.remove(bulletManager.bullets, n)
            end
        end
    end
end

function bulletManager.draw()
    for bullets, bullet in ipairs(bulletManager.bullets) do
        myFunctions.AfficheCentree(bullet)
    end
end

return bulletManager
