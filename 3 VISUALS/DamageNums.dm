proc/showDamage(var/atom/movable/who,var/amountToShow)
	showNums(who,amountToShow,0)
proc/showNums(var/atom/movable/who,var/amountToShow,var/column)
	if(who==null)
		return
	var/location=who.loc
	var/damage=round(amountToShow)
	damage=num2text(damage)
	var/spot=0
	for(var/pxplus=column*7,pxplus<(7*3+column*7),pxplus += 7)
		spot+=1
		var/obj/damagenum/O=new/obj/damagenum
		O.pixel_x+=pxplus
		O.loc=location
		spawn(10)
			O.die()
		flick("[copytext(damage,spot,spot+1)]",O)
proc/showHeat(var/atom/movable/who,var/amountToShow)
	world << "This is heat"
	showNums(who,amountToShow,-4)
proc/showCold(var/atom/movable/who,var/amountToShow)
	showNums(who,amountToShow,-4)
obj/damagenum
	icon='damagenums.dmi'
	density=0
	isBattleReady = 0
	layer=MOB_LAYER+3
	doesNotExistInTheRealWorld = 1
	die()
		del(src)