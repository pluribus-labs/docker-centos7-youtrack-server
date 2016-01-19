# docker run -dt -p 8112:8112 pluribuslabs/centos7-youtrack-server

FROM pluribuslabs/centos7-oracle-jdk-7

MAINTAINER Pluribus Labs Docker Dev <docker-dev@pluribuslabs.com>

#Youtrack data stored in a volume to help with container upgrade

VOLUME ["/data/youtrack"]
VOLUME ["/opt/youtrack/conf"]
ENV YOUTRACK_DATA_PATH /data/youtrack

ENV APP_VERSION 6.5
ENV APP_REVISION 17015
ENV APP_BUILD $APP_VERSION.$APP_REVISION
ENV YOUTRACK_PACKAGE youtrack-$APP_BUILD.zip
ENV YOUTRACK_DOWNLOAD https://download.jetbrains.com/charisma
ENV YOUTRACK_PORT 8080

youtrack-6.5.17015.zip

RUN yum -y install wget hostname unzip

RUN mkdir -p /opt/youtrack
RUN wget -nv --output-document=youtrack.zip $YOUTRACK_DOWNLOAD/$YOUTRACK_PACKAGE.zip
RUN unzip youtrack.zip -d /opt/youtrack &&\
  rm youtrack.zip

EXPOSE $YOUTRACK_PORT

# Looks like ENV variables don't get subbed in the CMD command hence the hardcode
# from https://confluence.jetbrains.com/display/YTD6/YouTrack+JAR+as+a+Service+on+Linux
CMD ["/opt/youtrack/bin/youtrack.sh", "run"]
