mob
	MainCharacter
		var/list/perks = list()
		proc/getPerk(var/level)
			var/list/perks = list()
			if(level>1)perks += list("Orochi Obsession","Lee persistence","Bloody Mist Graduate","Little Konohamaru","Hunter")
			if(level>3)perks += list("Housenka","Boulder","Skilled Pointer","Carnivore Level 1")
			if(level>5)perks += list("Flame Resistance","Craftsman","Lucky Shot")
			if(level>7)perks += list("")
			if(level>9)perks += list("Katon Goukakyuu")
			if(level>11)perks += list("")
			if(level>13)perks += list("")
			if(level>15)perks += list("Flame Natural")//TODO
			if(level>17)perks += list("")
			if(level>19)perks += list("Natural Water")//Todo
			//if(level>5)perks +=
			perks = removeListFromList(src.perks,perks)
			return perks
		proc/perkDescription(var/text)
			switch(text)
				//Perks Tier 1
				if("Orochi Obsession")
					return "You've always been obsessed with jutsu. The most powerful jutsu,  the weakest jutsu, the oldest jutsu\
					, you want to learn them all.  With each level of this perk (maximum 3),\
					your ninjutsu and genjutsu are boosted by 5. "
				if("Lee persistence")
					return "Like Rock Lee, you accept the hand you were dealt and try to train as hard as you can with\
					the skills you have in order to hopefully compensate.  In order to hopefully affect other skills.\
					This perk allows you to add one point to one of your core skills."
				if("Bloody Mist Graduate")
					return "You're known to have a certain blood lust.  You don't train to get stronger, people suspect\
					you just love to kill.  NPCs are quite less likely to attack you, and good NPCs are less likely to\
					help you."
				if("Little Konohamaru")
					return "Like Konohamaru, you may not be strong now.  Or maybe you are.  Reguardless, you'll be a lot\
					stronger soon, because you learn a little faster than the others.  A 10% experience boost in your\
					endeavors."
				if("Hunter")
					return "You gain a 10% damage boost to any ninja that does not associate with a village"
				//Perks Tier 2
				if("Housenka")
					return "Learn to shoot little balls of fire yo"
				if("Boulder")
					return "Learn Boulder. Betch"
				if("Skilled Pointer")
					return "This terrible pun of an ability gives you more skillpoints per level"
				if("Carnivore Level 1")
					return "50% damage boost when fighting with animals"
				//Perks Tier 3
				if("Flame Resistance")
					return "By getting accustom to expelling chakra in just the right amounts when exposed to fire, your\
					 resistance to flame improves dramatically."
				if("Craftsman")
					return "The ability to manipulate molten metals with only your hands"
				if("Lucky shot")
					return "Occasionally your projectile attacks will effortless hit running targets"
				if("Katon Goukakyuu")
					return "Sometimes we sneeze. Sometimes we spit. Sometimes we swallow. What. Sometimes we spit fire.\
					This perk will allow you to spit a large ball of powerful fire to knock out large areas of enemies\
					or objects."

		proc/addPerk(var/text)
			src.perks += text
			switch(text)
				//Perks Tier 1
				if("Orochi Obsession")
					src.addNinjutsu(5)
				if("Lee persistence")
					src.addCoreSkillpoints(1)
				if("Bloody Mist Graduate")
					src.addBloodlust(1)
				if("Little Konohamaru")
					src.addLevelXPMultiplier(0.10)
				if("Hunter")
					src.setHunter(1)
				//Perks Tier 2
				if("Housenka")
					src.learnHousenka()
				if("Boulder")
					src.learnBoulder()
				if("Flame Resistance")
					src.addHeatThreshold(300)
				if("Craftsman")
					src.setCrafting(1)
				//Perks tier 3
				if("Katon Goukakyuu")
					src.learnGoukakyuu()
