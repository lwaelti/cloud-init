#!/bin/bash

apt update
apt upgrade
apt install -y boinc
chmod 777 /etc/boinc-client/gui_rpc_auth.cfg
service boinc-client start
boinccmd --project_attach https://einsteinathome.org. f5fe866540880f6791a60e87f43cd403
