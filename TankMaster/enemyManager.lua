local enemyManager = {}

local myFunctions = require("myFunctions")
local bulletManager = require("bulletManager")

local enemyImage = love.graphics.newImage("images/enemyTank.png")

enemyManager.enemy = {}

enemyManager.enemy.Ox = love.graphics.getWidth() / 2
enemyManager.enemy.Oy = love.graphics.getHeight() / 2
enemyManager.enemyCreate = false
enemyManager.enemyDead = {}

--Machine à Etats
enemyManager.STATES = {}
enemyManager.STATES.NONE = ""
enemyManager.STATES.CREATE = "create"
enemyManager.STATES.MOVE = "move"
enemyManager.STATES.ATTACK = "attack"
enemyManager.STATES.CHANGEDIR = "changedir"

local time = 5
local timer = time

function enemyManager.CreateEnemy(pX, pY)
    local e = {}
    e.x = pX
    e.y = pY
    e.movespeed = 120
    e.angle = math.random(0, 180)
    e.angleCible = e.angle
    e.image = enemyImage
    e.r = enemyImage:getWidth() / 2
    e.timerShoot = 0
    e.speedShoot = 0.5
    e.state = enemyManager.STATES.NONE
    table.insert(enemyManager.enemy, e)
end

function enemyManager.update(dt, pHero)
    for e = #enemyManager.enemy, 1, -1 do
        en = enemyManager.enemy[e]
        local rayonChase = 150
        local distance = math.dist(en.x, en.y, pHero.x, pHero.y)

        if en.angle < en.angleCible then
            en.angle = en.angle + 2 * dt
        elseif en.angle > en.angleCible then
            en.angle = en.angle - 2 * dt
        end

        if en.state == enemyManager.STATES.NONE then
            en.state = enemyManager.STATES.CREATE
        elseif en.state == enemyManager.STATES.CREATE then
            if enemyManager.enemyCreate == true then
                en.distance = 3
                en.state = enemyManager.STATES.MOVE
            end
        elseif en.state == enemyManager.STATES.MOVE then
            en.vx = en.movespeed * math.cos(en.angle)
            en.vy = en.movespeed * math.sin(en.angle)

            en.x = en.x + en.vx * dt
            en.y = en.y + en.vy * dt

            if en.distance <= 0 then
                en.state = enemyManager.STATES.CHANGEDIR
                en.distance = 1
            end

            if en.x <= 0 or en.x > screenW or en.y <= 0 or en.y > screenH then
                en.state = enemyManager.STATES.CHANGEDIR
            end

            if distance <= rayonChase then
                en.state = enemyManager.STATES.ATTACK
            end
        elseif en.state == enemyManager.STATES.ATTACK then
            local angleToTank = math.angle(en.x, en.y, pHero.x, pHero.y)
            en.angle = angleToTank
            if distance > rayonChase then
                en.state = enemyManager.STATES.CHANGEDIR
                en.distance = 1
            elseif distance <= rayonChase then
                en.timerShoot = en.timerShoot + dt
                if en.timerShoot >= en.speedShoot then
                    bulletManager.CreateBullet(en.x, en.y, en.angle, 300, "enemy")
                    for n = #bulletManager.bullets, 1, -1 do
                        b = bulletManager.bullets[n]
                        if myFunctions.isRadiusCollide(b, pHero) then
                            table.remove(bulletManager.bullets, n)
                            pHero.life.numb = pHero.life.numb - 1
                        end
                    end
                    en.timerShoot = 0
                end
            end
        elseif en.state == enemyManager.STATES.CHANGEDIR then
            en.angleCible = en.angleCible + math.pi / 2
            en.state = enemyManager.STATES.MOVE
            en.distance = love.math.random(10, 20) / 10
        end
    end
end

function enemyManager.draw()
    love.graphics.print("Vous avez tué : " .. #enemyManager.enemyDead .. " enemies!", 10, 50)
    for k, v in ipairs(enemyManager.enemy) do
        myFunctions.AfficheCentree(v)
    end
end

return enemyManager
