FROM ubuntu:14.04


## setup system
RUN apt-get -y update \
    && apt-get -y install default-jre wget unzip supervisor
RUN locale-gen en_GB en_GB.UTF-8

ENV JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64/jre"
ENV GEOSERVER_HOME="/opt/geoserver-2.7.2"

## copy scripts
COPY etc/supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY etc/init.d/* /etc/init.d/
RUN chmod a+x /etc/init.d/tomcat \
    && chmod a+x /etc/init.d/gis


## install apache tomcat
RUN cd /opt \
    && wget http://mirrors.whoishostingthis.com/apache/tomcat/tomcat-7/v7.0.65/bin/apache-tomcat-7.0.65.tar.gz \
    && tar xvfz apache-tomcat-7.0.65.tar.gz

## configure apache tomcat
COPY opt/apache-tomcat-7.0.65/conf/tomcat-users.xml /opt/apache-tomcat-7.0.65/conf/tomcat-users.xml
COPY opt/apache-tomcat-7.0.65/webapps/manager/WEB-INF/web.xml /opt/apache-tomcat-7.0.65/webapps/manager/WEB-INF/web.xml
RUN update-rc.d tomcat defaults \
    && rm -rf /opt/apache-tomcat-7.0.65.tar.gz


## install geoserver
RUN mkdir /opt/geoserver-2.8.0-war \
    && cd /opt/geoserver-2.8.0-war \
    && wget http://freefr.dl.sourceforge.net/project/geoserver/GeoServer/2.8.0/geoserver-2.8.0-war.zip \
    && unzip geoserver-2.8.0-war.zip \
    && cp geoserver.war /opt/apache-tomcat-7.0.65/webapps/

## clean up
RUN update-rc.d gis defaults

## start services
CMD ["/usr/bin/supervisord"]
