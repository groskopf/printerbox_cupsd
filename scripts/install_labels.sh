#!/bin/sh
set -x

/usr/sbin/cupsd

brpapertoollpr_td4550dnwb -P TD4550DNWB -n navneskilt_4786103 -w 98 -h 170.7 -g 3.0 -b 3.0 -t 3.0 -r 1.5 -l 1.5 -S 2 -m 3.3 -o 0.0
cat /etc/cups/ppd/TD4550DNWB.ppd | grep navneskilt_4786103 | grep PageSize | sed 's/.* \(.*\)\/.*/\1/' > labels/4786103.txt

#brpapertoollpr_td4550dnwb -P TD4550DNWB -n navneskilt_4760100 -w 100 -h 60 -g 3.5 -b 0.0 -t 0.0 -r 0.0 -l 0.0 -S 2 -m 3.5 -o 0.0
brpapertoollpr_td4550dnwb -P TD4550DNWB -n navneskilt_4760100 -w 100 -h 60 -g 3.5 -b 0.0 -t 0.0 -r 0.0 -l 0.0 -S 1
cat /etc/cups/ppd/TD4550DNWB.ppd | grep navneskilt_4760100 | grep PageSize | sed 's/.* \(.*\)\/.*/\1/' > labels/4760100.txt
