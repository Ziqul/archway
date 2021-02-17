#!/usr/bin/env bash

source ./util/init.sh
source ./util/logging.sh

__init $@

__debug "Starting pre-install script..."

# Pre-installing

## Verifing the boot mode
# TODO: Write test for this condition
ls /sys/firmware/efi/efivars $1>/dev/null && \
	__info "Booted in UEFI mode. Proceeding..." || \
	__error "Booted in BIOS mode." \
		"Please update your BIOS or boot in UEFI mode" \
		"Aborting..."

## Updating the system clock
timedatectl set-ntp true

## Partition the disks
### Listing available disks
fdisk -l

### Asking user what device would contain the system
echo "Choose a disk on which system would be installed"
echo "(Results ending in rom, loop or airoot may be ignored)"
read DEVICE

### Partitioning
parted $DEVICE -s \
	mklabel gpt \
	mkpart '"EFI partition"' fat32 1MiB 261MiB
	set 1 esp on
	mkpart '"root partition"' ext4 261MiB 100%

## Formating the partitions
mkfs.fat -F 32 "${DEVICE}1"
mkfs.ext4 "${DEVICE}2"

## Mounting the file systems
mount /dev/sda2 /mnt
mkdir /mnt/efi && mount /dev/sda1 /mnt/efi
