obj
	VisualEffects
		isBattleReady = 0
		density = 0
		doesNotExistInTheRealWorld = 1
		Explosion
			New()
				..()
				flick('explode.dmi',src)
				spawn(15)
				del(src)