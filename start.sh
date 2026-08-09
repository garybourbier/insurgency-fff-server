#!/bin/bash
cd /home/ins
chmod +x srcds_linux
./srcds_linux -game insurgency -strictportbind -ip 0.0.0.0 -port 27015 +clientport 27005 +tv_port 27020 -tickrate 64 +map tell +maxplayers 48 -workshop +sv_pure 1 -nowatchdog -console -usercon +exec insurgency/cfg/insserver.cfg
