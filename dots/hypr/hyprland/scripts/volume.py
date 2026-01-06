#!/bin/python

import sys
import subprocess

function = sys.argv[1]

if function == "up":
    subprocess.run(["pamixer", "--unmute", "--increase", "5"])

if function == "down":
    subprocess.run(["pamixer", "--unmute", "--decrease", "5"])

if function == "mute":
    subprocess.run(["pamixer", "--toggle-mute"])


volume = subprocess.check_output(["pamixer", "--get-volume"]).decode("utf-8").strip()
muted = subprocess.check_output(["pamixer", "--get-mute"]).decode("utf-8").strip() == "true"

if muted:
    subprocess.run(["notify-send", "-u", "low", "-h", "string:x-canonical-private-synchronous:volume_notif", "Volume", "🔇 Muted"])
else:
    subprocess.run(["notify-send", "-u", "low", "-h", "string:x-canonical-private-synchronous:volume_notif", "Volume", f"🔈 {volume}%"])
