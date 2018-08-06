obj
	Water
		state = "Water"
		Waterball
			icon = 'waterball.dmi'
			density = 1
			//What kind of battle can this do?
			deletesOnImpact = 1
			isBattleReady = 1
			isHeatable = 1
			isImpactable = 1
			impacts = 1
			heats = 1
		//End kinds of battle
			New()
				.=..()
				setHp(1000)
				setStrength(100)
				setDefense(9999)
				setToughness(0)
				setSharpness(0)
				setHeatThreshold(500)
				setHeat(30)
				setSpecificHeat(4)
			die()
				del(src)