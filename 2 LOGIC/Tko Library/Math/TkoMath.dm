proc/ciel(var/n as num)
	return round(-n)*-1
proc/tkoRound(var/n as num)
	if(n-round(n)<0.5)
		return round(n)
	else
		return ciel(n)