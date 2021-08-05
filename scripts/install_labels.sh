#!/bin/sh
set -x

/usr/sbin/cupsd

brpapertoollpr_td4550dnwb -P TD4550DNWB -n navneskilt_4786103 -w 103 -h 171 -g 0 -b 3 -t 3 -r 1.5 -l 1.5 -S 2 -m 3.0 -o 0.0
cat /etc/cups/ppd/TD4550DNWB.ppd | grep navneskilt_4786103 | grep PageSize | sed 's/.* \(.*\)\/.*/\1/' > labels/4786103.txt

brpapertoollpr_td4550dnwb -P TD4550DNWB -n navneskilt_4760100 -w 100 -h 60 -g 3.5 -b 1.5 -t 1.5 -r 1.5 -l 1.5 -S 1
cat /etc/cups/ppd/TD4550DNWB.ppd | grep navneskilt_4760100 | grep PageSize | sed 's/.* \(.*\)\/.*/\1/' > labels/4760100.txt
