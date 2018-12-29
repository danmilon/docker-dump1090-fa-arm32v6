# docker container for flightaware/dump1090 #

This is a docker container for the
[https://github.com/flightaware/dump1090](flightaware/dump1090) software, based
on alpine linux, for the arm32v6 architecture, built for RTLSDR devices.

## How to run ##

    docker run \
	  --rm \
	  -ti \
	  --privileged \
	  danmilon/dump1090-fa-arm32v6:latest \
	  dump1090-fa --interactive

Look at `--help` for the different command line arguments.

Running it as privileged is an easy way to provide access to the USB device,
but of course it's unsecure, and I don't have an alternative at the moment. One
can pass through the USB device file (`/dev/bus/usb/xxx/yyy`) to the container,
but the bus ID the device ends at is non deterministic. It's possible to use
udev rules based on the device serial number, and symlink it to a predictable
path, but then librtlsdr doesn't see it.
