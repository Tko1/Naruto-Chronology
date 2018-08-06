//These disclude areas, and so are divided like this.
atom
	var/state
atom/movable
	proc/setState(var/text)
		src.state = text
	proc/addState(var/text)
		src.state += text
turf
	proc/setState(var/text)
		src.state = text
	proc/addState(var/text)
		src.state += text