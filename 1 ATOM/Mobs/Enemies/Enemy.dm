var/area_ID
mob/var/list/campsDiscovered = list()
area
	Death
		opacity = 1
		Enter()
			if(!istype(usr,/mob/MainCharacter)&&!istype(usr,/mob/Enemies/Gnome))
				usr.die()
			return 0
	Discovery
		var/discoveryMessage
		var/xpGain
		Entered()
			if(istype(usr,/mob/MainCharacter))
				if(!inList(src.name,usr.campsDiscovered))
					usr << src.discoveryMessage + " You gain [xpGain] experience points!"
					usr.campsDiscovered += src.name
					usr:addLevelXP(xpGain)
			..()
		UchihaCamp
			discoveryMessage = "<font color=red>You've discovered the sinister Uchiha camp!"
			xpGain = 300
		Sand
			discoveryMessage = "<font color=red>You've discovered the former sand country!"
			xpGain = 500
		Mist
			discoveryMessage = "<font color=red>You've discovered the former mist island!"
			xpGain = 1000
		MiniIsland
			discoveryMessage = "<font color=red>You've discoverd abandoned mini-island!"
			xpGain = 400
		Peninsula
			discoveryMessage = "<font color=red>You've discovered the Peninsula! I need a better title for this"
			xpGain = 800
	Enemies
		var/targets
		var/attackerType = /mob/Enemies
		var/targetType = /mob/MainCharacter
		var/tmp/list/myAttackers = list()
		Entered(var/mob/M)
			if(!M)M=usr
			if(istype(M,/mob/Enemies))
				M:isActivated = 1
				return ..()
			if(istype(M,targetType))
				targets++
				spawn() targetCheck()
			world << "ENTERED: Targets [targets]"
			return ..()
		Exited(mob/M)
			if(istype(M,attackerType))return 0
			if(istype(M,targetType))
				targets--
				spawn () targetCheck()
			world << "EXITED: Targets [targets]"

			return ..()
		Exit()
			if(istype(usr,attackerType))return 0
			return ..()
		New()
			.=..()
			spawn(10)
				for(var/mob/M in src)
					if(istype(M,targetType))
						targets++
		proc
			targetCheck()
				if(src.targets==1)
					world << "Target check is executing.."
					for(var/mob/M in src)
						if(istype(M,attackerType))
							M:isActivated = 1
							spawn() M:search()
				if(src.targets<=0)
					src.targets = 0
					for(var/mob/M in src)
						if(istype(M,attackerType))
							M:isActivated = 0
