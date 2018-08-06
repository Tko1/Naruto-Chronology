/**
Default view is ...13 x 13?


**/
mob
	var
		list/actionWords
		list/actionWordsRow2
		list/screenObject
		list/skillObject  //skillbar
	//Add screen object, add list of objects
	proc/addSkillObject(var/obj/Generic)
		if(Generic)
			skillObject += Generic
			client.screen += Generic
	proc/positionSkillObject(var/list/L)
		var/lowestposition = getFirstObject(skillObject)
		for(var/obj/Screen/Skill/O in L)
			world << "Hello? wtf"
			var/positionBuffer = lowestposition - O.position[1]
			if(positionBuffer < 0)
				O.position[1] = 12
				O.position[2]++
		setScreenLoc(L)
	proc/setScreenLoc(var/list/L)
		world << "This is in L : [L]"
		world << "Do i get here"
		for(var/obj/Screen/O in L)
			world << "Now I'm here"
			O.screen_loc = "[O.position[1]],[O.position[2]]"
	proc/addSkillObjectList(var/list/L)
		world << "TOtally"
		positionSkillObject(L)
		for(var/thing in L)
			if(!skillObject)skillObject = list()
			skillObject += thing
			client.screen += thing
			world << "Whats going on here"
	proc/removeSkillObject(var/obj/Generic)
		var/list/newList = list()
		for(var/obj/Screen/Skill/O in skillObject)
			if(O!=Generic)
				newList += O
		client.screen = newList
		screenRefresh()
	proc/addScreen(var/obj/Generic)
		if(Generic)
			if(!screenObject)screenObject = list()
			screenObject += Generic
			for(var/i = 1, i < length(screenObject), i++)
				world << "This is [screenObject[i]]"
			client.screen += Generic
	proc/addScreenList(var/list/L)
		for(var/thing in L)
			if(!screenObject)screenObject = list()
			screenObject += thing
			client.screen += thing
	proc/removeScreen(var/obj/Generic)
		var/list/newList = list()
		for(var/obj/Screen/Other/O in screenObject)
			if(O!=Generic)
				newList += O
		src.client.screen = newList
		screenRefresh()
	//ADDING WORDS, REMOVING WORDS
	//Note, removing words will remove all instances of the letters you input, not just one or two. Its suggested messages are
	//cleared instead.
	/*proc/updateScreenFromListOfText(var/mob/mobWithScreen,var/list/text)
		mobWithScreen.clearWords()
		var/row = 1
		for(var/ii = 1,ii<=length(text),ii++)
			if(text[ii])
				mobWithScreen.addWord(row,text[ii])
				row++*/
	proc/addWordList(var/list/L)
		//for(var/obj/thing in L)
		if(!actionWords)actionWords = list()
		actionWords += L
		client.screen += L
	proc/addWord(var/row,var/t as text)
		var/list/buffer = makeWord(t)
		var/highestposition = 0
		for(var/obj/Screen/Letter/l in src.actionWords)
			if(l.position[2]==row&&l.position[1]>highestposition)
				highestposition = l.position[1]
		for(var/obj/Screen/Letter/l in buffer)
			l.position[1] += highestposition
			l.position[2] = row
			var/x_pos = ciel(l.position[1]/2)
			var/x_pix = 0
			var/y_pos = 14-row
			var/y_pix = 0
			if(l.position[1]%2==0)
				x_pix = 16
			l.screen_loc = "[x_pos]:[x_pix],[y_pos]:[y_pix]"
		addWordList(buffer)
	proc/removeWord(var/obj/Generic)
		var/list/newList = list()
		for(var/obj/Screen/Letter/O in src.actionWords)
			if(O!=Generic)
				newList += O
		actionWords = newList
		screenRefresh()
	proc/removeWordList(var/t as text)
		var/list/wordsToRemove = makeWord(t)
		for(var/obj/Screen/Letter/O in wordsToRemove)
			removeWord(O)
	proc/clearWords()
		src.actionWords = null
		src.actionWordsRow2 = null
		screenRefresh()
	//Screen refreshing
	//
	//
	///////////////////
	proc/screenRefresh()
		src.client.screen = null
		screenObjRefresh()
		skillObjRefresh()
		wordsRefresh()
	proc/skillObjRefresh()
		for(var/obj/Screen/Other/O in src.skillObject)
			src.client.screen += O
	proc/screenObjRefresh()
		for(var/obj/Screen/Other/O in src.screenObject)
			src.client.screen += O
	proc/wordsRefresh()
		for(var/obj/Screen/Letter/O in src.actionWords)
			src.client.screen += O
		for(var/obj/Screen/Letter/O in src.actionWordsRow2)
			src.client.screen += O
	//unrelated
	proc/getLastObject(var/list/L)
		var/highestposition = 0
		for(var/obj/Screen/Letter/l in L)
			if(l.position[1]>highestposition)
				highestposition = l.position[1]
		return highestposition
	proc/getFirstObject(var/list/L)
		var/lowestposition = 12
		for(var/obj/Screen/Letter/l in L)
			if(l.position[1]<lowestposition)
				lowestposition = l.position[1]
		return lowestposition
//TODO