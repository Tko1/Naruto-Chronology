turf
	state = "Empty"
turf
	proc/isOccupied()
		if(contains(src.state,"Empty"))
			return 0
		else
			return 1
	proc/setOccupied(var/boolean)
		if(boolean)
			if(contains(src.state,"Empty"))
				src.setState(replace(src.state,"Empty","Occupied"))
			else
				src.addState(",Occupied")
		else
			if(contains(src.state,"Occupied"))
				src.setState(replace(src.state,"Occupied","Empty"))