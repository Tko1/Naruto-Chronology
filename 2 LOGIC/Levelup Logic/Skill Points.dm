mob/MainCharacter
	var/skillpoints
	var/coreSkillpoints
	verb
		Add_Skillpoints()
			var/which = input(src,"What would you like to add your [skillpoints] skillpoints to?") in list("Woodcutting","Fishing","Mining","Building","Ninjutsu","Hand to Hand","Weapons","Cooking")
			var/amount  = input(src,"How many would you like to add?") as num
			if(amount>skillpoints||amount<0)
				src << "Sorry, you don't have that many"
				return
			switch(which)
				if("Woodcutting")if(!src.addWoodcutting(amount)){src<<"Sorry, you can't surpass 100 woodcutting";return 0}
				if("Mining")if(!src.addMining(amount)){src<<"Sorry, you can't surpass 100 mining";return 0}
				if("Building")if(!src.addBuilding(amount)){src<<"Sorry, you can't surpass 100 building";return 0}
				if("Ninjutsu")if(!src.addNinjutsu(amount)){src<<"Sorry, you can't surpass 100 Ninjutsu";return 0}
				if("Hand to Hand")if(!src.addHandToHand(amount)){src<<"Sorry, you can't surpass 100 Hand to Hand";return 0}
				if("Weapons")if(!src.addWeapons(amount)){src<<"Sorry, you can't surpass 100 weapons";return 0}
				if("Cooking")if(!src.addCooking(amount)){src<<"Sorry, you can't surpass 100 cooking";return 0}
				if("Fishing")if(!src.addFishing(amount)){src<<"Sorry, you can't surpass 100 fishing";return 0}
			src.skillpoints -= amount
		Add_CoreSkillPoints()
			var/which = input(src,"What would you like to add your [coreSkillpoints] core skillpoints to?") in list("Physical Energy","Spiritual Energy","Craftmanship","Speed")
			var/amount  = input(src,"How many would you like to add?") as num
			if(amount>coreSkillpoints||amount<0)
				src << "Sorry, you don't have that many"
				return
			switch(which)
				if("Physical Energy")
					if(!src.addPhysicalEnergy(amount))
						src << "Sorry,you can't surpass 10 Physical Energy"
						return
				if("Spiritual Energy")
					if(!src.addSpiritualEnergy(amount))
						src << "Sorry,you can't surpass 10 Physical Energy"
						return
				if("Craftmanship")
					if(!src.addCraftmanship(amount))
						src << "Sorry,you can't surpass 10 Craftmanship"
						return
				if("Speed")
					if(!src.addSpeed(amount))
						src << "Sorry,you can't surpass 10 speed"
						return
			src.coreSkillpoints -= amount