-- Declation of "global" variables
Game = require "Game"

local screen_width = 32 * 40
local screen_height = 32 * 20

local execTime = 0.0
local timerStart = 0.0


local food = {
	x = 0,
	y = 0,
	duration = 0
}
local wallpaperImage = love.graphics.newImage("wallpaper.jpg")
local scaleImage = love.graphics.newImage("scale.png")


function love.load()
	Game.disallowMove()
	execTime = 0.0
	timerStart = os.clock() * 1000
	Game.StartNewGame()

	Game.allowMove()
end

function love.keypressed(key)
	Game.keypressed(key)
end

function love.update(dt)
	Game.update()
end

function love.draw()
	if Game.haveColision() then
		love.graphics.print( "Perdeu!", screen_width/3, screen_height/3, 0, 5, 5)
	elseif not(Game.isPaused()) then
		

		love.graphics.draw(wallpaperImage, 0, 0)

		execTime = os.clock()*1000 - timerStart
		if execTime >= (1000 / Game.getVelocity()) then
			timerStart = os.clock() * 1000
			Game.allowMove()
		else
			Game.disallowMove()
		end
		
		head = Game.getMembers()[1]
		love.graphics.print("------ x:" .. (head.x/32) .. "   y:" .. (head.y/32) .. " ------", 100, 100)

		love.graphics.print("------ Time: " .. "teste" .. " ------", 10, 10)

		for boxCount, box in ipairs(Game.getMembers()) do
			love.graphics.draw(scaleImage, box.x, box.y)
		end
	else
		love.graphics.print( "Jogo Pausado!", screen_width/3, screen_height/3, 0, 5, 5)
	end
end