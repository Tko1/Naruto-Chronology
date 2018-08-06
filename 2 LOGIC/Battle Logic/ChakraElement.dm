mob
	MainCharacter
		proc/addChakraElement(var/t)
			if(!src.chakraElement) {src.chakraElement = list();}
			src.chakraElement += t
		proc/hasElement(var/t)
			if(inList(t,chakraElement))
				return 1
			return 0
