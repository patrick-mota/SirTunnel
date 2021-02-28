# Pre-requisites

### Configure your vars in .env

#### Define your server where you will ssh to install the the proxy
You can include the username like user@host
```
remoteSSH=user@host
```

#### Port where the tunnel runs in remote host (49171 is open in my remote server but you can set any open port not used)
```
remotePort=49171
```

#### The domain needs to redirect to the remotesshhost (the server where the proxy is installed)
```
domain=example.com
```
### Redirect your domain name to the server
Your domain example.com has to redirect to your remote server.

## Install and launch server

Git clone this repo where your website is (like in your laptop)

After doing the pre-requisites you can launch the install.

The install will ssh to the remote server and install the tunnel.

Don't hesitate to see the scripts, there is nothing fancy and it's easy to understand.

1. Launch install
```
    ./install_remote.sh
```
2. Expose your docker container
   ```
    ./expose_docker_container.sh containername
   ```

or

2. Expose your localhost hosted website
   ```
    ./expose_local.sh localhost:port
   ```
   
---------

If you have docker and want to try it fast
1.
```
docker run -d -p 49171:80 --name=whoami containous/whoami
```
2.
```
./expose_docker_container.sh containername
```
or
2.
```
./expose_local.sh localhost:49171
```
