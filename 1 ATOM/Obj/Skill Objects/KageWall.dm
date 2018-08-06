obj
	Walls
		KageWall
			icon = 'kageWall.dmi'
			density = 1
			New()
				.=..()
				spawn() initialize()
			initialize()
				setHp(35000)
				setStrength(70)
				setDefense(7500)
				setToughness(100)
				setBlood(100)
				setSharpness(0)
				setToughness(1000)
				setHeatThreshold(1900)
				setHeat(100)
				setSpecificHeat(20)
			die(var/atom/movable/m)
				del(src)
	Stairs
		icon = 'stairs.dmi'
