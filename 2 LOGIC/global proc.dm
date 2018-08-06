proc
	isEmpty(var/stateToCheck)
		if(contains(stateToCheck,"Empty"))
			return 1
		return 0
	isPlantable(var/stateToCheck)
		if(contains(stateToCheck,"Plantable"))
			return 1
		return 0
	isDiagonal(var/d)
		if(d==NORTHEAST||d==NORTHWEST||d==SOUTHEAST||d==SOUTHWEST)return 1
		return 0
proc/getLeft(var/a)
	if(a==NORTH)return WEST
	if(a==EAST)return NORTH
	if(a==SOUTH)return EAST
	if(a==WEST)return SOUTH
proc/getRight(var/a)
	if(a==NORTH)return EAST
	if(a==EAST)return SOUTH
	if(a==SOUTH)return WEST
	if(a==WEST)return NORTH
proc/get_steps(var/ref,var/dir,var/amount)
	var/turf/buffer = get_step(ref,dir)
	var/output
	for(var/i = amount,i>1,i--)
		output = get_step(buffer,dir)
		buffer = output;
	return output
proc/get_left(var/ref,var/north)
	return get_step(ref,getLeft(north))
proc/get_right(var/ref,var/north)
	return get_step(ref,getRight(north))