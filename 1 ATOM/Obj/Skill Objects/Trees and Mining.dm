obj
	Trees
		density = 1
		icon = 'tree.dmi'
		isBattleReady = 1
		isCuttable = 1
		isHeatable = 1
		isImpactable = 1
		impacts = 1
		cuts = 1
		heats = 1
		message = list("chop")
		var
			woodcuttingRequirement = 0
			obj/wood = /obj/Wood/Build/SoftWood
			obj/seed = /obj/Wood/SoftWoodSeed
			maxChops = 4
			xpGain
		layer = MOB_LAYER+2
		New()
			.=..()
			setHp(1000)
			setStrength(0)
			setDefense(300)
			setBlood(1)
			setToughness(100)
			setSharpness(0)
			setHeatThreshold(800)
			setHeat(100)
			setSpecificHeat(6)
		chop()
			for(var/obj/Trees/t in oview(1))
				if(t!=src)
					continue
				yieldWood(usr)

		die(var/atom/movable/m)
			del(src)
		proc/yieldWood(var/mob/M)
			if(!M)M=usr
			if(M:woodcutting<woodcuttingRequirement){M<<"Your woodcutting must be level [woodcuttingRequirement]";return 0}
			if(!M:hasEquippedAxe){usr<<"You need to equip an axe!";return 0}
			if(!M.addContents(new wood)){M << "Your inventory is full";return 0}
			src.cutNum(src.maxBlood/(maxChops*2))
			M:addWoodcuttingXP(xpGain/2)
			if(!M.addContents(new seed)){M << "Your inventory is full";return 0}
			M:addWoodcuttingXP(xpGain/2)
			src.cutNum(src.maxBlood/(maxChops*2))