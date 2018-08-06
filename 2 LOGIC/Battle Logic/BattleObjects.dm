
atom/movable
	var
	//fighting variables
		isDead = 0
		//impact variables

		hp = 1
		maxHp = 1
		strength = 1
		maxStrength = 1
		defense = 1
		maxDefense = 1
		//cut
		blood = 1
		maxBlood = 1
		toughness = 1
		maxToughness = 1
		sharpness = 1
		maxSharpness = 1
		//heat variables
		heat = 100 //how hot this is
		maxHeat = 100 //default
		heatThreshold = 300//how much heat something can take before death
		maxHeatThreshold = 300
		ignitionPoint //how hot to _catch fire
		hasIgnited //hasIgnited or not.  Sparks, by default, have this at 1.
		heatDissipation
		specificHeat = 1
		maxSpecificHeat = 1
		energyLevel = 2
		atom/movable/owner.
		//cold
		coldThreshold = -300
		maxColdThreshold = -300
		//shock
		power = 3 //3 shocks each
		maxPower = 3
		conductivity = 1
	//DEFAULT OBJECTS
	Atmosphere
		heat = 100
	DefaultAsh
	DefaultKiller
		name = "Default Killer"
	proc/isDead()
		var/output = 0
		if(isDead)
			output = 1
		if(src.hp<=0)
			output = 1
			src.healthCheck()
		if(src.heat>src.heatThreshold)
			output = 1
			src.heatCheck()
		if(src.heat<src.coldThreshold)
			output = 1
			src.coldCheck()
		return output
	Metal
		var
			meltingPoint
	//Getters, setters
	proc/addMaxStrength(var/n)
		maxStrength += n
		strength += n
	proc/addMaxDefense(var/n)
		maxDefense += n
		defense += n
	proc/addMaxBlood(var/n)
		maxBlood += n
		blood += n
	proc/addMaxToughness(var/n)
		maxToughness += n
		toughness += n
	proc/addMaxSharpness(var/n)
		maxSharpness += n
		sharpness += n
	proc/addMaxHeatThreshold(var/n)
		maxHeatThreshold += n
		heatThreshold += n
	proc/addMaxSpecificHeat(var/n)
		maxSpecificHeat += n
		specificHeat += n
	proc/addMaxColdThreshold(var/n)
		maxColdThreshold -= n
		coldThreshold -= n

