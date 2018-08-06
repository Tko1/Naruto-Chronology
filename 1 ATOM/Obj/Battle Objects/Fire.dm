obj
	Fire
		explodes = 1
		state = "Fire"
		//What kind of battle can this do?
		deletesOnImpact = 1
		isBattleReady = 1
		isHeatable = 1
		heats = 1
		var/heatCoefficient = 20
	//End kinds of battle
		New()
			.=..()
			spawn() initialize()
		initialize()
			setHp(1000)
			setStrength(0)
			setDefense(0)
			setToughness(0)
			setSharpness(0)
			setHeatThreshold(9000)
			setHeat(400)
			setSpecificHeat(10)
			while(!src.owner)
				world << "ERROR: [src] needs owner"
				sleep(1)
			setHeat(src.heat + owner:ninjutsu*heatCoefficient)
		Housenka
			icon = 'fireball.dmi'
			density = 1
			heatCoefficient = 5
		Goukakyuu
			heatCoefficient = 10
			New()
				.=..()
				spawn()
					beginBurning()
				spawn(15)
					die()
			proc/beginBurning()
				while(src)
					for(var/atom/movable/m in view(0,src))
						if(m==src)continue
						src.heat(m)
					sleep(5)
		Ameratsu
			icon = 'ameratsu.dmi'
			initialize()
				..()
				setHeat(1000)
				spawn(300) die()
				while(src)
					sleep(5)
		die()
			del(src)


