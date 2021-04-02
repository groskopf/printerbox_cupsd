#!/bin/sh
set -x

/usr/sbin/cupsd
lpadmin -p TD4550DNWB -E -v usb://Brother/TD-4520DN?serial=000A0Z694367 -P /usr/share/cups/model/Brother/brother_td4550dnwb_printer_en.ppd

while true; do sleep 1; done
