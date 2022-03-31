#!/bin/bash

# Copyright (C) 2020 Boulder Engineering Studio
# Author: Erin Hensel <hens0093@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

function do_umount() {
    RETURNCODE=$?
    if grep -qs '/mnt' /proc/mounts; then
        # sudo umount /mnt
        umount /mnt
    fi
    if [ -n "${LODEV}" ]; then
        # sudo losetup -d "${LODEV}"
        losetup -d "${LODEV}"
    fi
    return $RETURNCODE
}

function mount-img() {
    if [ -z "$1" ] ; then
        echo "usage: $0 IMG_FILE MOUNT_POINT PARTITION_NUMBER"
        exit 1
    fi
    IMG_FILE=$1

    if [ -z "$2" ] ; then
        echo "usage: $0 IMG_FILE MOUNT_POINT PARTITION_NUMBER"
        exit 1
    fi
    MOUNT_POINT=$2

    if [ -z "$3" ] ; then
        echo "usage: $0 IMG_FILE MOUNT_POINT PARTITION_NUMBER"
        exit 1
    fi
    PARTITION_NUMBER=$3

    echo "Mounting partition ${PARTITION_NUMBER} of ${IMG_FILE} at ${MOUNT_POINT}"

    START=$(fdisk -l -o Start ${IMG_FILE} | tail -n +9 | head -n${PARTITION_NUMBER} | tail -n1)
    OFFSET=$(expr ${START} \* 512)
    mount -o loop,offset=${OFFSET} ${IMG_FILE} ${MOUNT_POINT}

    echo "Use 'umount ${MOUNT_POINT}' to unmount"
}

export PT_FILENAME="partition_table.txt"
