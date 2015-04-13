-- Pontifícia Universidade Católica do Rio de Janeiro - PUC-Rio
-- Princípios de Engenharia de Software - 2015.1
-- Trabalho 1
-- Jéssica Thaisa Silva de Almeida
--
-- World.lua module

local World = {}

Snake = require "Snake"
Food = require "Food"

local occupationMatrix = {}
local occupationPosibility = {}

local directions = {}

local time = 0

function World.load(lines, columns)

	directions = Snake.getDirections()
	occupationMatrix = {}
	occupationPosibility = {}

	for column = 1, columns do
		occupationMatrix[column] = {}
		for line = 1, lines do
	    	occupationMatrix[column][line] = 0
		end
	end

	for column = 1, columns do
		for line = 1, lines do
			position = { x = column , y = line }
        	table.insert(occupationPosibility, position)
    	end
	end

	shuffleOccupation(occupationPosibility);

	time = 0
end

function World.createAnimationToAnimals(key)
	for direction = 1, 4 do
		if key == directions[direction] then
			Snake.newMemory(Snake.getX(), Snake.getY(), direction)
		end
	end
end

function World.update(dt)
	time = time + dt
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

function World.getOccupationMatrix()
	return occupationMatrix
end

function World.getOccupationPosibility()
	return occupationPosibility
end

function World.getTimeInSeconds()
	return time * 1000
end

return World
