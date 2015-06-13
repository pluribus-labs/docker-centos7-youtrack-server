# Dockerfile for YouTrack server

FROM pluribuslabs/centos7-oracle-jdk-7

MAINTAINER Test <marty.kuhrt@pluribuslabs.com>

RUN yum -y install wget
ENV YOUTRACK_PACKAGE youtrack-6.0.12634.jar
ENV YOUTRACK_DOWNLOAD http://download-cf.jetbrains.com/charisma
ENV YOUTRACK_PORT 8112

RUN wget -nv $YOUTRACK_DOWNLOAD/$YOUTRACK_PACKAGE

EXPOSE $YOUTRACK_PORT

# Looks like ENV variables don't get subbed in the CMD command hence the hardcode

CMD java -Xmx1g -XX:MaxPermSize=250M -Djava.awt.headless=true -jar youtrack-6.0.12634.jar 8112
