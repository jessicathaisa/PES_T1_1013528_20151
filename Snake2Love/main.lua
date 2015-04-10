-- Pontifícia Universidade Católica do Rio de Janeiro - PUC-Rio
-- Princípios de Engenharia de Software - 2015.1
-- Trabalho 1
-- Jéssica Thaisa Silva de Almeida
--
-- Main.lua module


Game = require "Game"

local screen_width = 32 * Utils.getM()
local screen_height = 32 * Utils.getN()

local execTime = 0.0
local timerStart = 0.0


local food = {
	x = 0,
	y = 0,
	duration = 0
}
local wallpaperImage = love.graphics.newImage("wallpaper.jpg")
local scaleImage = love.graphics.newImage("scale.png")
local pauseImage = love.graphics.newImage("telaPausou.png")
local loseImage = love.graphics.newImage("telaPerdeu.png")
local beginImage = love.graphics.newImage("telaInicial.png")


function love.load()
	Game.StartNewGame()
end

function love.keypressed(key)
	Game.keypressed(key)
end

function love.update(dt)
	execTime = execTime + (dt * 1000)
	if execTime - timerStart >= (1000 / Game.getVelocity()) then
		timerStart = os.clock() * 1000
		Game.allowMove()
		Game.update()
		Game.disallowMove()
	end
end

function love.draw()
	if Game.haveColision() then
		love.graphics.draw(loseImage, 0, 0)
	elseif not(Game.isPaused()) then
		love.graphics.draw(wallpaperImage, 0, 0)

		head = Game.getMembers()[1]
		love.graphics.print("------ x:" .. (head.x/32) .. "   y:" .. (head.y/32) .. " ------", 100, 100)

		love.graphics.print("------ Time: " .. execTime/1000 .. " ------", 10, 10)

		for boxCount, box in ipairs(Game.getMembers()) do
			love.graphics.draw(scaleImage, box.x, box.y)
		end
	else
		love.graphics.draw(pauseImage, 0, 0)
	end
end