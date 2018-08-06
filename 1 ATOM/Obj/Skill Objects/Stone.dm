obj
	Minerals
		Click()
			if(usr:mining < mineRequirement)
				return 0
			return 1
		Stone
			icon = 'stone.dmi'
			message = list("mine")
			Rock
				icon_state  = "rock"
				Click()
					//mine
					if(!..())return 0
					if(usr.addContents(new /obj/Ores/Stone/Stones))usr:addMiningXP(5)
	Ores
		Stone
			icon = 'stone.dmi'
			Stones
				icon_state = "ore"
				buildRequirement = 10
				mineRequirement = 1
				message = list("build")
			//	Click()
			//		build()
				build()
					if(!..()){return 0}
					src.convert(new /obj/Walls/StoneWalls(get_step(usr,usr.dir)),owna = usr)
					var/mob/MainCharacter/M = usr
					M.addBuildingXP(15)