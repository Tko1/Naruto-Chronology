/*
	These are simple defaults for your project.
 */
var
	mob
		atmosphere = new /mob/Atmosphere()
world
	name = "Naruto: Chronology"
	mob = /mob/MainCharacter
	fps = 25		// 25 frames per second
	icon_size = 32	// 32x32 icon size by default

	view = 6		// show up to 6 tiles outward from center (13x13 view)
	New()
		..()
		spawn() theyreComing()
var/gameSpeed = 100
proc
	theyreComing()
		sleep(100)
		world << "<font size=4><font color=red> The sun is high in the sky."
		sleep(3000/gameSpeed)
		world << "<font size=4><font color=red> Noon approaches"
		sleep(3000/gameSpeed)
		world << "<font size=4><font color=red> The world gets a bit colder, the sun a bit lower"
		sleep(1500/gameSpeed)
		world << "<font size=4><font color=red> They.."
		sleep(1500/gameSpeed)
		world << "<font size=4><font color=red> They're coming"
		sleep(3000/gameSpeed)
		spawnEnemies()
		sleep(3000/gameSpeed)
		world << "<font size=4><font color=blue> The night is still young"
		sleep(3000/gameSpeed)
		world << "<font size=4><font color=blue> The night begins to falter"
		sleep(6000/gameSpeed)
		world << "<font size=4><font color=blue> They grow tired"
		sleep(6000/gameSpeed)
		world << "<font size=4><font color=purple>Are we safe"
		theyreComing()
	spawnEnemies()

// Make objects move 8 pixels per tick when walking

mob
	step_size = 32

obj
	step_size = 32
