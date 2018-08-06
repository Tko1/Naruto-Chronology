obj
	var
		count = 1 //how many in inventory
		gettable = 1
		droppable = 1
		build //what to build
		isWorn = 0


		list/limbsWornOn
		buildRequirement
		mineRequirement
	Click()
		..()
		if(message)
			processMessage()
	Del()
		if(src.owner)
			removeOwner(owner)
		.=..()
	proc/removeOwner(var/owna)
		//owners = removeFromList(owna,owners)
	proc/processMessage()
		if(message[1]=="get")
			get()
			return
		if(message[1]=="drop")
			_drop()
			return
		if(message[1]=="chop")
			chop()
			return
		if(message[1]=="plant")
			plant()
			return
		if(message[1]=="build")
			build()
			return
		if(message[1]=="set build")
			setBuild()
			return
		if(message[1]=="push")
			push()
			return
		if(message[1]=="ride")
			ride()
			return
		if(message[1]=="getOff")
			getOff()
			return
		if(message[1]=="eat")
			eat()
			return
		if(message[1]=="craft")
			craft()
			return
		if(message[1]=="wear")
			wear()
			return
		if(message[1]=="take off")
			takeOff()
			return
		else
			default()
	verb
		chop()
		craft()
		eat()
		getOff(var/direction as null)
		ride()
		push()
		setBuild()
		default()
		plant()
		build()
		wear()
		takeOff()
			return 1
		forcedTakeOff()
			takeOff()
		get(mob/user)
			if(!user)user = usr
			if(src.gettable)
				if(user.inside(oview(1,src)))
					if(user.addContents(src))return 1
			return 0
		_drop()
			set hidden = 1
			drop()
	proc/subCount()
		src.count--
		src.loc:inventoryWeight -= src.weight
		src.inventoryName()
		if(src.count<=0)
			del(src)
	proc/convert(var/obj/O,var/owna)
		if(ispath(O))
			var/obj/NewObj = new O(usr.loc)
			if(owna)NewObj.owner = owna
		else
			if(O){O.loc = usr.loc;if(owna){O.owner=owna}}
		src.subCount()
	proc/drop(var/didMyOwnerDie=0)
		if(!ismob(src.loc))return 0
		if(didMyOwnerDie)
			forcedTakeOff()
		else
			if(!takeOff())return 0
		var/obj/newerObject = new type(src.loc.loc)
		subCount()
		newerObject.hasBeenDropped()
	proc/dropAll(var/didMyOwnerDie=0)
		while(src)
			drop(didMyOwnerDie)
	proc/hasBeenDropped()
		message = list("get")
	proc/hasBeenGetted()
