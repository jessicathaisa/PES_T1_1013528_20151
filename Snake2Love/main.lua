-- Declation of "global" variables

local directions = { "left", "right", "up", "down" }
local directionsOpost = { "right", "left", "down", "up" }

local screen_width = 54 * 15
local screen_height = 54 * 11

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

local positions = {}

-- Declaration of functions and callbacks

function randomizeDirection ()
	randomDirection = math.random(1,4)
    return randomDirection
end

function randomizeDuration ()
	randomDuration = math.random(6,20)
    return randomDuration
end

function love.load()
	snake.velocity = 0.2
	randomDirection = randomizeDirection()
	table.insert(snake.boxes, newSnakeBox(0, 0, 0, randomDirection))
	snake.numBoxes = snake.numBoxes + 1
	
	table.insert(positions, newPosition(snake.x, snake.y, randomDirection, snake.numBoxes))
	
	timerStart = love.timer.getTime()
end

function love.keypressed(key)
	if key == "up" or key == "down" or key == "right" or key == "left" then
		for directionCont = 1, 4 do
			if key == directions[directionCont] then
				table.insert(positions, newPosition(snake.x, snake.y, directionCont, snake.numBoxes))
			end
		end
	end
end

function love.update(dt)
	for i, currentBox in ipairs(snake.boxes) do
		for j, currentPosition in ipairs(positions) do
			if currentBox.x == currentPosition.x and currentBox.y == currentPosition.y then
				currentBox.direction = currentPosition.posDirection
				currentPosition.posDuration = currentPosition.posDuration - 1;
			end
		end
		
		if currentBox.startIn == 0 then
			currentBox = walkOneStep(currentBox)
		else
			currentBox.startIn = currentBox.startIn - 1
		end
		
		if i == 1 then
			snake.x = currentBox.x
			snake.y = currentBox.y
			snake.direction = currentBox.direction
		end
	end
	
	positionsAux = {}
	
	for i, currentPosition in ipairs(positions) do
		if currentPosition.posDuration ~= 0 then
			table.insert(positionsAux, currentPosition)
		end
	end
	positions = positionsAux

end

function love.draw()
	execTime = love.timer.getTime() - timerStart
	
		love.graphics.print("------ Time: " .. execTime .. " ------", 10, 10)
	for i,box in ipairs(snake.boxes) do
		love.graphics.rectangle("fill", box.x, box.y, snake.size, snake.size)
	end
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

function walkOneStep(snakeBox)
	step = snake.velocity * snake.size
		
    if directions[snakeBox.direction] == "up" then
		if snakeBox.y - step < 0 then
			snakeBox.y = screen_height
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
			snakeBox.x = screen_width
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