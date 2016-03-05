Liferay 6.2.5 GA6 on Tomcat with mysql DB (two containers)
==========================================================

Image available in docker registry: https://hub.docker.com/r/oazapater/docker-liferay/

## Pulling:

```
docker pull oazapater/docker-liferay
```

## Launching using "docker run":

```
# Run mysql:
docker run --name lep-db -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -e MYSQL_USER=liferay -e MYSQL_PASSWORD=liferay -e MYSQL_DATABASE=lportal $@ -d mysql:latest
# To enable remote connection add option:
#     -p 3306:3306

# Run liferay:
docker run --name lep-as -p 80:8080 -p 443:8443 --link lep-db -d oazapater/docker-liferay
# To enable development mode add options (includes SSH daemon + JMX monitoring + dt_socket debugging) add options:
#     -e LIFERAY_DEBUG=1 -p 2222:22 -p 1099:1099 -p 8999:8999
# If docker daemon does not run on localhost (e.g.: VirtualBox), JMX monitoring needs option: 
#     -e VM_HOST=<docker daemon hostname>
# To mount liferay deploy directory locally add: 
#     -v /absolute/path/to/local/folder:/var/liferay/deploy
```

## Use:

Point browser to docker machine ip (port 80 or port 443)
