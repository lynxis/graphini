BEGIN {
	simple_keys["rx bytes"]
	simple_keys["rx packets"]
	simple_keys["tx bytes"]
	simple_keys["tx packets"]
	simple_keys["tx retries"]
	simple_keys["tx failed"]
}
{
	if (NF == 1) {
		mac = substr($0, 9, 17)
		next
	}

	key = $2
	value = $3
	colon = index($2 , ":")
	if (colon > 0) key = substr($2, 1, colon - 1)

	if (key in simple_keys) {
		print prefix "." key " " value " " timestamp
		next
	}
	if (key == "signal") {
		n=split(value,array," ")
		value = array[1]
		print prefix "." key " " value " " timestamp
	}
}
EOF
