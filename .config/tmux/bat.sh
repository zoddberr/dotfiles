#!/bin/dash

bat_colored() {
	local id="$1"
	local base="/sys/class/power_supply/BAT${id}"

	cap=$(cat "$base/capacity" 2>/dev/null)
	status=$(cat "$base/status" 2>/dev/null)

	if [ "$status" = "Charging" ]; then
		color="colour109" # blue
	elif [ "$cap" -ge 50 ]; then
		color="colour142" # green
	elif [ "$cap" -ge 20 ]; then
		color="colour214" # orange
	else
		color="colour167" # red
	fi

	printf "#[fg=%s] %d%%#[default]" "$color" "$cap"
}

bat_colored 1
bat_colored 0
