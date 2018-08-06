obj
	Ores
		isBattleReady = 0
		droppable = 1
		gettable = 1
		buildRequirement = 1
		message = list("get","drop")
		build()
			var/mob/MainCharacter/M = usr
			if(M.building<src.buildRequirement)
				world << "Building is [M.building], too low for [src.buildRequirement]"
				return 0
			return 1