//ALL BATTLE
	proc/refresh()
		hp = maxHp
		heat = maxHeat
		strength = maxStrength
		defense = maxDefense
		blood = maxBlood
		isDead = 0
		if(istype(src,/mob/MainCharacter)){src:chakra = src:maxChakra};
		src.updateHealthHUD()
	proc/kill(var/atom/movable/killer)
		if(isDead)
			return 0
		if(!killer)
			killer = new /atom/movable/DefaultKiller
		isDead = 1
		die(killer)
	//ALL
	proc/battle(var/atom/movable/enemy)
		heat(enemy)
		impact(enemy)
		cut(enemy)
	//HEAT
		//Heat vs heat
	proc/heat(var/atom/movable/enemy)
		if(!enemy.isBattleReady){return 0}
		enemy.calculateHeat(src)
	proc/calculateHeat(var/atom/movable/aggressor)
		var/strongHeat = aggressor.heat
		var/weakHeat = src.heat
		var/atom/movable/personToHeat = src
		var/atom/movable/heater = aggressor
		var/sh = src.specificHeat
		var/sh2 = aggressor.specificHeat
		if(src.heat>aggressor.heat)
			personToHeat = aggressor
			strongHeat = src.heat
			weakHeat = aggressor.heat
			sh = aggressor.specificHeat
			sh2 = src.specificHeat
			heater = src
		if(sh==0)
			sh = 1
		var/heatToAdd = (strongHeat-weakHeat)/sh
		personToHeat.addHeat(heatToAdd,heater)
		var/heatToLose = (strongHeat-weakHeat)/sh2
		heater.subHeat(heatToLose,personToHeat) //TODO move?
		//MODIFIERS
	proc/addHeat(var/amount,var/atom/movable/killer)
		src.heat += amount
		if(killer)
			src.heatCheck(killer)
			src.coldCheck(killer)
		else
			src.heatCheck()
			src.coldCheck()
			//src.igniteCheck()
	proc/subHeat(var/amount,var/atom/movable/killer)
		src.heat -= amount
		if(killer)
			src.heatCheck(killer)
			src.coldCheck(killer)
		else
			src.heatCheck()
			src.coldCheck()
	//Shock
	proc/shock(var/atom/movable/enemy)
		if(!enemy.isBattleReady){return 0}
		enemy.calculateShock(src)
	proc/calculateShock(var/atom/movable/aggressor)

		src.addHeat(aggressor.heat*src.conductivity,aggressor)
		aggressor.power-=1
		aggressor.shockCheck()
	proc/shockCheck()
		if(src.power<=0)
			src.kill(src)
		//DEATH CHECKS
	proc/deathCheck()
		heatCheck()
		healthCheck()
		bloodCheck()
		coldCheck()
	proc/igniteCheck()
		if(src.heat>=src.ignitionPoint)
			if(src.energyLevel!=1)
				src.energyLevel -= 1
				src.transformEnergy()
	proc/heatCheck(var/atom/movable/killer)
		if(!killer)
			killer = new /atom/movable/DefaultKiller
		if(src.heat>src.heatThreshold)
			src.kill()
	proc/transformEnergy()
		if(src.energyLevel==1)
			src.makeAsh()
	proc/makeAsh()
		//if(src.owner)
			//if(src.owner.isOrganic)
				//TODO ignite organic objects
	//IMPACT
	proc/impact(var/atom/movable/Enemy)
		if(ismob(src,Enemy)){if(!src:client&&!Enemy:client&&src:friendlyFire==0)return 0}
		if(!Enemy.isBattleReady){return 0}
		Enemy.calculateDamage(src)
	proc/calculateDamage(var/atom/movable/Aggressor)
		var/damage = Aggressor.strength - src.defense
		if(damage<0)
			damage = 0
		src.subHealth(damage,Aggressor)
	proc/subHealth(var/amount,var/atom/movable/killer)
		if(amount>=0)
			src.hp -= amount
			showDamage(src,amount)
			updateHealthHUD()
			if(!killer)
				killer = new /atom/movable/DefaultKiller
			healthCheck(killer)
		else
			world << "Error: Negative health deduction attempted with [src]"
	proc/updateHealthHUD()
		if(istype(src,/mob/MainCharacter))
			if(src:client)
				for(var/obj/Screen/Other/Health/O in src:client.screen)
					O.matchHealth(src.hp,src.maxHp)
	proc/addHealth(var/amount)
		if(amount>=0)
			src.hp += amount
		else
			world << "Error: Negative health added with [src]"
	proc/replenishHealth(var/amount)
		src.hp += amount
		if(hp > src.maxHp)
			src.hp = maxHp

	proc/healthCheck(var/atom/movable/killer)
		if(!killer)
			killer = new /atom/movable/DefaultKiller
		if(src.hp<=0)
			world << "Where's my hp"
			src.kill(killer)
	//CUT
	proc/cut(var/atom/movable/Enemy)
		if(!Enemy.isBattleReady){return 0}
		Enemy.calculateCut(src)
	proc/calculateCut(var/atom/movable/Aggressor)
		var/damage = Aggressor.sharpness - src.toughness
		if(damage<0)
			damage = 0
		src.subBlood(damage)
	proc/subBlood(var/amount,var/atom/movable/killer)
		if(amount>=0)
			src.blood -= amount
		else
			world << "Error: Negative blood deduction attempted with [src]"
			return
		if(!killer)
			killer = new /atom/movable/DefaultKiller
		bloodCheck(killer)
	proc/addBlood(var/amount)
		if(amount>=0)
			src.blood += amount
		else
			world << "Error: Negative blood added with [src]"
	proc/bloodCheck(var/atom/movable/killer)
		if(!killer)
			killer = new /atom/movable/DefaultKiller
		if(src.blood<=0)
			world << "Where my blood"
			src.kill()
	//COLD
	proc/cool(var/atom/movable/enemy)
		enemy.calculateCool(src)
	proc/calculateCool(var/atom/movable/aggressor)
		var/strongHeat = aggressor.heat
		var/weakHeat = src.heat
		var/atom/movable/personToCool = aggressor
		var/atom/movable/cooler = src
		var/sh = aggressor.specificHeat
		if(src.heat>aggressor.heat)
			personToCool = src
			strongHeat = src.heat
			weakHeat = aggressor.heat
			sh = src.specificHeat
			cooler = aggressor
		if(sh<=0)
			sh = 1
		var/heatToSub = (strongHeat-weakHeat)/sh
		personToCool.subHeat(heatToSub,cooler)
		//MODIFIERS
	proc/coldCheck(var/atom/movable/killer)
		if(!killer)
			killer = new /atom/movable/DefaultKiller
		if(src.heat<src.coldThreshold)
			world << "Too cold"
			src.kill()
