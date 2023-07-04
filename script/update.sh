#!/bin/bash
sleep 60
sudo apt-get update -y && sudo apt-get upgrade -y ||notify-send "update failed"