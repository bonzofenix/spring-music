FROM tomcat
MAINTAINER bonzofenix <bonzofenix@gmail.com>

COPY build/libs/spring-music.war /usr/local/tomcat/webapps/spring-music.war

# For vcap user to be able to run the catalina.sh startup command.
RUN chmod -R 0777 /usr/local/tomcat/

# Set default PORT env for non garden-linux installations
ENV PORT 8080

# The following line is intended to be use for Diego on Garden-linux as a docker container. Please remove if you intend to deploy only to Docker.
CMD sed "s/8080/$PORT/g" < /usr/local/tomcat/conf/server.xml > /tmp/server.xml && catalina.sh run -config /tmp/server.xml
