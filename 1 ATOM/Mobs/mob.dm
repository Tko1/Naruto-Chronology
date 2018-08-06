mob
	var
		//movement
		cantMove = 0
		tmp/isMoving = 0
		moveSpeed = 5
		jutsuSpeed = 1
		list/spawnLocation
		//equipment references
		chest = 0
		leftArm = 0
		rightArm = 0
		twoHanded = 1
		head = 0
		leftLeg = 0
		rightLeg = 0
		leftFoot = 0
		rightFoot = 0
		underwear = 0
		//equipment booleans
		tmp/hasEquippedAxe

		//Jutsu booleans (by element)

		hasHousenka
		hasGoukakyuu

		hasWaterball

		hasBoulder

		hasWindCutter

		hasShock
		//Battle Stats
		ninjutsu = 1
		maxNinjutsu = 1

		genjutsu = 1
		maxGenjutsu = 1

		weapons
	isMob = 1
	proc/subChakra() //abstract proc
	proc/isChakraEmpty()//abstract proc
	proc/setSpawnLocation()
		if(!spawnLocation)spawnLocation = new /list(3)
		spawnLocation[1] = src.x
		spawnLocation[2] = src.y
		spawnLocation[3] = src.z
	proc/sendToDeathLocation()
		src.state = "Dead"
		src.loc = locate(19,6,2)
	proc/spawnFromSpawnLocation()
		if(src.loc)
			var/area/a = src.loc.loc
			if(a)a.Exited(src)
		src.loc = locate(spawnLocation[1],spawnLocation[2],spawnLocation[3])
		if(istype(src,/mob/Enemies))
			var/area/a = src.loc.loc
			a.Entered(src)
		src.state = "Standing"
	proc/getBuilds(var/O)
		var/list/output = list()
		var/mob/MainCharacter/M = src
		if(istype(O,/obj/Wood/Build/SoftWood))
			output += "Wood Walls"
			if(M.building>=5) output += "Wood Floor"
		//	if(M.building>=7) output += "Wood Sword"
			if(M.building>=20) output += "Wood Boat"
		//	if(M.building>=10) output += "Wood Shield"
		//	if(M.building>=15) output += "Wood Door"
		//	if(M.building>=15) output += "Wood Pole"
			//if(M.building>=20) output += "Wood Boat"

		if(istype(O,/obj/Wood/Build/EbonyWood))
			if(M.building>=20)output += "Black Walls"
			//if(M.building>=7) output += "Wood Sword"
			//if(M.building>=30) output += "Wood Boat"
			//if(M.building>=10) output += "Wood Shield"
			//if(M.building>=15) output += "Wood Door"
			//if(M.building>=15) output += "Wood Pole"
			//if(M.building>=20) output += "Wood Boat"
		if(istype(O,/obj/Ores/Stone))
			if(M.building>=10) output += "Stone Walls"
			if(M.building>=15) output += "Stone Floor"
			//if(M.building>=20) output += "Stone Club"
			//if(M.building>=25) output += "Stone Shield"
		return output
	//Jutsu
	verb/boulder()
		set name="Doton Doryudan"
		set category="Ninjutsu"
		if(!canBoulder()){return}
		src.setState("Boulder")
		var/obj/Earth/Boulder/water = new /obj/Earth/Boulder(locate(src.x,src.y,src.z))
		water.setOwner(src)
		walk(water,src.dir,2,0)
		src.boulderDelay()
	verb/windCutter()
		set name="Futon Kazekiri no Jutsu"
		set category="Ninjutsu"
		if(!canWindCutter()){return}
		src.setState("Wind Cutter")
		var/obj/Wind/Cutter/c = new /obj/Wind/Cutter(get_step(src,src.dir))
		c.dir = src.dir
		src.combatCut(c,get_step(src,src.dir))
		src.windCutterDelay()
	verb/waterball()
		set name="Suiton Suidan no Jutsu"
		set category="Ninjutsu"
		//state
		if(!canWaterball()){return}
		src.setState("Waterball")
		var/obj/Water/Waterball/water = new /obj/Water/Waterball(locate(src.x,src.y,src.z))
		water.setOwner(src)
		walk(water,src.dir,0,0)
		src.waterballDelay()
	verb/housenka()
		set name="Katon Housenka no Jutsu"
		set category="Ninjutsu"
		//state
		if(!canHousenka()){return}
		src.setState("Housenka")
		var/obj/Fire/Housenka/fireball = new /obj/Fire/Housenka(locate(src.x,src.y,src.z))
		fireball.setOwner(src)
		walk(fireball,src.dir,0,0)
		src.housenkaDelay()
	verb/ameratsu(var/mob/M in oview(6))
		set name="Ameratsu"
		set category="Ninjutsu"
		src << "No."
		return
		//state
		//if(!canHousenka()){return}
		//src.state = "Housenka"
		var/mob/Enemies/Ameratsu = new /mob/Enemies/Ameratsu(get_step(src,src.loc))
		Ameratsu.target = M
		//1src.housenkaDelay()
	verb/goukakyuu()
		set name="Katon Goukakyuu no Jutsu"
		set category="Ninjutsu"
		if(!canGoukakyuu()){return}
		src.setState("Goukakyuu")
		var/path = /obj/Fire/Goukakyuu
		// 1 2 Tails
		// 3 4 5 BottomL,M,R
		// 4 5 6 MiddleL,M,R
		// 7 8 9 TopL,M,R
		var/inFront = get_step(src,src.dir)
		var/inFrontOfThat = get_step(inFront,src.dir)
		var/ballBottom = get_steps(src,src.dir,3)
		var/ballMiddle = get_steps(src,src.dir,4)
		var/ballTop =  get_steps(src,src.dir,5)
		var/list/fire = list(new path(inFront),
							 new path(inFrontOfThat) // 1, 2 tails
			,new path(get_left(ballBottom,src.dir)),new path(ballBottom),new path(get_right(ballBottom,src.dir))
			,new path(get_left(ballMiddle,src.dir)),new path(ballMiddle),new path(get_right(ballMiddle,src.dir))
			,new path(get_left(ballTop,src.dir)),new path(ballTop),new path(get_right(ballTop,src.dir)));
		var/obj/Fire/Goukakyuu/referenceToTail = fire[1]
		referenceToTail.icon = 'goukakyuu.dmi'
		referenceToTail.dir = src.dir
		for(var/obj/Fire/Goukakyuu/G in fire)
			G.setOwner(src)
		if(src.dir==NORTH)
			referenceToTail.pixel_x -= 32
		if(src.dir==SOUTH)
			referenceToTail.pixel_y -= 32*4
			referenceToTail.pixel_x -= 32
		if(src.dir==EAST)
			referenceToTail.pixel_y -= 32*2
		if(src.dir==WEST)
			referenceToTail.pixel_y -= 32*2
			referenceToTail.pixel_x -= 32*4
		src.goukakyuuDelay()
proc/processCrafts(var/thing)
	if(thing=="Iron Helmet")
		return /obj/Battle/Equipment/Head/IronHelmet
	if(thing=="Iron Leg Armor"||thing=="Iron Leg Plates"||thing=="Iron Leg Plate")
		return /obj/Battle/Equipment/Legs/IronLegPlate
	if(thing=="Iron Chest Armor"||thing=="Iron Chest Plate")
		return /obj/Battle/Equipment/Chest/IronChestPlate
proc/processBuilds(var/thing)
	if(thing=="Wood Walls")
		return /obj/Walls/WoodWalls
	if(thing=="Wood Boat")
		return /obj/Wood/WoodBoat
	if(thing=="Wood Floor")
		return /obj/Floors/WoodFloor
	if(thing=="Black Walls")
		return /obj/Walls/EbonyWoodWalls
mob
	Click()
		..()
		if(message)
			processMessage(usr)
	proc/processMessage(mob/M)
		if(message[1]=="_catch")
			_catch(M)
	verb
		_catch(mob/M)