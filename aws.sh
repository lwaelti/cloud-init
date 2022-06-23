#!/bin/bash

apt update
apt upgrade
apt install -y boinc
usermod -a -G boinc $USER
exec su $USER
boinccmd --project_attach https://einsteinathome.org. f5fe866540880f6791a60e87f43cd403
