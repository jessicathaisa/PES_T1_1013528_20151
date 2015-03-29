local directions = { "left", "right", "up", "down" }
local directionsOpost = { "right", "left", "down", "up" }


function randomizeDirection ()
	randomDirection = math.random(1,4)
    return randomDirection
end

function love.load()
	snake = {
		x = 0,
		y = 0,
		direction = randomizeDirection(),
		velocity = 0.1
	}
end

function love.keypressed(key)
	if key == "up" or key == "down" or key == "right" or key == "left" then
		for directionCont = 1, 4 do
			if key == directions[directionCont] then
				snake.direction = directionCont
			end
		end
	end
end

function love.update(dt)
	step = snake.velocity * 32
    if directions[snake.direction] == "up" then
        snake.y = snake.y - step
    elseif directions[snake.direction] == "down" then
        snake.y = snake.y + step
    elseif directions[snake.direction] == "left" then
        snake.x = snake.x - step
    elseif directions[snake.direction] == "right" then
        snake.x = snake.x + step
	end
end

function love.draw()
	love.graphics.rectangle("fill", snake.x, snake.y, 32, 32)
end
