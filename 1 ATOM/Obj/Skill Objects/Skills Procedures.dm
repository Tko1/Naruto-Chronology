var/building_rate = 1.4 //buildingXP rate
var/mining_rate = 1.4//miningXP rate
var/fishing_rate = 1.4//fishingXP rate
var/woodcutting_rate = 1.4
var/generic_rate = 1.4 //For generics, copy and paste then cntrl H to replace all with your new stat
var/level_rate = 1.4
mob
	var
		generic
		genericXP
		genericMaxXP //not real variables
	MainCharacter
		proc
			buildingLevelCheck()
				if(buildingXP > buildingMaxXP)
					buildingLevelUp()
			buildingLevelUp()
				src << "<font color=black>Congratulations! Building Level up!"
				building++
				buildingMaxXP *= building_rate
			addBuildingXP(var/n)
				buildingXP += n
				buildingLevelCheck()
			miningLevelCheck()
				if(miningXP > miningMaxXP)
					miningLevelUp()
			miningLevelUp()
				src << "<font color=grey>Congratulations! Mining Level up!"
				mining++
				miningMaxXP *= mining_rate
			addMiningXP(var/n)
				miningXP += n
				miningLevelCheck()
			fishingLevelCheck()
				if(fishingXP > fishingMaxXP)
					fishingLevelUp()
			fishingLevelUp()
				src << "<font color=cyan>Congratulations! Fishing Level up!"
				fishing++
				fishingMaxXP *= fishing_rate
			addFishingXP(var/n)
				fishingXP += n
				fishingLevelCheck()
			woodcuttingLevelCheck()
				if(woodcuttingXP > woodcuttingMaxXP)
					woodcuttingLevelUp()
			woodcuttingLevelUp()
				src << "<font color=green>Congratulations! Woodcutting Level up!"
				woodcutting++
				woodcuttingMaxXP *= woodcutting_rate
			addWoodcuttingXP(var/n)
				woodcuttingXP += n
				woodcuttingLevelCheck()
			levelCheck()
				if(levelXP > levelMaxXP)
					levelUp()
			levelUp()
				src << "<font color=red>Congratulations! Level up!"
				src << 'levelup.ogg'
				level++
				if(level>1)levelMaxXP += 150*(level*level_rate)
				addSkillpoints(10)
				var/obj/Screen/LevelUp/Overlay = new /obj/Screen/LevelUp()
				addOverlays(Overlay)
				spawn(20) removeOverlay(Overlay)
				START
				var/perkToCheck = input(src,"What talent would you like to look at") in getPerk(level)
				if(perkToCheck)switch(input(src,perkDescription(perkToCheck) + ".\n\nWould you like this talent?") in list("Yes","No"))
					if("Yes")
						addPerk(perkToCheck)
					if("No")
						goto START
				//addStrength(rand(1,3))
				//addDefense(rand(1,3))
				skillCheck()
			skillCheck()
				/*
				if(hasElement("Water"))
					src.hasWaterball = 1
				if(hasElement("Fire"))
					src.hasHousenka = 1
					src.hasGoukakyuu = 1
				if(hasElement("Earth"))
					learnBoulder()
				if(hasElement("Wind"))
					src.hasWindCutter = 1
				if(hasElement("Electricity"))
					src.hasShock = 1
				*/
			learnBoulder()
				src.hasBoulder = 1
			learnWindCutter()
				src.hasWindCutter = 1
			learnShock()
				src.hasShock = 1
			learnWaterball()
				src.hasWaterball = 1
			learnHousenka()
				src.hasHousenka = 1
			learnGoukakyuu()
				src.hasGoukakyuu = 1
			addPhysicalEnergy(var/n)
				if((physicalEnergy+n)>10)return 0
				physicalEnergy += n
				addStrength(5*n)
				addDefense(5*n)
				src.weapons += 5*n
				src.addHp(10*n)
				src.maxChakra += 10*n
				src.chakraRegenRate += n
				return 1
			addSpiritualEnergy(var/n)
				if((spiritualEnergy+n)>10)return 0
				spiritualEnergy += n
				addNinjutsu(n)
				src.maxChakra += 10*n
				src.chakraRegenTime += n
				return 1
			addCraftmanship(var/n)
				if(craftmanship+n>10)return 0
				craftmanship += n
				building += n*2
				mining += n*2
				addHp(n*2)
				fishing += n*2
				woodcutting += n*2
				cooking += n*2
				return 1
			addSpeed(var/n)
				if(speed+n>10)return 0
				speed += n
				moveSpeed += n
				jutsuSpeed += n
				return 1
			addSkillpoints(var/number)
				skillpoints += number
			addCoreSkillpoints(var/n)
				coreSkillpoints += n
			addLevelXP(var/n)
				levelXP += n*levelXPMultiplier
				levelCheck()
			addNinjutsu(var/n)
				if(ninjutsu+n>100)return 0
				ninjutsu += n
				maxNinjutsu += n
				return 1
			addBloodlust(var/n)
				bloodlust += n
			addLevelXPMultiplier(var/n)
				levelXPMultiplier += n
			addStrength(var/n)
				addMaxStrength(n)
			setCrafting(var/n)
				if(n==1)
					src.canCraft = 1
				if(n==0)
					src.canCraft = 0
			addHeatThreshold(var/n)
				addMaxHeatThreshold(n)
			transAddStrength(var/n)
				strength += n
			transSubStrength(var/n)
				strength -= n
			transAddSpecificHeat(var/n)
				specificHeat += n
			transSubSpecificHeat(var/n)
				specificHeat -= n
			transAddToughness(var/n)
				toughness += n
			transSubToughness(var/n)
				toughness -= n
			transAddSharpness(var/n)
				sharpness += n
			transSubSharpness(var/n)
				sharpness -= n
			addDefense(var/n)
				addMaxDefense(n)
			transAddDefense(var/n)
				defense += n
			transSubDefense(var/n)
				defense -= n

			addWoodcutting(var/n)
				if(woodcutting+n>100)return 0
				woodcutting += n
				return 1
			addMining(var/n)
				if(mining+n>100)return 0
				mining += n
				return 1
			addBuilding(var/n)
				if(building+n>100)return 0
				building += n
				return 1
			addHandToHand(var/n)
				if(handToHand+n>100)return 0
				handToHand += n
				addStrength(n*strengthMultiplier)
				return 1
			addWeapons(var/n)
				if(weapons+n>100)return 0
				weapons += n
				return 1
			addCooking(var/n)
				if(cooking+n>100)return 0
				cooking += n
				return 1
			addFishing(var/n)
				if(fishing+n>100)return 0
				fishing += n
				return 1
			genericLevelCheck()
				if(genericXP > genericMaxXP)
					genericLevelUp()
			genericLevelUp()
				generic++
				genericMaxXP *= generic_rate
			addGenericXP(var/n)
				genericXP += n
				genericLevelCheck()
			setHunter(var/boolean)
				switch(boolean)
					if(1)src.isHunter = 1
					if(0)src.isHunter = 0
					else
						world << "Error: setHunter() is supposed to be a boolean, 1 or 0, not [boolean]"