# docker-geotools

Installs and sets up:
 - Apache Tomcat 7.0.65
 - Geoserver 2.8.0

To build:
```bash
docker build -t "daithi/gis-tools" .
```

To run:
```bash
docker run -it -p 8005:8080 -d daithi/gis-tools
```

Browse to: http://localhost:8005

#### n.b.
On first run it may take a few minutes as the `geoserver.war` file needs to be
unpacked for tomcat. Once http://localhost:8005 has loaded then you can access
geoserver at: http://localhost:8005/geoserver/web/
