obj
	Trees
		EbonyTree
			icon = 'Ebonytree.dmi'
			woodcuttingRequirement = 10
			wood = /obj/Wood/Build/EbonyWood
			seed = /obj/Wood/EbonyWoodSeed
			xpGain = 15
			maxChops = 3
			New()
				.=..()
				setHp(1000)
				setStrength(0)
				setDefense(500)
				setBlood(100)
				setToughness(100)
				setSharpness(0)
				setHeatThreshold(590)
				setHeat(100)
				setSpecificHeat(2)
			die(var/atom/movable/m)
				del(src)