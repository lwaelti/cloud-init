#!/bin/bash

sudo apt update
sudo apt upgrade
sudo apt install -y boinc
sudo usermod -a -G boinc $USER
exec su $USER
boinccmd --project_attach https://einsteinathome.org. f5fe866540880f6791a60e87f43cd403
