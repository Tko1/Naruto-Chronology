//var/list/owners = list()
proc/boatStep(var/obj/o,var/direction)
	var/thereIsWater
	for(var/t in get_step(o,direction))
		if(istype(t,/obj/Environment/Dense/Water))
			thereIsWater = 1
			break
	if(!thereIsWater)
		o.getOff(direction)
		o.message = list("push")
		return
	step(o,direction)

obj
	Wood
		WoodBoat
			icon = 'woodBoat.dmi'
			density = 1
			message = list("push")
			push()
				var/turf/occupied = src.loc
				occupied.setOccupied(0)
				for(var/t in get_step(src,usr.dir))
					if(istype(t,/obj/Environment/Dense/Water))
						src.density = 0
						step(src,usr.dir)
						message = setMessage(1,"ride")
						return
				if(message[1]=="ride")
					message = list("push")
					step(src,usr.dir)

			ride()
				if(usr.state!="Standing") return
				setOwner(usr)
				usr.setState("Boating")
				usr.loc = src.loc
				usr.density = 0
				message = list("get off")
			getOff(var/direction as null)
				if(!direction)
					direction = usr.dir
				for(var/t in get_step(src,direction))
					if(istype(t,/obj/Environment/Dense/Water))
						return
				src.density = 1
				src.loc = get_step(src,direction)
				usr.loc = src.loc
				usr.density = 1
				usr.setState("Standing")
				setMessage(1,"ride")
				removeOwner(usr)
			New()
				.=..()
				setHp(1000)
				setStrength(0)
				setDefense(300)
				setToughness(100)
				setSharpness(0)
				setHeatThreshold(190)
				setHeat(100)
				setSpecificHeat(8)
				..()
				var/turf/t = src.loc
				t.setOccupied(1)
				world << "[t] is occupied"
			die(var/atom/movable/m)
				for(var/mob/M in world)
					if(M==src.owner)
						if(M.state=="Boating")
							M.die()
				del(src)

