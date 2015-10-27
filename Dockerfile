FROM ubuntu:14.04
MAINTAINER daithi coombes <daithi.coombes@futureanalytics.ie>

## setup system
RUN apt-get -y update \
    && apt-get -y install default-jre wget unzip supervisor
RUN locale-gen en_GB en_GB.UTF-8

ENV TERM=xterm
ENV JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64/jre"
ENV JAVA_OPTS=" -Xmx1024M -XX:MaxPermSize=256M"
ENV GEOSERVER_HOME="/opt/geoserver-2.7.2"


## install apache tomcat
RUN cd /opt \
    && wget http://mirrors.whoishostingthis.com/apache/tomcat/tomcat-7/v7.0.65/bin/apache-tomcat-7.0.65.tar.gz \
    && tar xvfz apache-tomcat-7.0.65.tar.gz

## configure apache tomcat
COPY opt/apache-tomcat-7.0.65/conf/tomcat-users.xml /opt/apache-tomcat-7.0.65/conf/tomcat-users.xml
COPY opt/apache-tomcat-7.0.65/webapps/manager/WEB-INF/web.xml /opt/apache-tomcat-7.0.65/webapps/manager/WEB-INF/web.xml
RUN rm -rf /opt/apache-tomcat-7.0.65.tar.gz


## install geoserver
RUN mkdir /opt/geoserver-2.8.0-war \
    && cd /opt/geoserver-2.8.0-war \
    && wget http://freefr.dl.sourceforge.net/project/geoserver/GeoServer/2.8.0/geoserver-2.8.0-war.zip \
    && unzip geoserver-2.8.0-war.zip \
    && cp geoserver.war /opt/apache-tomcat-7.0.65/webapps/


## install geonetwork
RUN mkdir /opt/geonetwork-3.0.2-war \
    && cd /opt/geonetwork-3.0.2-war \
    && wget http://downloads.sourceforge.net/project/geonetwork/GeoNetwork_opensource/v3.0.2/geonetwork.war \
    && cp geonetwork.war /opt/apache-tomcat-7.0.65/webapps/


## install ruby
RUN apt-get -y install curl nodejs npm \
    && cp -a /usr/bin/nodejs /usr/bin/node \
    && gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN /bin/bash -l -c "curl -sSL https://get.rvm.io | bash -s stable --ruby"

RUN /bin/bash -c "source /usr/local/rvm/scripts/rvm" \
    /bin/bash -l -c rvm install ruby-2.1.5 \
    && apt-get -y install ruby-bundler


## install scholarslab geoportal
ENV QMAKE=/usr/bin/qmake
RUN cd /opt \
    && wget https://github.com/future-analytics/geoportal/archive/master.zip \
    && unzip master.zip \
    && cd geoportal-master \
    && apt-get -y install qt4-qmake libqtwebkit-dev\
    && bundle install \
    && npm install


## setup supervisord
COPY etc/supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/lock/gis /var/run/gis /var/log/supervisor

## start services
CMD ["/usr/bin/supervisord"]
WORKDIR /opt
