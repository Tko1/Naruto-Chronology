proc/inList(var/object,var/theList)
	for(var/thing in theList)
		if(thing==object)
			world << "[thing] is in this list!"
			return 1
	return 0
proc/removeListFromList(var/subList,var/list)
	var/output = list
	for(var/thing in subList)
		if(inList(thing,output))
			output = removeFromList(thing,output)
	return output

proc/removeFromList(var/object,var/theList)
	var/list/newList = list()
	var/hasRemoved = 0
	for(var/a in theList)
		if(a!=object)
			newList += a

		if(a==object&&!hasRemoved)
			hasRemoved = 1
		else
			if(a==object&&hasRemoved)
				newList += a
	return newList
proc/removeAllFromList(var/object,var/theList)
	var/list/newList = list()
	for(var/a in theList)
		if(a!=object)
			newList += a
	return newList

