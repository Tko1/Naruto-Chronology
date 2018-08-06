obj
	Food
		var/healthBoost
		eat()
			usr.replenishHealth(src.healthBoost)
			drop()
		Fish
			icon = 'fish.dmi'
			message = list("eat")
			BasicFish
				healthBoost = 20
