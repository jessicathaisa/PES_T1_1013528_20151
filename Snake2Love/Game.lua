-- Pontifícia Universidade Católica do Rio de Janeiro - PUC-Rio
-- Princípios de Engenharia de Software - 2015.1
-- Trabalho 1
-- Jéssica Thaisa Silva de Almeida
--
-- Game.lua module

local Game = {}

World = require "World"

local move = false
local pause = false
local execTime = 0.0
local timerStart = 0.0

N = Utils.getN()	M = Utils.getM()

function Game.StartNewGame()
	move = false
	pause = false
	execTime = 0.0
	timerStart = os.clock() * 1000

	World.creation(N, M)

	move = true
end

registering = false

function Game.keypressed(key)
	if World.haveColision() and (key == "return" or key == "kpenter" ) then
		Game.StartNewGame()
	end

	if not(registering) and key == "up" or key == "down" or key == "right" or key == "left" then
		registering = true;
		if not(World.isOppositeDirection(key)) then
			World.createAnimationToAnimals( key )
		end
		registering = false;
	end

	if key == " " then
		pause = not(pause)
	end
end

local cont = 0
function Game.update()
	if move and not(pause) then
		cont = cont + 1
		move = false
		if cont % 10 == 0 then
			Snake.grow()
		end

		World.runTime()
	end
end

function Game.isMoving()
	return move
end

function Game.isPaused()
	return pause
end

function Game.pauseGame()
	pause = true
end

function Game.unpauseGame()
	pause = false
end

function Game.allowMove()
	move = true
end

function Game.disallowMove()
	move = false
end

function Game.haveColision()
	return World.haveColision()
end

function Game.getVelocity()
	return World.getVelocity()
end

function Game.getMembers()
	return World.getMembers()
end

return Game