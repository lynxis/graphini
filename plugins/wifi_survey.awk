BEGIN {
	keys["frequency"]
	keys["noise"]
	keys["channel active time"]
	keys["channel busy time"]
	keys["channel receive time"]
	keys["channel transmit time"]
	ms["channel active time"]
	ms["channel busy time"]
	ms["channel receive time"]
	ms["channel transmit time"]
	freq = 0
}
{
	key = $2
	# value position depends on key. for all "channel * time" -> $4, noise -> $6, frequency -> $5
	value = $4

	# remove ending colon e.g. "tx packets:" -> "tx packets"
	colon = index(key, ":")
	if (colon > 0) key = substr(key, 1, colon - 1)

	# check if key is known
	if (!(key in keys)) {
		next
	}

	if (key == "frequency") {
		freq = $5
		# "5250 MHZ" -> 5250
		n=split(freq,array," ")
		if (n > 0) freq = array[1]
		next
	}

	if (key == "noise") {
		value = $6
	}

	# remove a white space e.g. "tx packets" -> "txpackets"
	do {
		white = index(key, " ")
		if (white > 0) key = substr(key, 1, white - 1) substr(key, white + 1)
	} while (index(key, " ") > 0)
	
	n=split(value,array," ")
	if (n > 0) value = array[1]

	print prefix "." freq "."  key " " value " " timestamp
}
