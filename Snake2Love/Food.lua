-- Pontifícia Universidade Católica do Rio de Janeiro - PUC-Rio
-- Princípios de Engenharia de Software - 2015.1
-- Trabalho 1
-- Jéssica Thaisa Silva de Almeida
--
-- Food.lua module

local Food = {}

local Utils = require "Utils"

local execTime = 0
local startTime = 0
local indexOccupation
local newFoodSemaphore = false

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

	execTime = 0
	startTime = 0
	newFoodSemaphore = false
	indexOccupation = 1

	food = {
		x = 1,
		y = 1,
		duration = 0
	}
end

function Food.update(dt, matrixOccupation, occupationPosibility, ateFood)
	execTime = execTime + dt

	deltaT = execTime - startTime
	if deltaT < food.duration and not(ateFood) then
		return
	end

	startTime = execTime

	Food.createNew(matrixOccupation, occupationPosibility)
end

function Food.draw()

	if newFoodSemaphore then
		return
	end

	love.graphics.draw(foodImage, (food.x - 1)* Utils.getGridSize(), (food.y - 1) * Utils.getGridSize())
end

function Food.createNew(matrixOccupation, occupationPosibility)
	matrixOccupation[food.x][food.y] = 0
	while true do
		actualOccupation = occupationPosibility[indexOccupation]
		if matrixOccupation[actualOccupation.x][actualOccupation.y] == 0 then -- position is empty, I can put the food here
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

return Food