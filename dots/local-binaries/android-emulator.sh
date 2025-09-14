#!/bin/sh

cd ~
./Android/Sdk/emulator/emulator -avd Pixel_9_Pro_Fold -dns-server 8.8.8.8 &
sleep 2
pactl set-card-profile bluez_card.00_1B_66_EA_8F_98 a2dp-sink
