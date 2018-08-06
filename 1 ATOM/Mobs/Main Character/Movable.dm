atom
	movable
		state = "Standing"
		var
			//identification, to avoid references, for saving purposes
			id
			doesNotExistInTheRealWorld // things like damagenums; need to bypass all of this
			//state
			atom/movable/mouseOver
			preventsSpawning = 0
			//
			constant //general multiplier
			isOrganic = 0 //is this an object that can die?
			//what kind of damage can be dished and recieved?
			friendlyFire = 1 //is 0, and I am a NPC, I will not hurt other NPCs
			isBattleReady = 0
			isHeatable = 0
			isImpactable = 0
			isCuttable = 0
			heats = 0
			impacts = 0
			cuts = 0
			deletesOnImpact = 0
			explodes = 0
			isMob = 0

			weight = 1
//			BattleObjects/body = new /BattleObjects()
			//Combat vars
			bloodlust = 0
			reflexes
			isAttacking = 0
			combatOffense = 0
			combatDefense  = 0
			//GUI
			list/message //message[1] is row 1,  [2] is row 2...etc

			list/defaultMessage//defaultMessage[1] is the defaultRow1
		proc/die(var/atom/movable/m)
		proc/setOwner(var/owna)
			src.owner = owna
		proc/initialize()
		Del()
			if(src.doesNotExistInTheRealWorld()) return ..()
			var/foundObject = 0
			for(var/obj/O in src.loc)
				if(O!=src)
					foundObject = 1
			if(!foundObject)
				var/turf/t = src.loc
				if(istype(t,/turf))
					t.setOccupied(0)
			.=..()
		/*
		New()
			.=..()
			if(ismob(src))
				MOB_ID++
				src.id = MOB_ID
			else
				OBJ_ID++
				src.id = OBJ_ID
		*/
		Cross(atom/movable/O)
			.=..()
			if(src.doesNotExistInTheRealWorld)return ..()
			if(!src.isBattleReady) //If I cant be battled with
				//If you die on impact, and I'm dense..
				if(O.deletesOnImpact&&src.density==1)
					O.die() //delete you
				return ..()

			if(O.explodes)
				new /obj/VisualEffects/Explosion(src.loc)
			if(src.isBattleReady&&O.isBattleReady) //if this is two battle objects striking
				if(src.isHeatable&&O.heats)
					O.heat(src)
				if(src.isImpactable&&O.impacts)
					O.impact(src)
				if(src.isCuttable&&O.cuts)
					O.cut(src)
			if(O.deletesOnImpact)
				O.die()
		MouseEntered(location,control,params)
			..()
			//If I am inside somethng
			if(src==usr)
				setMessage(1,"attack")//row 1 becomes attack
				setMessage(2,"suicide")
				//if there are multiple messages, we need to know which object we are switching
			usr.mouseOver = src
			//This loop will say "does the object you have your mouse over, does it have a message? Lets loop through the messages
			//and display them
			if(src.message)
				usr.updateScreenFromListOfText(usr,src.message)//takes list("This","And that would be row 2") and display them

			//TODO ONE
		MouseExited(location,control,params)
			..()
			if(src==usr)//what is this for
				setMessage(1,"attack")
				setMessage(2,null)
			if(usr.mouseOver)
				usr.mouseOver=null
			if(src.message)
				usr.clearWords()
		Click(location,control,params)
			if(src.message)
				var/mob/MainCharacter/M = usr
				M.action(src.message)
		proc/addMessage(var/msg)
			src.message += null
			src.message[length(src.message)] = msg
		proc/setMessage(var/row,var/msg)
			if(!src.message)src.message=list()
			if(row>length(message))
				var/fillInDifference = row - length(message)
				while(fillInDifference>0)
					message +=null;fillInDifference--
			message[row] = msg
		proc/updateScreenFromListOfText(var/mob/mobWithScreen,var/list/text)
			mobWithScreen.clearWords()
			var/row = 1
			for(var/ii = 1,ii<=length(text),ii++)
				if(text[ii])
					mobWithScreen.addWord(row,text[ii])
					row++
		verb/switchClicks()
			if(!mouseOver)
				return 0
			if(length(mouseOver.message)<1)return 0
			var/firstBuffer = mouseOver.message[1]
			for(var/ii=1,ii<=length(mouseOver.message),ii++)
				if(mouseOver.message[ii]==null)continue
				if(ii==length(mouseOver.message))
					mouseOver.message[ii] = firstBuffer
					continue
				var/jj = ii+1
				while(mouseOver.message[jj]==null)
					jj++
				mouseOver.message[ii] = mouseOver.message[jj]
			src.updateScreenFromListOfText(src,mouseOver.message)
		proc/doesNotExistInTheRealWorld()
			if(src.doesNotExistInTheRealWorld)return 1
			return 0
		proc/cutNum(a as num)
			src.blood -= a
			src.bloodCheck()
		//setters for body
		proc/setHp(var/N as num)
			if(!N){N = 1}
			hp = N
			maxHp = N
		proc/addHp(var/N as num)
			if(!N){N = 0}
			hp += N
			maxHp += N
		proc/setStrength(var/N as num)
			if(!N){N=1}
			strength = N
			maxStrength = N
		proc/setDefense(var/N as num)
			if(!N){N=1}
			defense = N
			maxDefense = N
		proc/setBlood(var/N as num)
			if(!N){N=1}
			blood = N
			maxBlood = N
		proc/setToughness(var/N as num)
			if(!N){N=1}
			toughness = N
			maxToughness =N
		proc/setSharpness(var/N as num)
			if(!N){N=1}
			sharpness = N
			maxSharpness =N
		proc/setHeatThreshold(var/N as num)
			if(!N){N=1}
			heatThreshold = N
			maxHeatThreshold =N
		proc/setHeat(var/N as num)
			heat = N
		proc/setSpecificHeat(var/N as num)
			if(!N){N=1}
			specificHeat = N
			maxSpecificHeat =N
