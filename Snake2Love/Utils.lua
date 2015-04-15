-- Pontifícia Universidade Católica do Rio de Janeiro - PUC-Rio
-- Princípios de Engenharia de Software - 2015.1
-- Trabalho 1
-- Jéssica Thaisa Silva de Almeida
--
-- Utils.lua module

local Utils = {}

local LINES_NUMBER = 20
local COLUMNS_NUMBER = 40
local GRIDSIZE = 32

function Utils.getHeight()
	return LINES_NUMBER
end

function Utils.getWidth()
	return COLUMNS_NUMBER
end

-- Gets the size of each box in the grid
-- Parameters
--	
-- Return
--		The gridsize
function Utils.getGridSize()
	return GRIDSIZE
end

-- Gets a random value beetween two integer numbers
-- Parameters
--		start:	Number that starts the interval of random numbers
--		final:	Number that ends the interval of random numbers
-- Return
--		A random integer number
function Utils.randomize(start, final)
	math.randomseed( os.time() )
	
	math.random(start,final)
	math.random(start,final)
	math.random(start,final)

	return math.random(start,final)
end

-- Rounds the given number
-- Parameters
--		num:	Number to round
-- Return
--		The given number rounded
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

-- Shuffle the elements of a table
-- Parameters
--		table: table to be 'shuffled'
-- Return
--
function Utils.shuffleTable(table)
	math.randomseed( os.time() )
	local rand = math.random
    local iterations = #table
    local j
    
    for i = iterations, 2, -1 do
        randomizedValue = rand(i)
        table[i], table[randomizedValue] = table[randomizedValue], table[i]
    end
end
return Utils