#!/bin/sh

gsettings set org.gnome.system.proxy mode 'none'
nmcli radio wifi on
