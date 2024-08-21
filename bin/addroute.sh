#!/bin/sh

sudo route del default gw 10.227.15.1
sudo route add $1 gw 10.227.15.1
