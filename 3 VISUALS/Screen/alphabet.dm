proc/makeWord(var/t as text)
	var/list/L = new /list()
	for(var/i = 1, i<=length(t),i++)
		var/copy = copytext(t,i,i+1)
		var/obj/Screen/Letter/l = new /obj/Screen/Letter()
		l.position[1] = i
		l.icon_state = "[copy]"
		L += l
	return L
obj
	Screen
		var/position[] = list(1,13)
		layer = MOB_LAYER+3
		doesNotExistInTheRealWorld = 1
		LevelUp
			layer = MOB_LAYER+2
			icon = 'hud_moves.dmi'
			icon_state = "levelup"
		Letter
			icon = 'alphabet.dmi'
		Other
		Skill
			Build
				WoodWalls
					icon = 'woodWalls.dmi'
					New()
						.=..()
						world << "Look at me"
					Click()
						build()
					build()
						new /obj/Walls/WoodWalls(usr.loc)
						var/mob/MainCharacter/M = usr
						M.addBuildingXP(5)
				WoodFloor
					icon = 'woodFloors.dmi'
					Click()
						build()
					build()
						new /obj/Floors/WoodFloor()
						var/mob/MainCharacter/M = usr
						M.addBuildingXP(5)
			New()
				.=..()
				position[2] = 1