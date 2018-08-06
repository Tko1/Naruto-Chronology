obj
	Electricity
		state = "Electricity"
		var/isConductive = 1
		New()
			.=..()
			spawn()
				beginShocking()
			spawn(15)
				die()
		proc/beginShocking()
			while(src)
				for(var/atom/movable/m in src.loc)

					src.shock(m)
				sleep(5)
		die()
			del(src)
		Shock
			icon = 'shock.dmi'
			density = 0
			//What kind of battle can this do?
			isHeatable = 1
			heats = 1

		//End kinds of battle
			New()
				.=..()
				setHeat(30)