#!/bin/sh

gsettings set org.gnome.system.proxy mode 'manual'
nmcli radio wifi off
