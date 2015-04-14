-- Pontifícia Universidade Católica do Rio de Janeiro - PUC-Rio
-- Princípios de Engenharia de Software - 2015.1
-- Trabalho 1
-- Jéssica Thaisa Silva de Almeida
--
-- Main.lua module


Game = require "Game"

local screen_width = 32 * Utils.getWidth()
local screen_height = 32 * Utils.getHeight()

local execTime = 0.0
local timerStart = 0.0


local food = {
	x = 0,
	y = 0,
	duration = 0
}
local pauseImage = love.graphics.newImage("images/telaPausou.png")
local loseImage = love.graphics.newImage("images/telaPerdeu.png")
local beginImage = love.graphics.newImage("images/telaInicial.png")


function love.load()
	Game.StartNewGame()
end

function love.keypressed(key)
	Game.keypressed(key)
end

function love.update(dt)
	if not (Game.haveColision()) then
		Game.allowMove()
		Game.update(dt)
		Game.disallowMove()
	end
end

function love.draw()
	if Game.haveColision() then
		love.graphics.draw(loseImage, 0, 0)
	elseif not(Game.isPaused()) then
		Game.draw()
	else
		love.graphics.draw(pauseImage, 0, 0)
	end
end