obj //Armor cheese`````````````````
	Battle
		var/isEquipped
		Equipment

			icon = 'armor.dmi'
			var

				//equipment boosts
				defenseBoost = 0
				attackBoost = 0
				specificHeatBoost = 0
				sharpnessBoost = 0
				toughnessBoost = 0
				heatThresholdBoost = 0
			proc/setAttributes(var/mob/M)
				M:transAddDefense(defenseBoost)
				M:transAddStrength(attackBoost)
				M:transAddSharpness(sharpnessBoost)
				M:transAddToughness(toughnessBoost)
				M:transAddSpecificHeat(specificHeatBoost)
				setSpecialAttributes()
			proc/removeAttributes(var/mob/M)
				M:transSubDefense(defenseBoost)
				M:transSubStrength(attackBoost)
				M:transSubSharpness(sharpnessBoost)
				M:transSubToughness(toughnessBoost)
				M:transSubSpecificHeat(specificHeatBoost)
				removeSpecialAttributes()
			proc/setSpecialAttributes()
			proc/removeSpecialAttributes()
			get()
				if(..(usr))
					message = list("wear","drop")
			Head
				IronHelmet
			Chest
			Legs
				IronLegPlate
			Arms
				LeftArm
				RightArm
				OneHanded
					wear()
						var/whichHand
						var/isUsingBadHand = 0
						//find out if left handed or right handed; this will be the first attempted hand
						if(istype(usr,/mob/MainCharacter))
							if(usr:leftHanded > usr:rightHanded)whichHand = "leftHanded"
							else whichHand = "rightHanded"
						//if this hand is taken, use the bad hand.
						if(whichHand=="leftHanded"&&usr.leftArm){whichHand = "rightHanded";isUsingBadHand = 1}
						if(whichHand=="rightHanded"&&usr.rightArm){whichHand = "leftHanded";isUsingBadHand = 1}
						//if the bad hand is also taken,  fuck, you're out of luck, dude.
						if(whichHand=="rightHanded" && usr.rightArm && isUsingBadHand\
							||\
						   whichHand=="leftHanded" && usr.leftArm && isUsingBadHand)\
						   {\
						   usr << "Unequip something from one of your hands";return 0;\
						   }
						  //Normal stuff
						usr.addOverlays(src)
						if(whichHand=="leftHanded")usr.leftArm = src
						if(whichHand=="rightHanded")usr.rightArm = src
						setAttributes(usr)
						setMessage(1,"take off")
				takeOff(var/mob/M)
					if(!M)M=src.loc
					setMessage(1,"wear")
					var/whichArm
					if(M.leftArm==src){whichArm = "leftArm"}
					else if(M.rightArm==src){whichArm = "rightArm"}
					else return 0

					removeAttributes(M)
					M.removeOverlay(src)
					if(whichArm=="leftArm")M.leftArm = null
					if(whichArm=="rightArm")M.rightArm = null
					setMessage(1,"wear")
					setMessage(2,"drop")
					world << "Im taken off"
				forcedTakeOff()
					world << "IM HUR"
					takeOff()
				_drop()
					if(!src.isEquipped)return ..()
			Feet
			Chest
				wear()
					if(usr.chest){usr << "ERROR: You're wearing something on your chest"; return 0}
					setAttributes(usr)
					usr.addOverlays(src)
					usr.chest = src
					setMessage(1,"take off")
				takeOff(var/mob/M)
					if(!M)M=src.loc
					setMessage(1,"wear")
					if(M.chest!=src)return 0
					removeAttributes(M)
					M.removeOverlay(src)
					M.chest = null
					setMessage(1,"wear")
					setMessage(2,"drop")
				_drop()
					if(!src.isEquipped)return ..()

			Underwear
				wear()
					if(usr.underwear){usr << "ERROR: You're wearing something underneath"; return 0}
					usr.underwear = src
					usr.addOverlays(src)
					setAttributes(usr)
					setMessage(1,"take off")
				takeOff(var/mob/M)
					if(!M)M=src.loc
					if(M.chest){usr << "ERROR: You need to take your chest armor off first"; return 0}
					if(M.underwear!=src){usr << "ERROR: You're not wearing me";return 0}
					removeAttributes(M)
					M.removeOverlay(src)
					setMessage("wear")
				forcedTakeOff(var/mob/M)
					if(!M)M=src.loc
					if(M.underwear!=src){return 0}
					removeAttributes(M)
					M.removeOverlay(src)

					setMessage("wear")
