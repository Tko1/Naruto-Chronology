mob/var/tmp/loginState //are we logged in? or something else
mob/proc/Save()
	if(loginState!="Logged in")return
	src << "Character successfully saved."
	var/savefile/S = new("Saves/[src.ckey]")//creates a savefile with the name of the player's ckey in a folder called saves and is shorthanded as s
	S["last_x"] << src.x//stores players x loc in the file
	S["last_y"] << src.y//stores player's y loc in the file
	S["last_z"] << src.z//stores player's z loc in the file
	Write(S)//calls the write proc
mob/proc/SaveOnLogout()
	if(loginState!="Logged in")del(src)
	src << "Character successfully saved."
	state = "Standing"
	var/savefile/S = new("Saves/[src.ckey]")//creates a savefile with the name of the player's ckey in a folder called saves and is shorthanded as s
	S["last_x"] << src.x//stores players x loc in the file
	S["last_y"] << src.y//stores player's y loc in the file
	S["last_z"] << src.z//stores player's z loc in the file
	Write(S)//calls the write proc
	del(src)
mob/Write(savefile/F)
	..()
	F["overlays"] << null
	F["underlays"] << null
mob/var/tmp/savefile_version   // you don't need to load this--make it /tmp

mob/Read(savefile/F)
	..()
	var/X,Y,Z
	F["last_x"] >> X
	F["last_y"] >> Y
	F["last_z"] >> Z
	src.loc = locate(X,Y,Z)
	spawn()
		var/area/a = src.loc.loc
		if(a)a.Entered(src)
mob
	Logout()
		world << "<font color=red>[src] has disconnected"
		src.SaveOnLogout()