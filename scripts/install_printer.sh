#!/bin/sh
set -x

/usr/sbin/cupsd

mkdir -p /var/spool/lpd/td4550dnwb/ && dpkg -i --force-all brother/td4550dnwbpdrv-3.1.5-0.armhf.deb
