

-- Declation of "global" variables

local directions = { "left", "right", "up", "down" }
local directionsOpost = { "right", "left", "down", "up" }

local move = true
local colision = false
local pause = false

local M = 40	N = 20

local screen_width = 32 * M
local screen_height = 32 * N

local execTime = 0.0

local snake = {
	x = 0,
	y = 0,
	boxes = {},
	size = 32,
	numBoxes = 0,
	direction = "",
	velocity = 0
}

local wallpaperImage = love.graphics.newImage("wallpaper.jpg")
local scaleImage = love.graphics.newImage("scale.png")

local matrixOccupation = {}


local positions = {}

-- Declaration of functions and callbacks

function randomizeDirection ()
	math.randomseed( os.time() )
	math.random(1,4); math.random(1,4); math.random(1,4)
	return  math.random(1,4)
end

function randomizeDuration ()
	math.randomseed( os.time() )
	math.random(20,40); math.random(20,40); math.random(20,40)
	return math.random(20,40)
end

function love.load()
	loadGame()
end

function love.keypressed(key)
	if colision and key == "return" then
		loadGame()
	end

	if key == "up" or key == "down" or key == "right" or key == "left" then
		if key ~= directionsOpost[snake.direction] then
			for directionCont = 1, 4 do
				if key == directions[directionCont] then
					table.insert(positions, newPosition(snake.x, snake.y, directionCont, snake.numBoxes))
				end
			end
		end
	end

	if key == " " then
		pause = not(pause)
	end
end

function love.update(dt)
	if move and not(pause) then
		move = false
		for boxCount, currentBox in ipairs(snake.boxes) do
			for posCount, currentPosition in ipairs(positions) do
				if currentBox.x == currentPosition.x and currentBox.y == currentPosition.y then
					currentBox.direction = currentPosition.posDirection
					currentPosition.posDuration = currentPosition.posDuration - 1;
				end
			end


			if currentBox.startIn == 0 then
				matrixOccupation[currentBox.x/snake.size + 1][currentBox.y/snake.size + 1] = 0
				currentBox = walkOneStep(currentBox)

				-- if after walk the position is already 1, we have a colision
				if matrixOccupation[currentBox.x/snake.size + 1][currentBox.y/snake.size + 1] == 1 then
					colision = true;
				else
					matrixOccupation[currentBox.x/snake.size + 1][currentBox.y/snake.size + 1] = 1
				end
			else
				currentBox.startIn = currentBox.startIn - 1
			end

			if boxCount == 1 then
				snake.x = currentBox.x
				snake.y = currentBox.y
				snake.direction = currentBox.direction

			end

			
		end

		positionsAux = {}

		for boxCount, currentPosition in ipairs(positions) do
			if currentPosition.posDuration ~= 0 then
				table.insert(positionsAux, currentPosition)
			end
		end
		positions = positionsAux
	end

end

function love.draw()
	if colision then
		love.graphics.print( "Perdeu!", screen_width/3, screen_height/3, 0, 5, 5)
	elseif not(pause) then
		
		love.graphics.draw(wallpaperImage, 0, 0)

		execTime = os.clock()*1000 - timerStart
		if execTime >= (1000 / snake.velocity) then
			timerStart = os.clock() * 1000
			move = true;
		else
			move = false;
		end


		head = snake.boxes[1]
		love.graphics.print("------ x:" .. (head.x/snake.size) .. "   y:" .. (head.y/snake.size) .. " ------", 100, 100)


		love.graphics.print("------ Time: " .. os.clock() .. " ------", 10, 10)

		for boxCount, box in ipairs(snake.boxes) do
			love.graphics.draw(scaleImage, box.x, box.y)
		end
	else
		love.graphics.print( "Jogo Pausado!", screen_width/3, screen_height/3, 0, 5, 5)
	end
end


function loadGame()
	move = false
	colision = false
	pause = false
	execTime = 0.0

	for boxCount in pairs (snake.boxes) do
		snake.boxes[boxCount] = nil
	end

	for posCount in pairs (positions) do
		positions[posCount] = nil
	end

	snake.x = screen_width / 2
	snake.y = screen_height / 2
	snake.boxes = {}
	snake.numBoxes = 0
	snake.diretion = ""

	snake.velocity = 5
	randomDirection = randomizeDirection()
	table.insert(snake.boxes, newSnakeBox(snake.x, snake.y, 0, randomDirection))
	table.insert(snake.boxes, newSnakeBox(snake.x, snake.y, 1, randomDirection))
	table.insert(snake.boxes, newSnakeBox(snake.x, snake.y, 2, randomDirection))
	table.insert(snake.boxes, newSnakeBox(snake.x, snake.y, 3, randomDirection))
	table.insert(snake.boxes, newSnakeBox(snake.x, snake.y, 4, randomDirection))
	table.insert(snake.boxes, newSnakeBox(snake.x, snake.y, 5, randomDirection))
	snake.numBoxes = snake.numBoxes + 6
	
	table.insert(positions, newPosition(snake.x, snake.y, randomDirection, snake.numBoxes))
	zeroMatrix()
	timerStart = os.clock() * 1000
	
	move = true
end

-- POSITION FUNCTIONS
function newPosition(startX, startY, direction, duration)
	position = {
	x = startX,
	y = startY,
	posDirection = direction,
	posDuration = duration
	}

	return position
end


-- SNAKE FUNCTIONS
function newSnakeBox(startX, startY, boxesInFront, direction)
	snakeBox = {
	x = startX,
	y = startY,
	boxDirection = direction,
	startIn = boxesInFront
	}
	return snakeBox
end



function verifyColision()
	head = snake.boxes[1]

	for i,box in ipairs(snake.boxes) do
		if i ~= 1 then
			colision = head.x == box.x and head.y == box.y
			colisionx = head.x
			colisiony = head.y
		else
			colision = false
		end
	end
end

function walkOneStep(snakeBox)
	step = snake.size

	if directions[snakeBox.direction] == "up" then
		if snakeBox.y - step < 0 then
			snakeBox.y = screen_height - step
		else
			snakeBox.y = snakeBox.y - step
		end
	elseif directions[snakeBox.direction] == "down" then
		if snakeBox.y + step >= screen_height then
			snakeBox.y = 0
		else
			snakeBox.y = snakeBox.y + step
		end
	elseif directions[snakeBox.direction] == "left" then
		if snakeBox.x - step < 0 then
			snakeBox.x = screen_width - step
		else
			snakeBox.x = snakeBox.x - step
		end
	elseif directions[snakeBox.direction] == "right" then
		if snakeBox.x + step >= screen_width then
			snakeBox.x = 0
		else
			snakeBox.x = snakeBox.x + step
		end
	end

	return snakeBox
end


-- MATRICES FUNCTIONS

function zeroMatrix()
	for i=1,M+1 do
		matrixOccupation[i] = {}     -- create a new row
		for j=1,N+1 do
        	matrixOccupation[i][j] = 0
    	end
	end
end