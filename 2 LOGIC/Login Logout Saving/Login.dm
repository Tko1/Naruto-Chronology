mob
	Login()
		src.ADMIN_CHECK()
		src.cantMove = 1
		src.loc = locate(6,7,2)
		src.icon = null
		..()
		world << "<font color=blue>[src] has entered the game."


turf
	LoginScreen
		icon = 'login4.png'
		Click()
			if(usr.isClickingLogin)
				return
			usr.isClickingLogin = 1
			switch(input(usr,"Would you like to load or make a new character?") in list("New","Load"))
				if("New")usr.newCharacter()
				if("Load")usr.loadCharacter()
var/elementTries = 0
mob
	//Debug

	var/isClickingLogin = 0
	proc/startLoops()
		src:replenishChakra()
	proc/loadCharacter()
		world << "I am [src] my path is [type]"
		if(fexists("Saves/[src.ckey]")&&loginState != "Logged in")//checks to see if the player has a save file 1
			var/savefile/S = new("Saves/[src.ckey]")//same as above but since its already created, does not create a new one
			Read(S)//calls the read proc for s
			src.loginState = "Logged in"
			src.icon = 'player.dmi'
			src.cantMove = 0
			world << "my [x] [y] [z]"
			src.startLoops()
		else
			alert(src,"No character save found","NC")
			src.isClickingLogin = null
			//S["last_x"] >> src.x//restores tha player's x loc
		//	S["last_y"] >> src.y//restores the player's y loc
		//	S["last_z"] >> src.z//restores the player's z loc
		//	var/Verbos
		//	S["Verbs"] >> Verbos//stores player's z loc in the file
	//		src.verbs += Verbos

	proc/newCharacter()
		if(fexists("Saves/[src.ckey]"))fdel("Saves/[src.ckey]")
		if(istype(src,/mob/MainCharacter))
			var/mob/MainCharacter/M = src
			M.name = input(src,"What's your name?","Naruto Civilization")

			var/list/elements = list("Fire","Water","Electricity","Earth","Wind")
			var/probability = 100
			for(var/i = 0, i<5, i++)
				if(prob(probability))
					var/eleBuffer = pick(elements)
					M.addChakraElement(eleBuffer)
					elements -= eleBuffer
					probability = 10
					continue
				break
			M.skillCheck()
			world << "<font color=red>[M] has logged in!"
			M.coreSkillpoints = 22
			M.skillpoints = 5
			M << "You now have [M.coreSkillpoints] core skill points to disperse into your core skills"
			M << "You now have [M.skillpoints] skillpoints to disperse into your skills"
			M.levelUp()
			M.loc = locate(71,150,1)
			M.setSpawnLocation()
			M.icon = 'player.dmi'
			M.cantMove = 0
			M<<sound(null)

			src.loginState = "Logged in"
		else
			world << "Exception: newCharacter() has to be of type Main Character instead of [src.type]"

