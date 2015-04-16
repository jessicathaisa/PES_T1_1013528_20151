-- Pontifícia Universidade Católica do Rio de Janeiro - PUC-Rio
-- Princípios de Engenharia de Software - 2015.1
-- Trabalho 1
-- Jéssica Thaisa Silva de Almeida
--
-- Game.lua module

local Game = {}

local Utils = require "Utils"
local World = require "World"
local Snake = require "Snake"
local Food = require "Food"

local SCORETOWIN = 1000

local gameMoving
local gamePause
local snakeActualDirection
local snakeColision
local snakeAteFood
local gameScore
local wonGame


local directions = { "left", "right", "up", "down" }
local directionsOpost = { "right", "left", "down", "up" }


local pauseImage = love.graphics.newImage("images/telaPausou.png")
local wonImage = love.graphics.newImage("images/telaGanhou.png")
local loseImage = love.graphics.newImage("images/telaPerdeu.png")
local beginImage = love.graphics.newImage("images/telaInicial.png")

-- Inicializes all the necessary variables to a Game
-- Parameters
-- 
-- Return
--
function Game.load()
	gameMoving = false
	gamePause = false
	snakeActualDirection = false
	snakeColision = false
	snakeAteFood = false
	wonGame = false
	gameScore = 0

	World.load()
	Snake.load()
	Food.load()

	gameMoving = true
end

-- Starts the updates to each Element of the game
-- Parameters
-- 		dt: Time transcorred after last update
-- Return
--
function Game.update(dt)
	--ASSERT<>
	-- Is necesary to ensure that we only update if doesn't have a colision, the player
	--		doens't won the game and the game is not paused
	-- <We test the snake colision>
	-- It ensures our input assertive
	if not (snakeColision) and not (wonGame) then
		gameMoving = true
		if gameMoving and not(gamePause) then
			matrixOccupation, occupationPosibility = World.getOccupation()

			snakeActualDirection, snakeColision, snakeAteFood = Snake.update( dt , matrixOccupation)
			Food.update( dt , matrixOccupation, occupationPosibility, snakeAteFood)
			gameScore = World.update( dt, snakeAteFood)

			if gameScore == SCORETOWIN then
				wonGame = true
			end
		end
		gameMoving = false
	end
end

-- Draws each object in the world
-- Parameters
-- 	
-- Return
--
function Game.draw()
	if wonGame then
		love.graphics.draw(wonImage, 0, 0)
	elseif snakeColision then
		love.graphics.draw(loseImage, 0, 0)

		love.graphics.setColor(170,170,100)
		love.graphics.setFont( love.graphics.newFont( 50 ) )
		love.graphics.print("Pontuação: " .. gameScore .. " pts", 32*13, 32*18)

		love.graphics.setColor(255,255,255)
	elseif not(gamePause) then
		World.draw()
		Snake.draw()
		Food.draw()
	else
		love.graphics.draw(pauseImage, 0, 0)
	end
end

-- Controls  the actions when a keypression is detected
-- Parameters
-- 		key: key in the keyboard that was pressed
-- Return
--
function Game.controller(key)
	if (snakeColision or wonGame) and (key == "return" or key == "kpenter" ) then
		Game.load()
	end
	if key == "up" or key == "down" or key == "right" or key == "left" then
		--ASSERT<>
		-- Is necesary to ensure that we only recognize the command to turn if the player
		--		doesn't press the key for the oppost direction
		-- <We test if the direction is the oppost one>
		-- It ensures our input assertive
		if key ~= directionsOpost[snakeActualDirection] then
			for direction = 1, 4 do
				if key == directions[direction] then
					Snake.newMemory(direction)
				end
			end
		end
	end

	if key == " " then
		gamePause = not(gamePause)
	end

	if key == 'escape' then
		love.event.quit()
	end
end

return Game