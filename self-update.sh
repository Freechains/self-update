#!/usr/bin/env bash

#Parameters
#1 - Path to create directory
#2 - Machine's IP
#3 - The gateway

#Starting host (same host as specified in the configuration)
freechains host start $1 &
sleep 0.5

#Waiting to receive block with update file and writing in file
freechains --host=$2:$3 chain listen /auto-update > listen-output.txt &

#Waiting to file to be created then reading
sleep 1
exec 3< listen-output.txt

#Looping until "listen" command outputs that it received a packet
while true
do
 if [[ -s listen-output.txt ]]
 then
	read <&3 line;
	break
 fi
done

#Removing file used to read the "listen" command
rm listen-output.txt

#Getting the hash of the last block received
hash=`freechains --host=$2:$3 chain heads accepted /auto-update`

#Getting and decoding file
freechains --host=localhost:8400 chain get /auto-update $hash > new_freechains.blk
jq ".immut.payload" new_freechains.blk | tr -d '"' | base64 --decode > new_freechains.jar

#Stoping host and deleting files
freechains --host=$2:$3 host stop
rm new_freechains.blk

#Copying and installing to correct directories
cp new_freechains.jar /usr/local/bin/Freechains.jar
cp /home/lucas/IdeaProjects/jvm/src/main/make/freechains.sh /usr/local/bin/freechains

#Deleting jar file
rm new_freechains.jar




