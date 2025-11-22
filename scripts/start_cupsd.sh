#!/bin/sh
set -ex

# Ensure CUPS runtime directory exists
mkdir -p /run/cups

echo "Waiting for Brother TD-4550DNWB..."
# Wait for USB printer to appear
while true; do
    serial=$(lsusb -v -d 04f9:20b9 2>/dev/null | grep iSerial | awk '{print $3}' || true)
    if [ -n "$serial" ]; then
        echo "Found printer with serial: $serial"
        break
    fi
    sleep 1
done

# Start cupsd in background so lpadmin can configure the printer
/usr/sbin/cupsd &
CUPSD_PID=$!

# Wait for CUPS socket to be available
while [ ! -S /run/cups/cups.sock ]; do
    sleep 0.5
done

# Add printer (driverless)
#lpadmin -p TD4550DNWB -E -v "usb://Brother/TD-4520DN?serial=$serial" -m everywhere || true
lpadmin -p TD4550DNWB -E -v usb://Brother/TD-4520DN?serial=${serial} -P /etc/cups/ppd/TD4550DNWB.ppd


lpstat +a

# Set default printer
lpoptions -d TD4550DNWB || true

# Cancel any pending jobs
cancel -a || true

set +x

# Wait for cupsd to stop
CUPSD_PID=$(cat /var/run/cups/cupsd.pid)
while [ -d "/proc/${CUPSD_PID}" ]; do sleep 1; done

