obj
	Minerals
		density = 1
		Gold
			icon = 'gold.dmi'
			message = list("mine")
			Rock
				icon_state  = "rock"
				Click()
					//mine
					if(!prob(usr:mining)/2){usr << "You failed to mine the ore";return 0}
					if(usr.addContents(new /obj/Ores/Gold/Ore))usr:addMiningXP(25)
	Ores
		droppable = 1
		gettable = 1
		density = 0
		Gold
			icon = 'gold.dmi'
			Ore
				icon_state = "ore"