#!/bin/sh

# The wifi_change event supplies a $INFO variable in which the current SSID
# is passed to the script.

CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
SSID="$(echo "$CURRENT_WIFI" | grep -o 'SSID: .*' | sed 'SSID: //g')"
IP="$(ipconfig getifaddr en0)"
CHANNELS="$(echo "$CURRENT_WIFI" | grep -o 'channel: .*')"
FREQUENCY="2.4GHz"

if [[ "$CHANNELS" == *"44"* ]] || [[ "$CHANNELS" == *"112"* ]] || [[ "$CHANNELS" == *"80"*  ]]; then
	FREQUENCY="5GHz"	
fi

if [ "$SENDER" = "wifi_change" ]; then
	if [ -z "$IP" ]; then
		sketchybar --set $NAME label="Not Connected"
	else
		sketchybar --set $NAME label="${FREQUENCY}"
	fi
fi
