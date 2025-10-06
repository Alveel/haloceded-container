FROM ghcr.io/alveel/lean-wine:main@sha256:20842b1e02bd1d25c57aef1453a32ff13e7b77ae6fc5fe23acb1b2af0181e497

ENV WINEPREFIX=/opt/app-root/.wine \
    WINEDEBUG=-all \
    HOME=/opt/app-root

# Configure app user
RUN useradd -u 1001 -g 0 halo && \
    mkdir -p /opt/app-root/maps \
             /opt/app-root/data \
             /opt/app-root/.cache \
             /opt/app-root/.wine && \
    chown -R 1001:0 /opt/app-root && \
    chmod -R g=u /opt/app-root

# Add Gandanur
USER 1001
ADD GandanurCE-v14.7.0-unrestricted.tar.xz /opt/app-root/

WORKDIR /opt/app-root

# Add entrypoint script
ADD --chmod=755 entrypoint.sh /usr/bin/

# Expose ports to allow connections to the game and RCON
EXPOSE 2302/udp 2303/udp

# Expose used volumes
VOLUME ["/opt/app-root/maps", "/opt/app-root/data"]

# Prepare the Wine environment
RUN winecfg

# Set entrypoint and default command
ENTRYPOINT ["entrypoint.sh"]
CMD ["haloceded"]

