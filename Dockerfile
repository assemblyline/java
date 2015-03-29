FROM quay.io/assemblyline/ubuntu:14.04.2

ENV JAVA_HOME=/usr/lib/jvm/java-8-oracle
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list \
 && echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list \
 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 \
 && apt-get update \
 && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
 && apt-get install -y oracle-java8-installer \
 && printf "path-exclude /usr/share/doc/*\npath-exclude /usr/share/man/*\npath-exclude /usr/share/info/*\npath-exclude /usr/share/lintian/*" >> /etc/dpkg/dpkg.cfg.d/nodoc \
 && cd /usr/share && rm -fr doc/* man/* info/* lintian/* \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /var/cache/* \
 && truncate -s 0 /var/log/*log
