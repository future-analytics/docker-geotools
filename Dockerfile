FROM daithi/gis-tools

#RUN apt-get install -y default-jre

ENV JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64/jre"
ENV GEOSERVER_HOME="/opt/geoserver-2.7.2"
EXPOSE 9000:8080
#RUN cd /opt
#RUN rm -rf /geoserver-2.7.2-bin.zip
RUN sh /opt/geoserver-2.7.2/bin/startup.sh

#RUN apt-get -y update
#RUN apt-get install -y wget
#RUN apt-get install -y unzip

#RUN cd /opt
#RUN wget http://sourceforge.net/projects/geoserver/files/GeoServer/2.7.2/geoserver-2.7.2-bin.zip
#RUN unzip geoserver-2.7.2-bin.zip
