FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    lib32gcc-s1 \
    curl \
    ca-certificates \
    screen \
    procps \
    net-tools \
    libtcmalloc-minimal4 \
    libncurses6 \
    libcurl4 \
    libstdc++6 \
    lib32z1 \
    lib32stdc++6 \
    bash \
    && rm -rf /var/lib/apt/lists/*

RUN (getent passwd 1000 | cut -d: -f1 | xargs userdel 2>/dev/null || true) && \
    useradd -u 1000 -m steam

COPY --chown=steam:steam entrypoint.sh /home/steam/entrypoint.sh

USER steam
RUN chmod +x /home/steam/entrypoint.sh

ENTRYPOINT ["/home/steam/entrypoint.sh"]
