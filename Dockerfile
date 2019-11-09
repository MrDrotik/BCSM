 
FROM ubuntu:18.04

WORKDIR /app

RUN apt-get update && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
        locales \
        curl \
        libgl1-mesa-dri:i386 \
        libgl1-mesa-glx:i386 \
        libgtk2.0-0:i386 \
        libnss3:i386 \
        libfontconfig1:i386 \
        libopenal1:i386

ADD https://launchpadlibrarian.net/201289903/libgcrypt11_1.5.3-2ubuntu4.2_i386.deb \
        /var/cache/apt/archives/libgcrypt11_1.5.3-2ubuntu4.2_i386.deb 
ADD http://fr.archive.ubuntu.com/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_i386.deb \
        /var/cache/apt/archives/libpng12-0_1.2.54-1ubuntu1_i386.deb
RUN curl -sL -o/app/Counter-Strike.tar.gz \
        ftp://ftp.counter-strike.com.ua/Linux/Counter-Strike.tar.gz

RUN dpkg -i /var/cache/apt/archives/libgcrypt11_1.5.3-2ubuntu4.2_i386.deb && \
    dpkg -i /var/cache/apt/archives/libpng12-0_1.2.54-1ubuntu1_i386.deb

RUN tar -zxvf Counter-Strike.tar.gz && \
    cd ./Counter-Strike && \
    mkdir /root/.config && \
    mkdir -p mkdir -p /root/.local/share/applications && \
    mkdir -p ~/.local/share/applications && \
    touch /root/.config/user-dirs.dirs && \
    locale-gen en_US.UTF-8 && \
    update-locale

ADD https://raw.githubusercontent.com/MrDrotik/BCSM/master/Install.sh \
        /app/Counter-Strike/Install.sh
ADD https://raw.githubusercontent.com/MrDrotik/BCSM/master/langchanger.sh \
        /app/Counter-Strike/langchanger.sh
ADD https://raw.githubusercontent.com/MrDrotik/BCSM/master/MasterServers.vdf \
        /app/Counter-Strike/platform/config/MasterServers.vdf

WORKDIR /app/Counter-Strike/

RUN chmod +x ./Install.sh && \
    ./Install.sh

CMD ["/app/Counter-Strike/cstrike.sh"]
