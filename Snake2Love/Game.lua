local Game = {}

World = require "World"

local move = false
local pause = false
local execTime = 0.0
local N = 20	M = 40

function Game.StartNewGame()
	World.creation(N, M)
end


function Game.keypressed(key)
	if World.haveColision() and key == "return" then
		Game.StartNewGame()
	end

	if key == "up" or key == "down" or key == "right" or key == "left" then
		if not(World.isOppositeDirection(key)) then
			World.createAnimationToAnimals( key )
		end
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