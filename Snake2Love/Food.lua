-- Pontifícia Universidade Católica do Rio de Janeiro - PUC-Rio
-- Princípios de Engenharia de Software - 2015.1
-- Trabalho 1
-- Jéssica Thaisa Silva de Almeida
--
-- Food.lua module

local Food = {}
local Utils = require "Utils"

local executionTime = 0
local startTime = 0
local indexOccupation

local food = {
	x = 0,
	y = 0,
	duration = 0
}

local foodImage = love.graphics.newImage("images/fruit.png")

-- Inicializes all the necesary variables to a Food
-- Parameters
-- 
-- Return
--
function Food.load()

	executionTime = 0
	startTime = 0
	indexOccupation = 1

	food = {
		x = 1,
		y = 1,
		duration = 0
	}
end

-- Inicializes all the necesary variables to a Food
-- Parameters
-- 
-- Return
--
function Food.update(dt, matrixOccupation, occupationPosibility, ateFood)
	-- ASSERT<>
	-- Is warranted that only will be created a new food if (the food was eaten) or (the time of the food finished)
	-- <We count the time each second>
	-- <We verify if the food was eaten>
	-- It ensures our input assertive
	executionTime = executionTime + dt
	ellapsedTime = executionTime - startTime
	if ellapsedTime < food.duration and not(ateFood) then
		return
	end
	startTime = executionTime

	-- creation of new food
	matrixOccupation[food.x][food.y] = 0
	while true do
		actualOccupation = occupationPosibility[indexOccupation]
		if matrixOccupation[actualOccupation.x][actualOccupation.y] == 0 then
			food.x = actualOccupation.x
			food.y = actualOccupation.y
			food.duration = Utils.randomize(20, 40)

			matrixOccupation[food.x][food.y] = 2

			indexOccupation = indexOccupation + 1
			return
		else
			if occupationPosibility[indexOccupation + 1] == nil then
				indexOccupation = 1
			else
				indexOccupation = indexOccupation + 1;
			end
		end
	end
end

-- Draws in the screen the image of the food
-- Parameters
--
-- Return
--
function Food.draw()
	love.graphics.draw(foodImage, (food.x - 1)* Utils.getGridSize(), (food.y - 1) * Utils.getGridSize())
end


return Food