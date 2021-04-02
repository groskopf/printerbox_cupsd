docker run -it --rm --name cupsd --network printerbox_network --privileged -v $(pwd)/scripts:/scripts -v /dev:/dev -v /var/run/dbus:/var/run/dbus --entrypoint /scripts/start_cupsd.sh printerbox_cupsd:v1
 
