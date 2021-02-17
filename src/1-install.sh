#!/usr/bin/env bash

source ./util/init.sh
source ./util/logging.sh

__init $@

__debug "Starting install script..."

# Installing

## Selecting the mirror
reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

## Installing essential packages
pacstrap /mnt base linux linux-firmware vim 
