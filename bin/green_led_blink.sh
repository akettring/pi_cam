#!/bin/bash
echo 1 | sudo tee /sys/class/leds/led0/brightness
echo 0 | sudo tee /sys/class/leds/led0/brightness