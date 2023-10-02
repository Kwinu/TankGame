local treeManager = {}

--Mes modules
local myFunctions = require("myFunctions")
local bulletManager = require("bulletManager")
local enemyManager = require("enemyManager")

local treeImage = love.graphics.newImage("images/tree.png")

treeManager.trees = {}

local tree = {}
tree.x = love.graphics.getWidth() / 2
tree.y = love.graphics.getHeight() / 2
tree.angle = 0
tree.image = treeImage
tree.r = treeImage:getWidth() / 2

function treeManager.CreateTree(pX, pY)
    local t = {}
    t.x = pX
    t.y = pY
    t.angle = 0
    t.image = treeImage
    t.r = treeImage:getWidth() / 2
    table.insert(treeManager.trees, t)
end

function treeManager.update(dt, pHero)
    for n = #bulletManager.bullets, 1, -1 do
        local b = bulletManager.bullets[n]
        b.x = b.x + (b.speed * math.cos(b.angle)) * dt
        b.y = b.y + (b.speed * math.sin(b.angle)) * dt

        local collide = false

        for nt = #treeManager.trees, 1, -1 do
            local theTree = treeManager.trees[nt]
            if myFunctions.isRadiusCollide(b, theTree) then
                table.remove(treeManager.trees, nt)
                table.remove(bulletManager.bullets, n)
                enemyManager.CreateEnemy(theTree.x, theTree.y)
                enemyManager.enemyCreate = true
                collide = true
            end
        end
        for ne = #enemyManager.enemy, 1, -1 do
            local theEnemy = enemyManager.enemy[ne]
            if myFunctions.isRadiusCollide(b, theEnemy) then
                table.insert(enemyManager.enemyDead, ne)
                table.remove(enemyManager.enemy, ne)
                collide = true
            end
        end
    end
end

function treeManager.draw()
    for trees, tree in ipairs(treeManager.trees) do
        myFunctions.AfficheCentree(tree)
    end
end

return treeManager
