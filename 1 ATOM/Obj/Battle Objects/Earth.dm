obj
	Earth
		state = "Earth"
		Boulder
			icon = 'boulder.dmi'
			density = 1
			//What kind of battle can this do?
			deletesOnImpact = 1
			isBattleReady = 1
			isHeatable = 1
			isImpactable = 1
			isCuttable = 1
			impacts = 1
			heats = 1
			var/strengthCoefficient = 10
		//End kinds of battle
			New()
				.=..()
				spawn() initialize()
			initialize()
				setHp(1000)
				setStrength(250)
				setDefense(1500)
				setToughness(1500)
				setSharpness(0)
				setBlood(1)
				setHeatThreshold(1500)
				setHeat(100)
				setSpecificHeat(10)
				spawn()
					while(!src.owner)
						world << "ERROR: Boulda needs an owna"
						sleep(1)
					setStrength(strengthCoefficient*owner:ninjutsu)
			die()
				del(src)