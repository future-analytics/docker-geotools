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
docker run -it -p 8000:4567 -p 8001:8080 -d daithi/gis-tools
```
Then for the geoportal goto: [http://localhost:8000](http://localhost:8000) and
for tomcat, geoserver and geonetwork goto:
[http://localhost:8001](http://localhost:8001).

<b>n.b.</b> It can take a while for tomcat and the gis tools to start up. On
one machine I have to wait up to 5 mins for tomcat, geoserver and geonetwork

```bash
docker exec -it $container_hash bash
$container_hash$# tail -f /opt/apache-tomcat-7.0.65/logs/*.log
