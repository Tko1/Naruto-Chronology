obj
	Walls
		EbonyWoodWalls
			icon = 'ebonyWoodWalls.dmi'
			density = 1
			New()
				.=..()
				setHp(1000)
				setStrength(0)
				setDefense(100)
				setToughness(200)
				setBlood(100)
				setSharpness(0)
				setHeatThreshold(590)
				setHeat(100)
				setSpecificHeat(8)
				spawn(5)
					setDefense(100*owner:building)
			die(var/atom/movable/m)
				del(src)