obj
	Minerals
		density = 1
		Iron
			icon = 'stone.dmi'
			message = list("mine")
			Rock
				icon_state  = "rock"
				Click()
					//mine
					if(usr.addContents(new /obj/Ores/Iron/Ore))usr:addMiningXP(10)
	Ores
		droppable = 1
		gettable = 1
		density = 0


		Iron
			icon = 'iron.dmi'
			message = list("drop")
			MeltedIron
				icon_state = "meltedOre"
				message = list("get")
				get()
					if(..(usr))
						message = list("craft")
				craft()
					if(!usr:canCraft){usr<<"You cannot yet seem to grasp the molten metal";return 0}
					if(!usr.addContents(new /obj/Battle/Equipment/Chest/IronChestPlate))return 0
					src.convert()
			Ore
				icon_state = "ore"
				isBattleReady = 1
				isImpactable = 0
				isCuttable = 0
				conductivity = 0
				heats = 1
				heatThreshold = 1000
				icon_state = "ore"
				die()
					new /obj/Ores/Iron/MeltedIron(src.loc)
					del(src)