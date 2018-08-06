obj
	Environment
		Dense
			density = 1

			Water
				icon = 'water.dmi'
				message = list("fish")
				Click()
					for(var/obj/Environment/Dense/Water/w in oview(1))
						if(w!=src)
							continue
						if(prob(usr:fishing))
							var/mob/MainCharacter/M = usr
							if(!usr.addContents(new /obj/Food/Fish/BasicFish)){usr << "Your inventory is full";return 0}
							M.addFishingXP(5)
						else
							usr << "<font color=cyan>You failed to _catch anything"
		Water
