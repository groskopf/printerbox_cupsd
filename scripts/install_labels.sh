#!/bin/sh
set -x

/usr/sbin/cupsd

brpapertoollpr_td4550dnwb -P TD4550DNWB -n navneskilt -w 98 -h 170.7 -g 3.0 -b 3.0 -t 3.0 -r 1.5 -l 1.5 -S 2 -m 3.3 -o 0.0
lpoptions -p TD4550DNWB -o BrTrimtape=OFF
cat /etc/cups/ppd/TD4550DNWB.ppd | grep navneskilt | grep PageSize | sed 's/.* \(.*\)\/.*/\1/' > labels/navneskilt.txt