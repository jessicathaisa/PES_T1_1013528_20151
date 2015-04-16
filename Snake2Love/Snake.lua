-- Pontifícia Universidade Católica do Rio de Janeiro - PUC-Rio
-- Princípios de Engenharia de Software - 2015.1
-- Trabalho 1
-- Jéssica Thaisa Silva de Almeida
--
-- Snake.lua module


local Snake = {}
local Utils = require "Utils"


local directions = { "left", "right", "up", "down" }
local directionsOpost = { "right", "left", "down", "up" }

local WIDTH = Utils.getWidth()
local HEIGHT = Utils.getHeight()

local endtime = 0
local starttime = 0

local colision = false
local ateFood = false

local scaleImage = love.graphics.newImage("images/scale.png")

local body = {
	posX = 0,
	posY = 0,
	members = {},
	size = 32,
	numMembers = 0,
	direction = "",
	velocity = 0,
	food = 0
}

local moveMemories = {}


-- Inicializes all the necessary variables to a Snake
-- Parameters
-- 
-- Return
--
function Snake.load()
	for memberCount in pairs (body.members) do
		body.members[memberCount] = nil
	end
	
	colision = false
	ateFood = false

	body.posX = Utils.randomize(1, 40)
	body.posY = Utils.randomize(1, 20)
	body.members = { }
	body.numMembers = 0
	body.diretion = ""
	body.velocity = 10
	body.food = 0

	endtime = 0
	starttime = 0

	randomDirection = Utils.randomize(1, 4)
	Snake.grow(randomDirection)
	Snake.grow(randomDirection)
	Snake.grow(randomDirection)
	Snake.resetMemory();

end

-- Updates the velocity and the position of the snake
-- Parameters
-- 		dt:	time transcorred after last execution of this function
--		matrixOccupation: matrix of occupation of the screen
-- Return
--		The actual direction of the snake
--		If there was a colision
--		If the snake have eaten a food
function Snake.update(dt, matrixOccupation)
	if ateFood then
		Snake.grow()
		Snake.updateVelocity()
	end
	ateFood = false

	endtime = endtime + dt
	deltaT = endtime - starttime
	if deltaT * body.velocity >= 1 then
		starttime = endtime
		Snake.walk(matrixOccupation)
	end

	return body.direction, colision, ateFood
end

-- Draws in the screen the body members of the snake
-- Parameters
--
-- Return
--
function Snake.draw()
	for boxCount, box in ipairs(body.members) do
		love.graphics.draw(scaleImage, (box.posX - 1) * Utils.getGridSize(), (box.posY - 1) * Utils.getGridSize())
	end
end

-- Crates a new memory of turn to the Snake
-- Parameters
--		direction: Direction of the turn
-- Return
--
function Snake.newMemory(direction)
	memory = {
		posX = body.posX,
		posY = body.posY,
		posDirection = direction,
		posDuration = body.numMembers
	}

	table.insert(moveMemories, memory)
end

-- Erases the memory if all the body members walked over it 
-- Parameters
-- 	
-- Return
--
function Snake.clearMemory()
	moveMemoriesAux = {}

	for memoryCount, currentMemory in ipairs(moveMemories) do
		if currentMemory.posDuration >= 0 then
			table.insert(moveMemoriesAux, currentMemory)
		end
	end
	moveMemories = moveMemoriesAux
end

-- Makes the memory be updated with a member walking to it
-- Parameters
-- 		currentMember:	Member of the body we are looking
-- Return
--
function Snake.reviseMemory(currentMember)
	for memCount, currentMemory in ipairs(moveMemories) do
		if currentMember.startIn ~= 0 then
			break
		end

		if currentMemory.posDuration == 0 then
			currentMemory.posDuration = currentMemory.posDuration - 1
		elseif currentMember.posX == currentMemory.posX and currentMember.posY == currentMemory.posY then
			currentMember.direction = currentMemory.posDirection
			currentMemory.posDuration = currentMemory.posDuration - 1
		end
	end
end

-- Clear the entire memory
-- Parameters
-- 	
-- Return
--
function Snake.resetMemory()
	for moveCount in pairs (moveMemories) do
		moveMemories[moveCount] = nil
	end
end


-- Update the velocity and the quantity of food eaten
-- Parameters
-- 	
-- Return
--
function Snake.updateVelocity()
	velocityIncrement = 0.01
	if body.food > 40 then velocityIncrement = 0.1
	elseif body.food > 35 then velocityIncrement = 0.3
	elseif body.food > 30 then velocityIncrement = 0.4
	elseif body.food > 25 then velocityIncrement = 0.5
	elseif body.food > 20 then velocityIncrement = 0.7
	elseif body.food > 10 then velocityIncrement = 0.8
	elseif body.food > 5 then velocityIncrement = 1 end

	body.velocity = body.velocity + velocityIncrement
	body.food = body.food + 1
end

-- Makes the snake grow one unit
-- Parameters
-- 		directionMovement:	direction in which will grow
-- Return
--
function Snake.grow(directionMovement)
	if directionMovement == nil then
		directionMovement = body.direction
	end
	
	bodyMember = {
		posX = body.posX,
		posY = body.posY,
		direction = directionMovement,
		startIn = body.numMembers
	}

	table.insert(body.members, bodyMember)
	body.numMembers = body.numMembers + 1
end

-- Makes the snake walk one step with all members of the body 
-- Parameters
-- 		matrixOccupation:	matrix with all the positions in the world and the occupation status
-- Return
--
function Snake.walk( matrixOccupation )

	for memberCount, currentMember in ipairs(body.members) do
		
		Snake.reviseMemory(currentMember)

		if currentMember.startIn == 0 then
			matrixOccupation[currentMember.posX][currentMember.posY] = 0
			currentMember = Snake.walkOneStep(currentMember)

			if matrixOccupation[currentMember.posX ][currentMember.posY] == 1 then
				colision = true;
			end
			if matrixOccupation[currentMember.posX][currentMember.posY] == 2 then
				ateFood = true;
			end

			if not(colision) then
				matrixOccupation[currentMember.posX][currentMember.posY] = 1
			end
		else
			currentMember.startIn = currentMember.startIn - 1
		end

		if memberCount == 1 then
			body.posX = currentMember.posX
			body.posY = currentMember.posY
			body.direction = currentMember.direction

		end
	end

	Snake.clearMemory()
end

-- Makes the snake walk one step with one member of the body 
-- Parameters
-- 		snakeMember:	member to walk
-- Return
--
function Snake.walkOneStep(snakeMember)
	
	if directions[snakeMember.direction] == "up" then
		if snakeMember.posY == 1 then
			snakeMember.posY = HEIGHT
		else
			snakeMember.posY = snakeMember.posY - 1
		end
	elseif directions[snakeMember.direction] == "down" then
		if snakeMember.posY == HEIGHT then
			snakeMember.posY = 1
		else
			snakeMember.posY = snakeMember.posY + 1
		end
	elseif directions[snakeMember.direction] == "left" then
		if snakeMember.posX == 1 then
			snakeMember.posX = WIDTH
		else
			snakeMember.posX = snakeMember.posX - 1
		end
	elseif directions[snakeMember.direction] == "right" then
		if snakeMember.posX == WIDTH then
			snakeMember.posX = 1
		else
			snakeMember.posX = snakeMember.posX + 1
		end
	end

	return snakeMember
end

return Snake