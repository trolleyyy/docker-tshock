FROM frolvlad/alpine-mono

COPY start.sh /start

RUN adduser -D -u 1000 tshocksrv

RUN mkdir /world /config /logs /plugins /tshock

RUN chown -R tshocksrv /world && \
    chown -R tshocksrv /config && \
    chown -R tshocksrv /logs && \
    chown -R tshocksrv /plugins && \
    chown -R tshocksrv /tshock && \
    chown -R tshocksrv /start

USER tshocksrv

# Add and install mono
ENV TSHOCK_VERSION=4.3.26

RUN cd /tshock && \
    wget https://github.com/NyxStudios/TShock/releases/download/v$TSHOCK_VERSION/tshock_$TSHOCK_VERSION.zip && \
    unzip tshock_$TSHOCK_VERSION.zip && \
    rm tshock_$TSHOCK_VERSION.zip && \
    chmod +x /tshock/TerrariaServer.exe && \
    chmod +x /start

# External data
VOLUME ["/world", "/config", "/logs", "/plugins"]

# Back to the working directory for the server
WORKDIR /tshock

EXPOSE 7777

ENTRYPOINT ["/start"]
