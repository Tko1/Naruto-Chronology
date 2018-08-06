mob
	proc
		ADMIN_CHECK()
			if(src.key=="Tko37")
				src.verbs += typesof(/mob/MainCharacter/DEBUG_VERBS/verb)
mob
	MainCharacter
		DEBUG_VERBS
			TestSubject
				icon = 'player.dmi'
				message = list("rocking","around","the","christmas","tree")
			verb/Reboot()
				world << "<font size=5>WORLD IS REBOOTING IN 10 SECONDS!"
				for(var/time = 10,time>0,time--)
					world << "<font size=5><font color=red>[time]"
					sleep(10)
				world.Reboot()
			verb/RemoveArmor(mob/O as obj|mob|turf|area in world)
				O.chest = 0
				O.Overlays = list()
				O.refreshOverlays()
				O.defense = O.maxDefense
			verb/Kill(mob/O as obj|mob|turf|area in world)
				O.die()
			verb/Delete(mob/O as obj|mob|turf|area in world)
				del(O)
			verb/Edit(mob/O as obj|mob|turf|area in world)
				set category = "Administration"

				var/Choices[0]
				for(var/V in O.vars) Choices+=V
				Choices-="key"
				Choices-="ckey"
				Choices-="contents"
				Choices-="verbs"
				Choices-="overlays"
				Choices-="underlays"
				Choices-="GMLevel"
				Choices-="GMLock"
				Choices-="GMLocked"
				Choices-="GM_ChatMute"
				Choices-="vars"
				Choices-="group"
				Choices-="type"
				Choices-="parent_type"
				Choices-="client"

				var/variable = input("Which var?","Var") in Choices
				var/default
				var/typeof = O.vars[variable]
				var/dir


				if(isnull(typeof))
					usr << "Unable to determine variable type."

				else if(isnum(typeof))
					usr << "Variable appears to be <b>NUM</b>."
					default = "num"
					dir = 1

				else if(istext(typeof))
					usr << "Variable appears to be <b>TEXT</b>."
					default = "text"

				else if(isloc(typeof))
					usr << "Variable appears to be <b>REFERENCE</b>."
					default = "reference"

				else if(isicon(typeof))
					usr << "Variable appears to be <b>ICON</b>."
					typeof = "\icon[typeof]"
					default = "icon"

				else if(istype(typeof,/atom) || istype(typeof,/datum))
					usr << "Variable appears to be <b>TYPE</b>."
					default = "type"

				else if(istype(typeof,/list))
					usr << "Variable appears to be <b>LIST</b>."
					default = "cancel"

				else if(istype(typeof,/client))
					usr << "Variable appears to be <b>CLIENT</b>."
					default = "cancel"

				else
					usr << "Variable appears to be <b>FILE</b>."
					default = "file"

				usr << "Variable contains: [typeof]"
				if(dir)
					switch(typeof)
						if(1)
							dir = "NORTH"
						if(2)
							dir = "SOUTH"
						if(4)
							dir = "EAST"
						if(8)
							dir = "WEST"
						if(5)
							dir = "NORTHEAST"
						if(6)
							dir = "SOUTHEAST"
						if(9)
							dir = "NORTHWEST"
						if(10)
							dir = "SOUTHWEST"
						else
							dir = null
					if(dir)
						usr << "If a direction, direction is: [dir]"

				var/class = input("What kind of variable?","Variable Type",default) in list("text",
					"num","type","reference","icon","file","restore to default","cancel")

				switch(class)
					if("cancel")
						return

					if("restore to default")
						O.vars[variable] = initial(O.vars[variable])

					if("text")
						O.vars[variable] = input("Enter new text:","Text",\
							O.vars[variable]) as text

					if("num")
						O.vars[variable] = input("Enter new number:","Num",\
							O.vars[variable]) as num

					if("type")
						O.vars[variable] = input("Enter type:","Type",O.vars[variable]) \
							in typesof(/obj,/mob,/area,/turf)

					if("reference")
						O.vars[variable] = input("Select reference:","Reference",\
							O.vars[variable]) as mob|obj|turf|area in world

					if("file")
						O.vars[variable] = input("Pick file:","File",O.vars[variable]) \
							as file

					if("icon")
						O.vars[variable] = input("Pick icon:","Icon",O.vars[variable]) \
							as icon
		verb/chooseElement()
			var/list/elements = list("Fire","Water","Electricity","Earth","Wind")
			var/probability = 100
			for(var/i = 0, i<5, i++)
				if(prob(probability))
					var/eleBuffer = pick(elements)
					addChakraElement(pick(eleBuffer))
					elements -= eleBuffer
					probability = 10
					world << "DEBUG: [src] got [eleBuffer]"
					continue
				break
			elementTries++
			world << "DEBUG: Element tries: [elementTries]"
			if(src.trySharingan())
				for(var/t in src.chakraElement)
					if(t=="Fire")
						world << "DEBUG: [src] has blaze release: Ameratsu techniques, Tsukiyomi, Susanoo"
					if(t=="Water")
						world << "DEBUG: [src] has ultimate genjutsu:  Mind Control, Genjutsu Break, Tsukiyomi"
					if(t=="Electricity")
						world << "DEBUG: [src] has space time jutsu: Teleport, Intangable"
					if(t=="Earth")
						world << "DEBUG: [src] has immense creation powers!  Forbidden Summons,  forbidden weapons, and \
						something involving bijuus I'm not sure yet"
					if(t=="Wind")
						world << "DEBUG: [src] has immense yang (life) powers!"
			if(prob(2.5))
				world << "DEBUG: [src] is a senju!"
			skillCheck()
		proc/trySharingan()
			if(prob(2.5))
				world << "<b><font color=red>DEBUG: [src] got Sharingan!"
				return 1