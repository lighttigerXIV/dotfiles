#!/bin/python

import subprocess, sys

action = sys.argv[1]

print(action)



if action == "enable":
    subprocess.run(["hyprctl", "dispatch","fullscreen", "0"])
    subprocess.run(["hyprctl", "keyword", "monitor", "HDMI-A-1,1920x1080@119.88,auto,1"])
    exit(0)

if action == "disable":
    subprocess.run(["hyprctl", "keyword", "monitor", "HDMI-A-1,2560x1440@120.00,auto,1"])
    exit(0)


