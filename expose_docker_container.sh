#!/bin/bash

source .env

containerName=$1

echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>"
echo "Expose your localhost made easy"
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>"

echo
echo
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>"
echo
echo "You can edit the .env file with your information to expose"
echo
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>"
echo

if [ -z $containerName ]; then
  while true; do
      echo "Enter container name"
      read containerName
      if [ -z $containerName ]; then
        echo "Container name can't be empty. Please set containerName in .env file"
        continue
      fi

      container=$(docker port $containerName | cut -d ">" -f 2 | sed --expression='s,0.0.0.0,localhost,g')

      if [[ $container == *"localhost"* ]]; then
         break # Valid input given so exit the loop.
      fi
      echo "Can't find this container. Are you sure it's the right one ?"
      continue
  done
else
  container=$(docker port $containerName | cut -d ">" -f 2 | sed --expression='s,0.0.0.0,localhost,g')
fi

containerFormat="${container:1}"
echo
echo
echo
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>"
echo
echo "Good catch ! I got this from the container : " $containerFormat
echo
read -p "It is correct (y/n)?" choice
case "$choice" in
  y|Y ) echo "yes";;
  n|N ) echo "Expose canceled"; exit;;
  * ) echo "Please answer y or n";;
esac

echo
echo
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>"
echo
echo "Information used to configure the tunnel"
echo
echo "Container name                 : " $containerName
echo "Local host and port            : " $containerFormat
echo "Domain used                    : " $domain
echo "Remote host                    : " $remoteSSH
echo "Remote port                    : " $remotePort
echo
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>"

read -p "It is correct (y/n)?" choice
case "$choice" in
  y|Y ) echo "yes";;
  n|N ) echo "Expose canceled"; exit;;
  * ) echo "Please answer y or n";;
esac

echo "====================================================================="
echo
echo "ALL RIGHT ! LET'S RUUUUN THIS TUNNEEEEEL"
echo
ssh -tR $remotePort:$containerFormat $remoteSSH /tmp/sirtunnel.py $domain $remotePort


exit;