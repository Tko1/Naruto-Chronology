obj
	Wind
		state = "Wind"
		Cutter
			icon = 'windCutter.dmi'
			density = 1
			//What kind of battle can this do?
			deletesOnImpact = 1
			isBattleReady = 1
			isHeatable = 1
			cuts = 1

		//End kinds of battle
			New()
				.=..()
				setToughness(0)
				setSharpness(110)
				setHeatThreshold(9999)
				setSpecificHeat(2)