obj
	Wood
		Build
			EbonyWood
				message = list("build","set build")
				weight = 7
				build()
					var/mob/MainCharacter/M = usr
					if(!M.canBuild())return
					if(processBuilds(build)==null)return
					convert(processBuilds(build), owna = usr)//new /obj/Walls/WoodWalls(get_step(usr,usr.dir))
					M.addBuildingXP(15)
				setBuild()
					build = input(usr,"What would you like to set the build default to?") in usr.getBuilds(src)