proc
	contains(var/textThatMayContainOther, var/other)
		var/increment = length(other)
		for(var/i = 1, i+increment <= length(textThatMayContainOther)+1, i++)
			var/test = copytext(textThatMayContainOther,i,i+increment)
			if(test==other)
				return 1
		return 0
proc
	replace(var/textThatMayContainOther,var/original, var/newText)
		var/increment = length(original)
		var/begin = 1
		var/end
		for(var/i = 1, i+increment <= length(textThatMayContainOther)+1, i++)
			var/test = copytext(textThatMayContainOther,i,i+increment)
			if(test==original)
				begin = i
				end = i+increment
				break
		var/output = copytext(textThatMayContainOther,1,begin) + newText + copytext(textThatMayContainOther,end)
		return output;