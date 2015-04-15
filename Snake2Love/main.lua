-- Pontifícia Universidade Católica do Rio de Janeiro - PUC-Rio
-- Princípios de Engenharia de Software - 2015.1
-- Trabalho 1
-- Jéssica Thaisa Silva de Almeida
--
-- Main.lua module


Game = require "Game"


function love.load()
	Game.load()
end

function love.keypressed(key)
	Game.controller(key)
end

function love.update(dt)
	Game.update(dt)
end

function love.draw()
	Game.draw()
end