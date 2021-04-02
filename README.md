# CUPS server with Docker on Raspberry Pi

## Requirements

- Docker installed on a Raspberry Pi

## Installation

### Build

Run a build to create your image :

```bash
docker build -t rpi-cups-v1 .
```

### Configure

Create your own configuration file based on .env.sample.

```bash
mv .env.sample .env
```

Edit this __.env__ file :

```bash
CUPS_IMAGE=<The name of your built image in the first step>
CUPS_USER_ADMIN=<Admin user name for web interface>
CUPS_USER_PASSWORD=<Admin password for web interface>
```

### Run

```bash
docker-compose up -d
```

### Configure CUPS

Go to http://<ip>:631/ to configure your printer.

## Tips

Configuration for OS X : Add a printer by IP address
- Address : IP address of your Docker host
- Protocol : IPP
- Queue : /printers/name_of_your_printer
