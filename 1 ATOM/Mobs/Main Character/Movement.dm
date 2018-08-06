mob
	Move()
		if(src.client)
			if(!canMove())return 0
			..()
			if(src.state=="Boating")
				for(var/obj/ob in world)
					if(ob.owner==src)
						boatStep(ob,src.dir)
			atmosphere.heat(src)
			src.moveDelay()
		else
			if(istype(src,/mob/Enemies/Ameratsu))
				var/obj/Fire/Ameratsu/A = new /obj/Fire/Ameratsu(src.loc)
				A.dir = src.dir
			..()
