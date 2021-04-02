FROM balenalib/raspberry-pi-debian:latest

ENV UDEV=1

RUN apt-get update && apt-get install -y \
    sudo \
    vim-tiny \
    whois \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    cups \
    cups-bsd \
    cups-client \
    cups-filters \
    python-cups \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

#VOLUME /etc/cups/
VOLUME /var/log/cups
VOLUME /var/spool/cups
VOLUME /var/cache/cups

# Configure the service's to be reachable
RUN /usr/sbin/cupsd \
  && while [ ! -f /var/run/cups/cupsd.pid ]; do sleep 1; done \
  && cupsctl --remote-admin --remote-any --share-printers \
  && kill $(cat /var/run/cups/cupsd.pid)

# Patch the default configuration file to only enable encryption if requested
RUN sed -e '0,/^</s//DefaultEncryption IfRequested\n&/' -i /etc/cups/cupsd.conf

# Path config files
RUN echo 'FileDevice Yes' >> /etc/cups/cups-files.conf
RUN sed -i 's/Listen localhost:631/Listen 0.0.0.0:631/' /etc/cups/cupsd.conf && \
    sed -i 's/<Location \/>/<Location \/>\n  Allow All/' /etc/cups/cupsd.conf && \
    sed -i 's/<Location \/admin>/<Location \/admin>\n  Allow All/' /etc/cups/cupsd.conf && \
    echo 'DefaultEncryption Never' >> /etc/cups/cupsd.conf && \
    echo 'ServerAlias *' >> /etc/cups/cupsd.conf

ENV CUPS_USER_ADMIN pi
ENV CUPS_USER_PASSWORD pi

# Test label
ADD label.pdf label.pdf

# Start script
#ENTRYPOINT /scripts/start_cupsd.sh
#ENTRYPOINT /bin/bash
