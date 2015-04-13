-- Pontifícia Universidade Católica do Rio de Janeiro - PUC-Rio
-- Princípios de Engenharia de Software - 2015.1
-- Trabalho 1
-- Jéssica Thaisa Silva de Almeida
--
-- Utils.lua module

local Utils = {}

local N = 20
local M = 40
local gridSize = 32

function Utils.getN()
	return N
end

function Utils.getM()
	return M
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

return Utils