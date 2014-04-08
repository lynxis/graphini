BEGIN {
	keys["rxbytes"]
	keys["rxpackets"]
	keys["txbytes"]
	keys["txpackets"]
	keys["txretries"]
	keys["txfailed"]
	keys["signal"]
}
{
	if (NF == 1) {
		mac = substr($0, 9, 17)
		next
	}

	key = $2
	value = $3
	# remove ending colon e.g. "tx packets:" -> "tx packets"
	colon = index(key, ":")
	if (colon > 0) key = substr(key, 1, colon - 1)

	# remove a white space e.g. "tx packets" -> "txpackets"
	white = index(key, " ")
	if (white > 0) key = substr(key, 1, white - 1) substr(key, white + 1)

	if (!(key in keys)) {
		next
	}

	if (key == "signal") {
		n=split(value,array," ")
		value = array[1]
	}

	print prefix "." mac "."  key " " value " " timestamp
}
