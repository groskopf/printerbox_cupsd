#!/bin/sh
set -x
set -e

# Start cupsd
/usr/sbin/cupsd -f &
sleep 2

PRINTER_SERIAL=$(lsusb -v -d 04f9:20b9 2>/dev/null | grep iSerial | awk '{print $3}')

#Add printer
lpadmin -p TD4550DNWB -E -v usb://Brother/TD-4520DN?serial=${PRINTER_SERIAL} -P /etc/cups/ppd/TD4550DNWB.ppd
lpstat -a
cancel -a

set +x
# Wait for cupsd to stop
CUPSD_PID=$(cat /var/run/cups/cupsd.pid)
while [ -d "/proc/${CUPSD_PID}" ]; do sleep 1; done