mob
	Enemies
		icon = 'player.dmi'

		friendlyFire = 0
		isBattleReady = 1
		isCuttable = 1
		isHeatable = 1
		isImpactable = 1
		impacts = 1
		cuts = 1
		heats = 1
		moveSpeed = 1


		hasGoukakyuu = 1
		hasHousenka = 1
		hasBoulder = 1
		hasWaterball = 1
		hasWindCutter = 1

		var/DEBUG_NPC = 0
		New()
			.=..()
			spawn() initialize()
		proc/dayAndNight()
			isActivated = 0
			src.loc = null

			sleep(rand(3000*4,3000*6)/gameSpeed)

			spawnFromSpawnLocation()
			for(var/atom/movable/O in src.loc)
				if(O.preventsSpawning)
					return dayAndNight()
			isActivated = 1
			spawn() search()
			sleep(rand(3000*4,3000*6)/gameSpeed)
		initialize()

			setHp(400)
			setStrength(100)
			setDefense(60)
			setBlood(100)
			setToughness(10)
			setSharpness(0)
			setHeatThreshold(300)
			setHeat(100)
			setSpecificHeat(2)
			setSpawnLocation()
			dayAndNight()
		var
			hostile = 1
			retaliates = 1
			retaliating = 0
			hasRoamedThisManyTimes = 0
			isActivated = 1 //has another mob entered my territory? if not, dont activate me to save resource
			list/attacks = list("Punch")
			xpGain = 25
			list/loot
			//speed = 1
			attackSpeed = 1
			range = 6
			mob/MainCharacter/target
			targetType = /mob/MainCharacter
		/*
			Enemy is always Searching
			While searching, if there is no target,  and one is not hostile, roam.
			If there is hostility,  getTarget() will be checked.
				If it returns true (already has target), follow will be called on target.
				If it is false, it will automatically (inside its own proc) look for a MainCharacter to attack, and return true
				so that follow is still called.
			If  one is not found,  getTarget() will return false, and if "retaliating = 0", it will forget its target
			(impossible situation atm it looks like).
			It will roam, then it will search all over again.
		*/
		proc/roam()
			if(rand(1,4)>1)
				step_rand(src)
		proc/getTarget()
			if(target)
				//world << "This is my target [target]"
				return 1
			var/hasTargeted
			for(var/atom/movable/M in oview(range,src))
				if(!istype(M,targetType))continue
				if(prob(M.bloodlust*90))continue
				//world << "This is my new target: [M], this is his type [M.type], and this is target type [targetType]"
				target = M
				hasTargeted = 1
				return 1
			if(!hasTargeted)
				return 0
		proc/attack(var/range,var/target)
			step_towards(src,target)
			switch(pick(attacks))
				if("Goukakyuu")if(range<3)src.goukakyuu()
				if("Housenka")src.housenka()
				if("Boulder")src.boulder()
				if("Waterball")src.waterball()
		proc/follow()
			for(target in oview(1,src))
				src.attack(1,target)
				sleep(10/attackSpeed)
				goto END
			for(target in oview(range,src))
				var/distance = get_dist(src.loc,target.loc)
				attack(distance,target)
				goto END
			//roam if nothing is found
			roam()
			END
			//return to original
		proc/search() //Main proc
			while(src.isActivated)
				if(!target&&!hostile)
					roam()
					sleep(10/moveSpeed)
					continue
				if(getTarget())
					follow()
				else
					if(!retaliating)target = null
					roam()
				sleep(10/moveSpeed)
		die(var/atom/movable/m)
			if(istype(m,/mob/MainCharacter))
				var/mob/MainCharacter/M = m
				M.addLevelXP(src.xpGain)
			else
				if(m.owner&&istype(m.owner,/mob/MainCharacter))
					m.owner:addLevelXP(src.xpGain)
			dropGoodies()
			src.target = null
			src.loc = null
			spawn(200)
				src.refresh()
				spawn() src.spawnFromSpawnLocation()
		proc/dropGoodies()
			if(!src.loot) return 0;
			for(var/a in src.loot)  // For each loot item...
				if(prob(loot[a]))  // If the player gets lucky...
					usr << "[src] dropped a [a]"
					new a(src.loc)  // Make the item and drop it at the mob's locationmob
		Gnome
			icon = 'gnome.dmi'
			hostile = 0
			moveSpeed = 10
			isBattleReady = 0
			message = list("_catch")
			New()
				.=..()
				spawn() initialize()
			initialize()
				moveSpeed = rand(1,5)
			_catch(mob/_catcher)
				for(var/mob/M in oview(1,src))
					if(M!=_catcher)continue
					spawn() alert(_catcher,"Was this all a dream?")
					_catcher.spawnFromSpawnLocation()
			die()
				del(src)


		Pig
			icon = 'pig.dmi'
			hostile = 0
		ClanlessMercenary
			icon = 'baseNinja.dmi'
			hostile = 1
			moveSpeed = 2
			attackSpeed = 1
			range = 6
		Uchiha
			icon = 'uchiha.dmi'
			ninjutsu = 30
			maxNinjutsu = 30
			initialize()
				..()
				setHp(1000)
				ninjutsu = 30
				setDefense(150)
				maxNinjutsu = 30

				setHeatThreshold(600)
				setHeat(100)
				setSpecificHeat(4)
			attacks = list("Punch","Housenka")
			BasicMercenary
				icon_state = "basic"
				hostile = 1
				moveSpeed = 2
				attackSpeed = 3
				range = 6
				xpGain = 30
				loot = list(/obj/Battle/Equipment/Underwear/FlameJumpsuit = 10)
			ExperiencedMercenary
				icon_state = "basic"
				hostile = 1
				moveSpeed = 2
				attackSpeed = 3
				range = 6
				xpGain = 60
				attacks = list("Punch","Housenka","Goukakyuu")
				loot = list(/obj/Battle/Equipment/Underwear/FlameJumpsuit = 30)
				initialize()
					..()
					setHp(1200)
					ninjutsu = 50
					maxNinjutsu = 50

					setHeatThreshold(600)
					setHeat(100)
					setSpecificHeat(4)
			Madara
				icon_state = "madara"
				hostile = 1
				moveSpeed = 5
				xpGain = 100
				specific
				attacks = list("Punch","Housenka","Goukakyuu","Boulder")
				loot = list(/obj/Battle/Equipment/Chest/IronChestPlate = 10, // 65% chance
			/obj/Battle/Equipment/Underwear/FlameJumpsuit = 30) // 30% chance)
				initialize()
					..()
					setHp(3600)
					ninjutsu = 100
					maxNinjutsu = 100
					setDefense(1000)
					setHeatThreshold(1000)
					setHeat(100)
					setSpecificHeat(4)
		Haku
			Boss
				icon_state = "madara"
				hostile = 1
				moveSpeed = 5
				xpGain = 100
				specific
				attacks = list("Punch","Housenka","Goukakyuu","Boulder")
				loot = list(/obj/Battle/Equipment/Chest/IronChestPlate = 10, // 65% chance
			/obj/Battle/Equipment/Underwear/FlameJumpsuit = 30) // 30% chance)
				initialize()
					..()
					setHp(3600)
					ninjutsu = 100
					maxNinjutsu = 100
					setDefense(1000)
					setHeatThreshold(1000)
					setHeat(100)
					setSpecificHeat(4)
		Ameratsu
			icon = 'ameratsu.dmi'
			density = 0
			initialize()
				..()
				setHeat(2000)
			//	spawn()
			//		beginBurning()
			/*
			proc/beginBurning()
				while(src)
					for(var/atom/movable/m in view(0,src))
						src.heat(m)
					sleep(5)
			*/
			range = 3
			moveSpeed = 3
			hostile = 1
			targetType = /atom/movable
		DoesntMove
			icon = 'baseNinja.dmi'
			hostile = 0
			moveSpeed = 0.001



