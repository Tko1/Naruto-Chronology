obj
	Walls
		//What kind of battle can this do?
		isBattleReady = 1
		isCuttable = 1
		isHeatable = 1
		isImpactable = 1
		impacts = 1
		cuts = 1
		heats = 1
		message = list("punch")
		//End kinds of battle
		New()
			.=..()
			var/turf/t = src.loc
			t.setOccupied(1)
