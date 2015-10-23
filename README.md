# docker-geotools

Installs and sets up:
 - Apache Tomcat 7.0.65
 - Geoserver 2.8.0
 - Geonetwork 3.0.2

To build:
```bash
docker build -t "daithi/gis-tools" .
```

To run:
```bash
docker run -it -p 8005:8080 -d daithi/gis-tools
```
It can take a while for tomcat and the gis tools to start up. On one machine I
have to wait up to .
5 mins. To check the status of Tomcat, do the following:
```bash
docker exec -it $container_hash bash
$container_hash$# tail -f /opt/apache-tomcat-7.0.65/logs/*.log
```
Browse to: http://localhost:8005

#### n.b.
On first run it may take a few minutes as the `geoserver.war` file needs to be
unpacked for tomcat. Once http://localhost:8005 has loaded then you can access
geoserver at: http://localhost:8005/geoserver/web/
