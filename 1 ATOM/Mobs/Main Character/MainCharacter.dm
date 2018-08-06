mob
	MainCharacter
		icon = 'player.dmi'
		//What kind of battle can this do?
		isBattleReady = 1
		isCuttable = 1
		isHeatable = 1
		isImpactable = 1
		impacts = 0 //mobs do not impact when they run into you
		cuts = 1
		heats = 1
		message = list("attack")
		//End kinds of battle
		New()
			.=..()
			spawn() initialize()
		initialize()
			setHp(100)
			setStrength(75)
			setDefense(50)
			setBlood(100)
			setToughness(10)
			setSharpness(0)
			setHeatThreshold(300)
			setHeat(100)
			setSpecificHeat(4)
			src.addScreen(new /obj/Screen/Other/Health)
		var
			//Death
			//spawnLocation has been moved to mob
			//Macroes
			attackType = "punch"
			//Combat
			painTolerance //absorbs certain things
			//list/BodyParts*
			//SKILLS

			//Battle Skills
			chakra = 100 //how long you can use techniques
			maxChakra = 100
			chakraRegenRate = 1
			chakraRegenTime = 1
			tmp/isChakraRegen = 0

			stamina //how long you can fish, mine, etc

			list/chakraTypes //Fire, Water, Wind, Earth, Electricity

			level = 0
			levelXP = 0
			levelMaxXP = 5
			levelXPMultiplier = 1

			handToHand
			strengthMultiplier = 1
			//equipment
			leftHanded = 2
			rightHanded = 1
			leftFooted = 1
			rightFooted = 1

			//
			inventoryWeight = 0
			weightLimit = 100
			/* Moved to mobs, so enemies can use jutsu
			ninjutsu = 1
			maxNinjutsu = 1

			genjutsu = 1
			maxGenjutsu = 1

			weapons
			*/
			//bloodlust is in atom/movable
			physicalEnergy
			spiritualEnergy
			craftmanship
			speed
			//speeds
			//jutsuSpeed = 1 has been moved to all mobs
			//moveSpeed = 3 has been moved to all mobs

			//chakra elements
			//5 booleans, or 1 list? I'l ltry both
			list/chakraElement

			hasFireElement
			hasElectricityElement
			hasEarthElement
			hasWindElement
			hasWaterElement
			canCraft = 0

			//More booleans
			/*
			Have been moved to /mob
			hasHousenka
			hasGoukakyuu

			hasWaterball

			hasBoulder

			hasWindCutter

			hasShock
			*/
			//perk booleans
			isHunter

			//Other skills
			cooking = 1
			cookingXP
			cookingMaxXP

			building = 20 //subject for name change
			buildingXP = 0
			buildingMaxXP = 80

			mining = 1
			miningXP = 0
			miningMaxXP = 80

			fishing = 1
			fishingXP = 0
			fishingMaxXP = 80

			woodcutting = 1
			woodcuttingXP = 0
			woodcuttingMaxXP = 80

			//variables that allow you to use passive verbs like chop
			tmp/canChop

			//movement
		Click()
			if(src==usr)
				if(src.message[1]=="suicide")
					src.suicide()
				else
					var/mob/MainCharacter/M = usr
					M.action(M.attackType)
		verb/suicide()
			switch(input(src,"Are you sure you want to kill yourself? You will lose everything in your possession") in list("Yes","No"))
				if("Yes")
					src.die(src)
		subChakra(var/n)
			if(n<=0)
				world << "Error: negative chakra tried to be subbed"
				return
			else
				chakra -= n
				spawn()
					replenishChakra()
		isChakraEmpty()
			if(chakra<=0)
				return 1
		proc/replenishChakra()
			if(isChakraRegen)return 0
			isChakraRegen = 1
			while(chakra<maxChakra)
				chakra += chakraRegenRate
				sleep(100/chakraRegenTime)
			isChakraRegen = 0
		verb/action(var/t as text)
			if(t=="punch"){punch();}
		verb/punch()
			set category = "Taijutsu"
			if(!canPunch()){return}
			src.setState("Punch")
			var/obj/Punch = new /obj(get_step(usr,usr.dir))
			src.combatImpact(Punch,get_step(usr,usr.dir))
			if(prob(10))view(src,6) << 'sfxpunch1.wav'
			src.punchDelay()
		/*
		Jutsu are now becoming for all mobs
		verb/boulder()
			set name="Doton Doryudan"
			set category="Ninjutsu"
			if(!canBoulder()){return}
			src.setState("Boulder")
			var/obj/Earth/Boulder/water = new /obj/Earth/Boulder(locate(usr.x,usr.y,usr.z))
			water.setOwner(src)
			walk(water,usr.dir,2,0)
			src.boulderDelay()
		verb/windCutter()
			set name="Futon Kazekiri no Jutsu"
			set category="Ninjutsu"
			if(!canWindCutter()){return}
			src.setState("Wind Cutter")
			var/obj/Wind/Cutter/c = new /obj/Wind/Cutter(get_step(src,src.dir))
			c.dir = usr.dir
			src.combatCut(c,get_step(usr,usr.dir))
			src.windCutterDelay()
		verb/waterball()
			set name="Suiton Suidan no Jutsu"
			set category="Ninjutsu"
			//state
			if(!canWaterball()){return}
			src.setState("Waterball")
			var/obj/Water/Waterball/water = new /obj/Water/Waterball(locate(usr.x,usr.y,usr.z))
			water.setOwner(src)
			walk(water,usr.dir,0,0)
			src.waterballDelay()
		verb/housenka()
			set name="Katon Housenka no Jutsu"
			set category="Ninjutsu"
			//state
			if(!canHousenka()){return}
			src.setState("Housenka")
			var/obj/Fire/Housenka/fireball = new /obj/Fire/Housenka(locate(usr.x,usr.y,usr.z))
			fireball.setOwner(src)
			walk(fireball,usr.dir,0,0)
			src.housenkaDelay()
		verb/ameratsu(var/mob/M in oview(6))
			set name="Ameratsu"
			set category="Ninjutsu"
			usr << "No."
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
			var/inFront = get_step(usr,usr.dir)
			var/inFrontOfThat = get_step(inFront,usr.dir)
			var/ballBottom = get_steps(usr,usr.dir,3)
			var/ballMiddle = get_steps(usr,usr.dir,4)
			var/ballTop =  get_steps(usr,usr.dir,5)
			var/list/fire = list(new path(inFront),
								 new path(inFrontOfThat) // 1, 2 tails
				,new path(get_left(ballBottom,usr.dir)),new path(ballBottom),new path(get_right(ballBottom,usr.dir))
				,new path(get_left(ballMiddle,usr.dir)),new path(ballMiddle),new path(get_right(ballMiddle,usr.dir))
				,new path(get_left(ballTop,usr.dir)),new path(ballTop),new path(get_right(ballTop,usr.dir)));
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
			*/
		//be aware of getLeft() and getRight()
		/*
		verb/kageElectricShock()
		//	if(!canShock()){return}
			src.state = "Shocking"
			var/distance = 6
			var/turf/t = get_step(usr,usr.dir)
			var/turf/bufferTurf
			shockCreation:
				for(var/i = 0, i < distance, i++)
					var/obj/Electricity/Shock/s = new /obj/Electricity/Shock(t)
					var/turf/tCopy = t
					var/turf/bufferTurfCopy
					for(var/j=i,j>0,j--)
						bufferTurfCopy = get_step(tCopy,getLeft(usr.dir))
						var/obj/Electricity/Shock/s2 = new /obj/Electricity/Shock(bufferTurfCopy)
						tCopy = bufferTurfCopy
						s2.dir = usr.dir
					tCopy = t
					for(var/j=i,j>0,j--)
						bufferTurfCopy = get_step(tCopy,getRight(usr.dir))
						var/obj/Electricity/Shock/s2 = new /obj/Electricity/Shock(bufferTurfCopy)
						tCopy = bufferTurfCopy
						s2.dir = usr.dir
					s.dir = usr.dir
					for(var/atom/movable/m in t)
						world << "[m]"
						if(m.conductivity<1)
							break shockCreation
					bufferTurf = t
					t = get_step(bufferTurf,usr.dir)

			src.shockDelay()
			*/
		verb/electricShock()
			if(!canShock()){return}
			src.setState("Shocking")
			var/distance = 3
			var/turf/t = get_step(usr,usr.dir)
			var/turf/bufferTurf
			shockCreation:
				for(var/i = 0, i < distance, i++)
					var/obj/Electricity/Shock/s = new /obj/Electricity/Shock(t)
					s.dir = usr.dir
					for(var/atom/movable/m in t)
						world << "[m]"
						if(m.conductivity<1)
							break shockCreation
					bufferTurf = t
					t = get_step(bufferTurf,usr.dir)

			src.shockDelay()
		//Communication
		verb/say(t as text)
			view(6,usr) << "<font color=blue><b>[usr]:</font> [t]"
		verb/world_say(t as text)
			world << "<font color=blue><b>[usr]:</font> [t]"
		die(var/atom/movable/m)
			for(var/obj/O in src.contents)
				O.dropAll(1)
			spawn() src.sendToDeathLocation()
			src.refresh()
			world << "[src] was killed by [m]"