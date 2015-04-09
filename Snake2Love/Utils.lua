local Utils = {}

function Utils.randomize(start, final)
	math.randomseed( os.time() )
	
	math.random(start,final)
	math.random(start,final)
	math.random(start,final)

	return math.random(start,final)
end

return Utils