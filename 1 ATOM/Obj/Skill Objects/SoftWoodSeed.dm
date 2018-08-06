obj
	Wood
		SoftWoodSeed
			icon_state = "softWoodSeed"
			message = list("plant","drop")
			gettable = 1
			droppable = 1
			isBattleReady = 0
			weight = 1
			plant()
				var/turf/t = get_step(usr,usr.dir)
				if(isPlantable(t.state))
					src.convert(new /obj/Trees(get_step(usr,usr.dir)), owna = usr)
