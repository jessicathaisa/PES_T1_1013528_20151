-- Pontifícia Universidade Católica do Rio de Janeiro - PUC-Rio
-- Princípios de Engenharia de Software - 2015.1
-- Trabalho 1
-- Jéssica Thaisa Silva de Almeida
--
-- Utils.lua module

local Utils = {}

local LINES_NUMBER = 20
local COLUMNS_NUMBER = 40
local gridSize = 32

function Utils.getHeight()
	return LINES_NUMBER
end

function Utils.getWidth()
	return COLUMNS_NUMBER
end

function Utils.getGridSize()
	return gridSize
end

function Utils.randomize(start, final)
	math.randomseed( os.time() )
	
	math.random(start,final)
	math.random(start,final)
	math.random(start,final)

	return math.random(start,final)
end

function Utils.round(num)
    under = math.floor(num)
    upper = math.floor(num) + 1
    underV = -(under - num)
    upperV = upper - num
    if (upperV > underV) then
        return under
    else
        return upper
    end
end

return Utils