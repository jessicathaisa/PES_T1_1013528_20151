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
local foodAte = 0

local WIDTH = Utils.getWidth()
local HEIGHT = Utils.getHeight()

local wallpaperImage = love.graphics.newImage("images/wallpaper.jpg")

-- Inicializes all the necesary variables to a World
-- Parameters
-- 
-- Return
--
function World.load()

	directions = Snake.getDirections()
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

	shuffleOccupation(occupationPosibility);

	time = 0
	foodAte = 0

	starttime = os.time()
end

-- Creates a new memory for the controlables classes, according to the direction typed
-- Parameters
-- 		key:	Direction [1..4]
-- Return
--
function World.keypressed(key)
	for direction = 1, 4 do
		if key == directions[direction] then
			Snake.newMemory(Snake.getX(), Snake.getY(), direction)
		end
	end
end

-- Updates the time and increase a food colision
-- Parameters
-- 		dt:	time transcorred after last execution
--		ate: boolean (1) if there was a colision with food (0) otherwise
-- Return
--
function World.update(dt, ate)
	time = time + dt
	if ate then
		foodAte = foodAte + 1
	end
end

-- Draws in the screen the time of game and the score
-- Parameters
--
-- Return
--
function World.draw()
	love.graphics.draw(wallpaperImage, 0, 0)

	endtime = os.time()
	local elapsedtime = os.difftime(endtime,starttime)

	local hh, mm, ss = World.getFormatedTime(elapsedtime)
	local hhs = ""	mms = ""	sss = ""
	if hh < 10 then hhs = "0" end
	if mm < 10 then mms = "0" end
	if ss < 10 then sss = "0" end

	love.graphics.setColor(0,0,0)
	love.graphics.setFont( love.graphics.newFont( 16 ) )
	love.graphics.print("Tempo de Jogo: " .. hhs .. hh .. ":" .. mms .. mm .. ":" .. sss .. ss .. "       Pontos: " .. foodAte * 10, 10, 10)
	love.graphics.setColor(255,255,255)
end

-- Shuffle the elements of a table
-- Parameters
--		table: table to be 'shuffled'
-- Return
--
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

function World.getFormatedTime(elapsedTime)
	local ss = elapsedTime % 60
	local mm = (elapsedTime / 60) % 60
	local hh = (elapsedTime / 60) / 60
	if ss < 1 then ss = 0 end
	if mm < 1 then mm = 0 end
	if hh < 1 then hh = 0 end
	
	return Utils.round(hh), Utils.round(mm), Utils.round(ss)
end


return World
