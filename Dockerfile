# docker run -dt -p 8112:8112 pluribuslabs/centos7-youtrack-server

FROM pluribuslabs/centos7-oracle-jdk-7

MAINTAINER Pluribus Labs Docker Dev <docker-dev@pluribuslabs.com>

RUN yum -y install wget hostname
ENV YOUTRACK_PACKAGE youtrack-6.5.16853.zip
ENV YOUTRACK_DOWNLOAD http://download-cf.jetbrains.com/charisma
ENV YOUTRACK_PORT 8080

RUN wget -nv $YOUTRACK_DOWNLOAD/$YOUTRACK_PACKAGE
RUN unzip $YOUTRACK_PACKAGE -d /opt/youtrack &&\
   rm $YOUTRACK_PACKAGE
EXPOSE $YOUTRACK_PORT

# Looks like ENV variables don't get subbed in the CMD command hence the hardcode
# from https://confluence.jetbrains.com/display/YTD6/YouTrack+JAR+as+a+Service+on+Linux
CMD ["/opt/youtrack/bin/youtrack.sh", "run"]
