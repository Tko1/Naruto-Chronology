obj
	Screen/Other/Health
		icon = 'hitpoints.dmi'
		icon_state = "100"
		screen_loc = "13,13"
		layer = MOB_LAYER+3
		proc/matchHealth(var/health,var/maxHealth)
			var/percentage = health/maxHealth*100
			if(percentage>75)
				icon_state = "100"
			if(percentage<=75&&percentage>50)
				icon_state = "75"
			if(percentage<=50&&percentage>25)
				icon_state = "50"
			if(percentage<=25&&percentage>5)
				icon_state = "25"
			if(percentage<=5)
				icon_state = "5"