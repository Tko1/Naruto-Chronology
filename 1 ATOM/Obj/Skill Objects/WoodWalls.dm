obj
	Walls
		preventsSpawning = 1
		WoodWalls
			icon = 'woodWalls.dmi'
			density = 1
			New()
				.=..()
				setHp(350)
				setStrength(0)
				setDefense(75)
				setToughness(100)
				setBlood(100)
				setSharpness(0)
				setHeatThreshold(190)
				setHeat(100)
				setSpecificHeat(8)
				spawn(5)
					setDefense(75*owner:building)
			die(var/atom/movable/m)
				del(src)
