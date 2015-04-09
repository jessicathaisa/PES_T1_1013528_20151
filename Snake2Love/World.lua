local World = {}

Snake = require "Snake"

local occupationMatrix = {}
local occupationPosibility = {}

local directions = {}

function World.creation(lines, columns)

	directions = Snake.getDirections()
	occupationMatrix = {}

	for column = 1, columns + 1 do
		occupationMatrix[column] = {}
		for line = 1, lines + 1 do
	    	occupationMatrix[column][line] = 0
		end
	end

	for column = 1, columns + 1 do
		for line = 1, lines + 1 do
			position = { x = line , y = column }
        	table.insert(occupationPosibility, position)
    	end
	end

	shuffleOccupation(occupationPosibility);

	Snake.born(0, 0, 5)
end

function World.createAnimationToAnimals(key)
	for direction = 1, 4 do
		if key == directions[direction] then
			Snake.newMemory(Snake.getX(), Snake.getY(), direction)
		end
	end
end

function World.runTime()
	Snake.walk( occupationMatrix )
end


function shuffleOccupation(table)
	math.randomseed( os.time() )
	local rand = math.random
    local iterations = #table
    local j
    
    for i = iterations, 2, -1 do
        randomizedValue = rand(i)
        table[i], table[randomizedValue] = table[randomizedValue], table[i]
    end
end



function World.isOppositeDirection(direction)
	return Snake.isOppositeDirection(direction)
end

function World.haveColision()
	return Snake.haveColision()
end

function World.getVelocity()
	return Snake.getVelocity()
end

function World.getMembers()
	return Snake.getMembers()
end

return World
