FROM rouhim/steamcmd-wine:latest
USER $USER

ENV STEAM_APP_ID "2465200"
ENV STARTUP_COMMAND "wine SonsOfTheForestDS.exe -userdatapath $SERVER_CONFIG_DIR"

# Game port
EXPOSE 8766/udp
# Query port
EXPOSE 27016/udp
# Blobsync port
EXPOSE 9700/udp

COPY pre.sh $USER_HOME/pre.sh