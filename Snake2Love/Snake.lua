local Snake = {}
Utils = require "Utils"


local directions = { "left", "right", "up", "down" }
local directionsOpost = { "right", "left", "down", "up" }

local M = 40
local N = 20

local colision = false

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

function Snake.born(startX, startY, startVelocity)
	for memberCount in pairs (body.members) do
		body.members[memberCount] = nil
	end
	
	colision = false

	body.x = startX
	body.y = startY
	body.members = { }
	body.numMembers = 0
	body.diretion = ""
	body.velocity = startVelocity

	randomDirection = Utils.randomize(1, 4)
	Snake.grow(randomDirection)

	resetMemory();

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

-- DIRECTION FUNCTIONS
function Snake.getDirections()
	return directions
end

function Snake.isOppositeDirection(direction)
	return direction == directionsOpost[body.direction]
end

-- MEMORY FUNCTIONS
function Snake.newMemory(startX, startY, direction)

	--print "-------------------------------------------------------------------------"

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
	--print ("Grow Function:")
	--print (directionMovement)

	Snake.newMemory(body.x, body.y, directionMovement)
	
	bodyMember = {
		x = body.x,
		y = body.y,
		direction = directionMovement,
		startIn = body.numMembers
	}

	table.insert(body.members, bodyMember)
	body.numMembers = body.numMembers + 1
end

function verifyColision()
	head = body.members[1]

	for contMember, member in ipairs(body.members) do
		if contMember ~= 1 then
			colision = head.x == member.x and head.y == member.y
		else
			colision = false
		end
	end
end

function Snake.haveColision()
	return colision
end

function Snake.walk( matrixOccupation )
	--print "##########################################################"
	--for memCount, currentMemory in ipairs(moveMemories) do
	--	print("<" .. memCount .. ">   X: " .. currentMemory.x .. "   Y: " .. currentMemory.y .. "   DIR: " .. currentMemory.posDirection)
	--end
	--print "##########################################################"

	--print("Snake <> X:" .. body.x .. " Y:" .. body.y .. " - Direction: ".. body.direction)
	for memberCount, currentMember in ipairs(body.members) do
		for memCount, currentMemory in ipairs(moveMemories) do
			if currentMember.x == currentMemory.x and currentMember.y == currentMemory.y then
				currentMember.direction = currentMemory.posDirection
				currentMemory.posDuration = currentMemory.posDuration - 1;
			end
		end

		if currentMember.direction ~= nil then
			--print("Member <" .. memberCount .. "> X:" .. currentMember.x .. " Y:" .. currentMember.y .. " - Direction: ".. currentMember.direction)
		end

		if currentMember.startIn == 0 then
			matrixOccupation[currentMember.x/body.size + 1][currentMember.y/body.size + 1] = 0
			currentMember = walkOneStep(currentMember)

			-- if after walk the position is already 1, we have a colision
			if matrixOccupation[currentMember.x/body.size + 1][currentMember.y/body.size + 1] == 1 then
				colision = true;
			else
				matrixOccupation[currentMember.x/body.size + 1][currentMember.y/body.size + 1] = 1
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

	moveMemoriesAux = {}

	for memoryCount, currentMemory in ipairs(moveMemories) do
		if currentMemory.posDuration ~= 0 then
			table.insert(moveMemoriesAux, currentMemory)
		end
	end
	moveMemories = moveMemoriesAux
end

function walkOneStep(snakeMember)
	step = body.size
	
	if directions[snakeMember.direction] == "up" then
		if snakeMember.y - step < 0 then
			snakeMember.y = (body.size*N) - step
		else
			snakeMember.y = snakeMember.y - step
		end
	elseif directions[snakeMember.direction] == "down" then
		if snakeMember.y + step >= (body.size*N) then
			snakeMember.y = 0
		else
			snakeMember.y = snakeMember.y + step
		end
	elseif directions[snakeMember.direction] == "left" then
		if snakeMember.x - step < 0 then
			snakeMember.x = (body.size*M) - step
		else
			snakeMember.x = snakeMember.x - step
		end
	elseif directions[snakeMember.direction] == "right" then
		if snakeMember.x + step >= (body.size*M) then
			snakeMember.x = 0
		else
			snakeMember.x = snakeMember.x + step
		end
	end

	return snakeMember
end

return Snake