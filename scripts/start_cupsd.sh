#!/bin/sh
set -x
set -e

# Start cupsd
/usr/sbin/cupsd -f &
sleep 2

#Add printer
lpadmin -p TD4550DNWB -E -v usb://Brother/TD-4520DN?serial=000A0Z694367 -P /usr/share/cups/model/Brother/brother_td4550dnwb_printer_en.ppd
lpstat -a
cancel -a

set +x
# Wait for cupsd to stop
CUPSD_PID=$(cat /var/run/cups/cupsd.pid)
while [ -d "/proc/${CUPSD_PID}" ]; do sleep 1; done
