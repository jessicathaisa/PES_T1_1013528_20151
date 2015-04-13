-- Pontifícia Universidade Católica do Rio de Janeiro - PUC-Rio
-- Princípios de Engenharia de Software - 2015.1
-- Trabalho 1
-- Jéssica Thaisa Silva de Almeida
--
-- Snake.lua module


local Snake = {}
Utils = require "Utils"


local directions = { "left", "right", "up", "down" }
local directionsOpost = { "right", "left", "down", "up" }

local M = Utils.getM()
local N = Utils.getN()

local execTime = 0
local startTime = 0

local colision = false
local ateFood = false

local body = {
	x = 0,
	y = 0,
	members = {},
	size = 32,
	numMembers = 0,
	direction = "",
	velocity = 0
}

local moveMemories = {}

local scaleImage = love.graphics.newImage("images/scale.png")

function Snake.load(startX, startY, startVelocity)
	for memberCount in pairs (body.members) do
		body.members[memberCount] = nil
	end
	
	colision = false
	ateFood = false

	body.x = startX
	body.y = startY
	body.members = { }
	body.numMembers = 0
	body.diretion = ""
	body.velocity = startVelocity

	execTime = 0
	startTime = 0

	randomDirection = Utils.randomize(1, 4)
	Snake.grow(randomDirection)
	Snake.grow(randomDirection)
	Snake.grow(randomDirection)
	resetMemory();

end


function Snake.update(dt, matrixOccupation)
	if ateFood then
		Snake.grow()
		body.velocity = body.velocity + 1
	end

	ateFood = false

	execTime = execTime + dt
	deltaT = execTime - startTime
	if deltaT * body.velocity < 1 then
		return
	end
	startTime = execTime
	Snake.walk(matrixOccupation)
end

function Snake.draw()
	for boxCount, box in ipairs(body.members) do
		love.graphics.draw(scaleImage, (box.x - 1) * Utils.getGridSize(), (box.y - 1) * Utils.getGridSize())
	end
end

function Snake.getX()
	return body.x
end

function Snake.getY()
	return body.y
end

function Snake.getVelocity()
	return body.velocity
end

function Snake.getMembers()
	return body.members, body.numMembers
end


function Snake.haveColision()
	return colision
end

function Snake.haveAteFood()
	return ateFood
end

-- DIRECTION FUNCTIONS
function Snake.getDirections()
	return directions
end

function Snake.isOppositeDirection(direction)
	return direction == directionsOpost[body.direction]
end


-- MEMORY FUNCTIONS
function Snake.newMemory(startX, startY, direction)
	memory = {
		x = startX,
		y = startY,
		posDirection = direction,
		posDuration = body.numMembers
	}

	table.insert(moveMemories, memory)
end

function Snake.forgetFirstMemory()
	table.remove(moveMemories, moveMemories[1])
end

function Snake.clearMemory()
	moveMemoriesAux = {}

	for memoryCount, currentMemory in ipairs(moveMemories) do
		if currentMemory.posDuration >= 0 then
			table.insert(moveMemoriesAux, currentMemory)
		end
	end
	moveMemories = moveMemoriesAux
end

function resetMemory()
	for moveCount in pairs (moveMemories) do
		moveMemories[moveCount] = nil
	end
end


-- ACTION FUNCTIONS
function Snake.grow(directionMovement)
	if directionMovement == nil then
		directionMovement = body.direction
	end
	
	bodyMember = {
		x = body.x,
		y = body.y,
		direction = directionMovement,
		startIn = body.numMembers
	}

	table.insert(body.members, bodyMember)
	body.numMembers = body.numMembers + 1
end

function Snake.walk( matrixOccupation )
	for memberCount, currentMember in ipairs(body.members) do
		for memCount, currentMemory in ipairs(moveMemories) do
			if currentMember.startIn ~= 0 then
				break
			end

			if currentMemory.posDuration == 0 then
				currentMemory.posDuration = currentMemory.posDuration - 1
			elseif currentMember.x == currentMemory.x and currentMember.y == currentMemory.y then
				currentMember.direction = currentMemory.posDirection
				currentMemory.posDuration = currentMemory.posDuration - 1
			end
		end

		if currentMember.startIn == 0 then
			matrixOccupation[currentMember.x][currentMember.y] = 0
			currentMember = walkOneStep(currentMember)

			if matrixOccupation[currentMember.x ][currentMember.y] == 1 then
				colision = true;
			end
			if matrixOccupation[currentMember.x][currentMember.y] == 2 then
				ateFood = true;
			end

			if not(colision) then
				matrixOccupation[currentMember.x][currentMember.y] = 1
			end
		else
			currentMember.startIn = currentMember.startIn - 1
		end

		if memberCount == 1 then
			body.x = currentMember.x
			body.y = currentMember.y
			body.direction = currentMember.direction

		end
	end

	Snake.clearMemory()
end

function walkOneStep(snakeMember)
	
	if directions[snakeMember.direction] == "up" then
		if snakeMember.y == 1 then
			snakeMember.y = N
		else
			snakeMember.y = snakeMember.y - 1
		end
	elseif directions[snakeMember.direction] == "down" then
		if snakeMember.y == N then
			snakeMember.y = 1
		else
			snakeMember.y = snakeMember.y + 1
		end
	elseif directions[snakeMember.direction] == "left" then
		if snakeMember.x == 1 then
			snakeMember.x = M
		else
			snakeMember.x = snakeMember.x - 1
		end
	elseif directions[snakeMember.direction] == "right" then
		if snakeMember.x == M then
			snakeMember.x = 1
		else
			snakeMember.x = snakeMember.x + 1
		end
	end

	return snakeMember
end

return Snake