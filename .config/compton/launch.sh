#!/usr/bin/env bash

# Terminate already running compton instances
killall -q compton

# Launch compton
compton -b --config ~/.config/compton/compton.conf
echo "compton launched..."
