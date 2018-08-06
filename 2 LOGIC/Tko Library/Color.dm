Color
	var
		red=0;green=0;blue=0;alpha=0
	RED
		red=255
	GREEN
		green255
	BLUE
		blue=255
	CUSTOM
		New(R,G,B)
			.=..()
			red = R
			green = G
			blue = B
	proc/getColor()
		return rgb(red,green,blue)
proc/COLOR_RED()
	return rgb(255,0,0)
proc/COLOR_GREEN()
	return rgb(0,255,0)
proc/COLOR_BLUE()
	return rgb(0,0,255)