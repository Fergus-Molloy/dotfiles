#!/usr/bin/env python3
import sys
import subprocess
import re

if __name__ == "__main__":
    test = subprocess.run(["xrandr", "--current", "--verbose"], capture_output=True)
    out = re.search("Brightness.\s\d(\.*)(\d)*", str(test.stdout))
    string = out.group(0)
    string = string.split(':')
    brightness = float(string[1].strip(' '))
    if len(sys.argv) < 3:
        print("Not enough arguments given\nExpected 2 got", len(sys.argv)-1)
        exit()
    try:
        if sys.argv[1] == "-i":
            brightness += round(float(sys.argv[2]), 1)

        elif sys.argv[1] == "-d":
            brightness -= round(float(sys.argv[2]), 1)
        else:
            print("Unrecognised option:", sys.argv[1])
            exit()
        process = subprocess.run(["xrandr", "--output", "eDP-1", "--brightness", str(brightness)], stdout=subprocess.PIPE)
        print("Brightness set to", brightness)
# alias brightness="xrandr --output eDP-1 --brightness"
    except ValueError:
        print("Could not parse", sys.argv[2], "as a float")
        exit()
