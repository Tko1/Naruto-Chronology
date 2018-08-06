mob
	proc
		canMove()
			if(!src.cantMove&&!src.isMoving)
				return 1
			return 0
		moveDelay()
			isMoving = 1
			sleep(15/src.moveSpeed)
			isMoving = 0
		canBoatAndGun()
			if(src.state=="Standing"||src.state=="Boating")
				return 1
			return 0
		canRunAndGun()
			if(src.state=="Standing"||src.state=="Moving")
				return 1
			return 0
		canProjectile()
			if(src.isChakraEmpty()) return 0
			if(canRunAndGun())
				return 1
			return 0
		//Combat Tech

		canPunch()
			if(src.state=="Standing")
				return 1
			return 0
		//Fire Tech
		canHousenka()
			if(!hasHousenka){return 0;}
			if(canProjectile())
				return 1
			return 0
		canGoukakyuu()
			if(!hasGoukakyuu || isDiagonal(src.dir) ){return 0;}
			if(canProjectile())
				return 1
			return 0
		//Water tech
		canWaterball()
			if(!hasWaterball){return 0;}
			if(canProjectile())
				return 1
			return 0
		//Earth tech
		canBoulder()
			if(!hasBoulder){return 0;}
			if(canProjectile())
				return 1
			return 0
		//Wind tech
		canWindCutter()
			if(!hasWindCutter){return 0;}
			if(canProjectile())
				return 1
			return 0
		canShock()
			if(!hasShock){return 0;}
			if(canProjectile())
				return 1
			return 0
		isOccupied()
			var/turf/t = src.loc
			if(t.isOccupied())
				return 1
			else
				return 0
		//Skills
		canBuild()
			if(src.loc:isOccupied()){world << "Test 3 failed";return 0}
			if(src.state=="Standing")
				return 1
			return 0
		canPlant()
			if(src.state=="Standing")
				return 1
			return 0
		//Delays
		genericDelay(var/a)
			if(!a){a=15}
			sleep(a/src.jutsuSpeed)
			src.setState("Standing")
		projectileDelay()
			src.subChakra(20)
			sleep(75/src.jutsuSpeed)
			src.setState("Standing")

		//Fire delays
		housenkaDelay()
			src.subChakra(10) //deducts 10 and only 10 since uses generic delay
			genericDelay(2)
		goukakyuuDelay()
			src.subChakra(20)//additional 20 for 40
			projectileDelay()
		// Water delays
		waterballDelay()
			projectileDelay()
		// Earth delays
		boulderDelay()
			src.subChakra(10) //all projectile delays sub 20,  so this is an ADDITIONAL 10 for a combined of 30
			projectileDelay()

		// Wind delays
		windCutterDelay()
			projectileDelay()
		shockDelay()
			genericDelay(5)
		punchDelay()
			genericDelay(50)
		// Lightning delays