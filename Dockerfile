FROM ubuntu:14.04


## setup system
RUN apt-get -y update \
    && apt-get -y install default-jre wget unzip

ENV JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64/jre"
ENV GEOSERVER_HOME="/opt/geoserver-2.7.2"
EXPOSE 9000:8080


## install geoserver
RUN cd /opt \
    && wget http://sourceforge.net/projects/geoserver/files/GeoServer/2.7.2/geoserver-2.7.2-bin.zip \
    && unzip geoserver-2.7.2-bin.zip


## run geoserver
RUN cd /opt \
    && rm -rf /geoserver-2.7.2-bin.zip \
    && sh /opt/geoserver-2.7.2/bin/startup.sh
