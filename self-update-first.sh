#!/usr/bin/env bash

#Parameters
#1 - Path to create directory
#2 - Machine's IP
#3 - The gateway

#Creating host
freechains host create $1 $3

#Starting host
freechains host start $1 &
sleep 0.5

#Public key
PUB=CAE42DD5718C0DC900025878469C3DF86D83580FCC11D0B5FC0908727B97D84D

#Subscribing to auto-update chain
freechains --host=$2:$3 chain join /auto-update $PUB 

#Stopping host
freechains --host=$2:$3 host stop

