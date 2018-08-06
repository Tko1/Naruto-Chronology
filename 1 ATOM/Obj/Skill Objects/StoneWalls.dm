obj
	Walls
		StoneWalls
			icon = 'stoneWalls.dmi'
			density = 1

			New()
				.=..()
				setHp(300)
				setStrength(0)
				setDefense(150)
				setToughness(500)
				setBlood(30)
				setSharpness(0)
				setHeatThreshold(590)
				setHeat(100)
				setSpecificHeat(4)
				conductivity=0
				//TODO
			die(var/atom/movable/m)
				del(src)