area
	Safezone
		Enter(atom/movable/M)
			if(istype(M,/mob/Enemies))
				world << "Nope"
				return 0
			if(!istype(M,/mob/MainCharacter))
				world << "Die"
				M.die()
			return ..()
		Entered()
			world << "Yo"
			usr.setState("Safezoned")
			return ..()
		Exited()
			usr.state = "Standing"
			return ..()
		Exited
		New()
			spawn(10)
				for(var/atom/a in src)
					a.state = "Safezoned"