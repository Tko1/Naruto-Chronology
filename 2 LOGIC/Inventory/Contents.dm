mob
	proc
		inventoryWeightCheck(var/n)
			if(!istype(src,/mob/MainCharacter))return 1
			if(src:inventoryWeight + n>src:weightLimit)return 0
			return 1
		addContents(var/obj/ob)
			//var/foundMatch
			if(istype(src,/mob/MainCharacter)&&ob.weight+src:inventoryWeight>src:weightLimit){del(ob);return 0}
			for(var/obj/O in src.contents)
				if(istype(O,ob))
					//foundMatch = 1
					O.count++
					O.inventoryName()
					if(istype(src,/mob/MainCharacter))src:inventoryWeight += O.weight
					del(ob)
					return 1
		//	if(!foundMatch)
			src.contents += ob
			if(istype(src,/mob/MainCharacter))src:inventoryWeight += ob.weight
			ob.addMessage("drop")
			return 1
atom
	movable
		proc/inside(var/amIInsideThis)
			if(istype(amIInsideThis,/mob))
				for(var/ob in amIInsideThis:contents)
					if(ob == src)
						return 1
				return 0
			else
				for(var/ob in amIInsideThis)
					if(ob==src)
						return 1
				return 0
obj
	var/originalName
	proc
		inventoryName()
			if(!originalName)
				originalName = name
			if(!count)
				name = originalName
			else
				name = "[originalName] x [count]"
