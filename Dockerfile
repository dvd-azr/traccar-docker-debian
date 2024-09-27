# https://github.com/traccar/traccar-docker/blob/master/Dockerfile.debian
FROM debian:12-slim

ENV TRACCAR_VERSION 6.5

WORKDIR /opt/traccar

RUN set -ex; \
  apt-get update; \
  TERM=xterm DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends \
  openjdk-17-jre-headless \
  apt-get autoremove --yes \
  apt-get clean; \
  rm -rf /var/lib/apt/lists/* /tmp/*

# REF : https://github.com/traccar/traccar-docker#readme

# Copy the configuration file from the host to the container
# Make sure you have traccar.xml in the same directory as your Dockerfile
# COPY traccar.xml /opt/traccar/conf/traccar.xml
COPY . .
# Expose the necessary ports
EXPOSE 80 5000-5150
# Set the entrypoint for the container
ENTRYPOINT ["java", "-Xms1g", "-Xmx1g", "-Djava.net.preferIPv4Stack=true", "-jar", "/opt/traccar/tracker-server.jar", "/opt/traccar/conf/traccar.xml"]

# 
# ENTRYPOINT ["java", "-Xms1g", "-Xmx1g", "-Djava.net.preferIPv4Stack=true"]

# CMD ["-jar", "tracker-server.jar", "conf/traccar.xml"]
