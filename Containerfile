FROM quay.io/archlinux/archlinux

# Configure pacman to allow lib32 (required for Wine) and install required packages
RUN echo -e '\n[multilib]\nInclude = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf && \
    pacman-key --init && \
    pacman-key --populate archlinux && \
    pacman -Syu --quiet --noconfirm wine lib32-gnutls xorg-server-xvfb && \
    pacman -Scc --quiet --noconfirm

# Configure app user
RUN useradd -r -u 1001 -g 0 halo && \
    mkdir -p /opt/app-root/{maps,logs,data,.wine} && \
    chown -R 1001:0 /opt/app-root && \
    chmod -R g=u /opt/app-root

ENV WINEPREFIX=/opt/app-root/.wine \
    WINEARCH=win32 \
    WINEDEBUG=-all

# Add Gandanur
ADD GandanurCE-v14.7.0-unrestricted.tar.xz /opt/app-root/
USER 1001
WORKDIR /opt/app-root

# Add entrypoint script
ADD --chmod=755 entrypoint.sh /usr/bin/

# Expose ports to allow connections to the game and RCON
EXPOSE 2302/udp 2303/udp

# Expose used volumes
VOLUME ["/opt/app-root/maps", "/opt/app-root/logs", "/opt/app-root/data"]

# Set entrypoint and default command
ENTRYPOINT ["entrypoint.sh"]
CMD ["haloceded"]

