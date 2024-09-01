#Pulling java image from docker
FROM openjdk:17-jdk-buster

LABEL version="1.18.2"

#setting up user and data folder
RUN apt-get update && apt-get install -y curl dos2unix && \
 addgroup minecraft && \
 adduser --home /server --ingroup minecraft --disabled-password minecraft

#copying launch.sh to container and prepping for exec
COPY launch.sh /launch.sh
RUN dos2unix /launch.sh
RUN chmod +x /launch.sh

# Copy fresh version of the server to the persistent storage ./server
COPY --chown=minecraft:minecraft server /server
RUN dos2unix /server/start.sh
RUN chmod +x /server/start.sh

USER minecraft

#VOLUME ./backup:/backup
#VOLUME ./world:/server/world

WORKDIR /server

EXPOSE 25565/tcp

CMD ["/launch.sh"]

# ENV EULA "true"
# ENV OPS 
#ENV MOTD "Vault Hunters 1.18.2-alpha-0.0.1 Modded Minecraft Server Powered by Docker"

# default
# ENV LEVEL "VH3" 
#  loads Iskall's pre-generated world
# ENV LEVEL "Iskall-world"

# ENV GAMEMODE "survival"

# ENV DIFFICULTY "normal"

# Start with 2G of ram expandable to 6G
# ENV JVM_OPTS "-Xms2g -Xmx6g"
