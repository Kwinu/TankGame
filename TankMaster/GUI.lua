local GUI = {}

--Mes modules
local bulletManager = require("bulletManager")
local treeManager = require("treeManager")
local enemyManager = require("enemyManager")
local tank = require("tank")

GUI.myButton = {}
GUI.myButton.x = 450
GUI.myButton.y = 350
GUI.myButton.w = 100
GUI.myButton.h = 30
GUI.myButton.oX = GUI.myButton.x + 35
GUI.myButton.oY = GUI.myButton.y + 7

GUI.myButton2 = {}
GUI.myButton2.x = 450
GUI.myButton2.y = 400
GUI.myButton2.w = 100
GUI.myButton2.h = 30
GUI.myButton2.oX = GUI.myButton2.x + 35
GUI.myButton2.oY = GUI.myButton2.y + 7

local menu = "menu"

function GUI.load()
    tank.load()
end

function GUI.update(dt)
    if menu == "game" then
        tank.update(dt)
        bulletManager.update(dt)
        treeManager.update(dt)
    elseif menu == "exit" then
        love.event.quit(0)
    end
end

function GUI.draw()
    if menu == "menu" then
        love.graphics.print("TANK MASTER", 457, 100)
        love.graphics.print("VOUS AVEZ 45 SECONDES", 422, 150)
        love.graphics.print("POUR ELIMINER TOUS LES ENEMIS", 397, 200)
        love.graphics.print("BONNE CHANCE", 452, 250)
        love.graphics.rectangle("line", GUI.myButton.x, GUI.myButton.y, GUI.myButton.w, GUI.myButton.h)
        love.graphics.print("PLAY", GUI.myButton.oX, GUI.myButton.oY)
        love.graphics.rectangle("line", GUI.myButton2.x, GUI.myButton2.y, GUI.myButton2.w, GUI.myButton2.h)
        love.graphics.print("EXIT", GUI.myButton2.oX, GUI.myButton2.oY)
    elseif menu == "game" then
        bulletManager.draw()
        treeManager.draw()
        enemyManager.draw()
        tank.draw()
    elseif menu == "exit" then
    end
end

function GUI.keypressed(key)
    if menu == "game" then
        tank.keypressed(key)
    elseif menu == "exit" then
    end
end

function GUI.mousepressed(px, py, pb)
    if menu == "menu" then
        print("Clic !")
        if
            px >= GUI.myButton.x and px <= GUI.myButton.x + GUI.myButton.w and py >= GUI.myButton.y and
                py <= GUI.myButton.y + GUI.myButton.h
         then
            print("Le jeu va commencer!")
            menu = "game"
        elseif
            px >= GUI.myButton2.x and px <= GUI.myButton2.x + GUI.myButton2.w and py >= GUI.myButton2.y and
                py <= GUI.myButton2.y + GUI.myButton2.h
         then
            print("Merci d'avoir joué!")
            menu = "exit"
        end
    elseif menu == "game" then
    elseif menu == "exit" then
    end
end

return GUI
