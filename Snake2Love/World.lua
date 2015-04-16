-- Pontifícia Universidade Católica do Rio de Janeiro - PUC-Rio
-- Princípios de Engenharia de Software - 2015.1
-- Trabalho 1
-- Jéssica Thaisa Silva de Almeida
--
-- World.lua module

local World = {}
local Utils = require "Utils"

local occupationMatrix = {}
local occupationPosibility = {}

local time = 0
local foodEaten = 0

local WIDTH = Utils.getWidth()
local HEIGHT = Utils.getHeight()

local wallpaperImage = love.graphics.newImage("images/wallpaper.jpg")

-- Inicializes all the necessary variables to a World
-- Parameters
-- 
-- Return
--
function World.load()

	occupationMatrix = {}
	occupationPosibility = {}

	for column = 1, WIDTH do
		occupationMatrix[column] = {}
		for line = 1, HEIGHT do
	    	occupationMatrix[column][line] = 0
		end
	end

	for column = 1, WIDTH do
		for line = 1, HEIGHT do
			position = { x = column , y = line }
        	table.insert(occupationPosibility, position)
    	end
	end

	Utils.shuffleTable(occupationPosibility);

	time = 0
	foodEaten = 0

	starttime = os.time()
end

-- Updates the time and increase a food eaten
-- Parameters
-- 		dt:	time transcorred after last execution
--		ate: boolean (1) if there was a colision with food (0) otherwise
-- Return
--		Actual Score of the game
function World.update(dt, ate)
	time = time + dt
	if ate then
		foodEaten = foodEaten + 1
	end

	return foodEaten * 10
end

-- Draws in the screen the time of game and the score
-- Parameters
--
-- Return
--
function World.draw()
	love.graphics.draw(wallpaperImage, 0, 0)

	endtime = os.time()
	local elapsedTime = os.difftime(endtime,starttime)

	-- formats the Ellapsed Time
	local ss = Utils.round(elapsedTime % 60)
	local mm = Utils.round((elapsedTime / 60) % 60)
	local hh = Utils.round((elapsedTime / 60) / 60)
	if ss < 1 then ss = 0 end
	if mm < 1 then mm = 0 end
	if hh < 1 then hh = 0 end

	-- zero in the left to formate
	local hhzero = ""	mmzero = ""	sszero = ""
	if hh < 10 then hhzero = "0" end
	if mm < 10 then mmzero = "0" end
	if ss < 10 then sszero = "0" end

	love.graphics.setFont( love.graphics.newFont( 16 ) )
	love.graphics.print("Tempo de Jogo: " .. hhzero .. hh .. ":" .. mmzero .. mm .. ":" .. sszero .. ss .. "       Pontos: " .. foodEaten * 10, 10, 10)
	
end


-- Gets a informations about the occupation of the world
-- Parameters
--		
-- Return
--		The Occupation Matrix
function World.getOccupation()
	return occupationMatrix, occupationPosibility
end


return World
