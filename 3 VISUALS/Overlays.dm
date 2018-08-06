atom
	var/list/Overlays = list()
	var/Underlays = list()
	proc
		addOverlays(var/overlay)
			Overlays += overlay
			refreshOverlays()
		addUnderlays(var/underlay)
			Underlays += underlay
			refreshUnderlays()
		refreshOverlays()
			overlays = null
			for(var/O in Overlays)
				src.overlays += O
		refreshUnderlays()
			underlays = null
			for(var/O in Underlays)
				src.underlays += O
		removeOverlay(var/overlay)
			Overlays = removeFromList(overlay,Overlays)
			refreshOverlays()