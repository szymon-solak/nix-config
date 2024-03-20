#!/bin/sh

if [ $SELECTED = "on" ]; then
  exit 0
fi

sketchybar \
	--set $NAME \
	background.drawing=$SELECTED
