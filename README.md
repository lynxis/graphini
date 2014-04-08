# What is graphini
A collector and reporter for [graphite](http://graphite.readthedocs.org/en/latest/overview.html).
It's written in plain sh, because it (must) runs on openWrt.

# How to install
Add graphini to crontab

	* * * * * <path>/graphini
# Configure
Change `CARBON_HOST` to your local server.

# How to write plugin?

## 1. What is a plugin?
  - an executable in PLUGIN_DIR with suffix .plugin
  - stdout is send to carbon (newline format)
  - carbon format is `<metric> <value> <timestamp epoch seconds>\n`

## 2. Example plugin
	#!/bin/sh
	echo "${PREFIX}.theanswer" 42 $TIMESTAMP

