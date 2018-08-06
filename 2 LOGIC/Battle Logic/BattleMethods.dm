mob/proc/combatImpact(var/obj/Punch, var/B)
	for(var/atom/movable/m in B)
		if(m.loc==Punch.loc&&m!=Punch)
			var/attack1_prob = 90 - m.reflexes
			if(m.state=="Attacking")
				//90% max dodge
				var/attackSkills = src.combatOffense - m.combatOffense
				if(attackSkills<0){attackSkills=0;}
				if(attackSkills>40){attackSkills=40;}
				attack1_prob -= (m.combatDefense + attackSkills)
			if(prob(attack1_prob))
				usr.impact(m)
	del(Punch)
mob/proc/combatCut(var/obj/Punch, var/B)
	for(var/atom/movable/m in B)
		if(m.loc==Punch.loc&&m!=Punch)
			var/attack1_prob = 90 - m.reflexes
			if(m.state=="Attacking")
				//90% max dodge
				var/attackSkills = m.combatDefense/2
				if(attackSkills < 0){attackSkills = 0}
				attack1_prob -= attackSkills
			if(prob(attack1_prob))
				Punch.cut(m)
				//world << "My healf: [Punch.owner:blood]"
				//world << "[m]'s healf: [m.blood]"
	spawn(4)
		del(Punch)
