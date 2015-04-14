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

function Game.load()
	move = false
	pause = false

	World.load()
	Snake.load()
	Food.load()

	move = true
end

-- Starts the updates to each Element of the game
-- Parameters
-- 		dt: Time transcorred after last update
-- Return
--
function Game.update(dt)
	if move and not(pause) then
		matrixOccupation = World.getOccupationMatrix()
		occupationPosibility = World.getOccupationPosibility()

		Snake.update( dt , matrixOccupation)
		Food.update( dt , matrixOccupation, occupationPosibility, Snake.haveAteFood())
		World.update( dt, Snake.haveAteFood())
	end
end

function Game.draw()
	World.draw()
	Snake.draw()
	Food.draw()
end


keyPressionSemaphore = false

function Game.controller(key)
	if World.haveColision() and (key == "return" or key == "kpenter" ) then
		Game.load()
	end

	if not(keyPressionSemaphore) and key == "up" or key == "down" or key == "right" or key == "left" then
		-- CRITICAL REGION 
		keyPressionSemaphore = true;
		if not(World.isOppositeDirection(key)) then
				for direction = 1, 4 do
					if key == directions[direction] then
						Snake.newMemory(Snake.getX(), Snake.getY(), direction)
					end
				end
		end
		keyPressionSemaphore = false;
	end

	if key == " " then
		pause = not(pause)
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