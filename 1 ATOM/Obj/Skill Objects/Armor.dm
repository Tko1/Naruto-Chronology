obj //Armor cheese`````````````````
	Battle
		Equipment

			Head
				IronHelmet

			Chest

			Legs
				IronLegPlate

			Arms
				LeftArm
				RightArm
				OneHanded
					Axe
						icon = 'axe.dmi'
						message = list("get")
						sharpnessBoost = 10
						weight = 20
						setSpecialAttributes()
							usr.hasEquippedAxe = 1
						removeSpecialAttributes()
							usr.hasEquippedAxe = 0

			Feet

			Chest
				IronChestPlate
					icon_state = "ironChestPlate"
					defenseBoost = 20
					toughnessBoost = 10
					layer = MOB_LAYER+1
					message = list("wear")

			Underwear
				FlameJumpsuit
					icon_state = "flameJumpsuit"
					layer = MOB_LAYER+1
					specificHeatBoost = 3
					message = list("get")
