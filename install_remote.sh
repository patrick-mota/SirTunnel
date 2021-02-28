#!/bin/bash

source .env

remoteSSH=$1

if [ -z $remoteSSH ]; then
  while true; do
      echo "Enter the hostname or ip where you will configure the proxy (the server which is reachable from anywhere)"
      read $remoteSSH
      if [ -z $remoteSSH ]; then
        echo "Hostname can't be empty"
        continue
      fi
  done
fi

scp -r ./* $remoteSSH:/tmp/  && ssh -t $remoteSSH "cd /tmp/ && ./install.sh && ./run_server.sh"