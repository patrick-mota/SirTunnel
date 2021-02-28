#!/bin/bash

source .env

localUrl=$1

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

if [ -z $localUrl ]; then
  while true; do
      echo "Enter ip:port or local url of the server (have to be hosted where this script is)"
      read local
      if [ -z $localUrl ]; then
        echo "ip:port or local url can't be empty"
        continue
      fi
  done
fi

echo
echo
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>"
echo
echo "Information used to configure the tunnel"
echo
echo "Local host and port            : " $localUrl
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
ssh -tR $remotePort:$localUrl $remoteSSH /tmp/sirtunnel.py $domain $remotePort


exit;