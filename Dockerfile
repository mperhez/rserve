# Dockerfile to build image to deploy Rserve
# commands to execute when the image runs as a container
FROM r-base

ENV RSERVE=Rserve_1.7-3.1.tar.gz
ENV RCURL=RCurl_1.95-4.12.tar.gz
ENV RPROTOBUF=RProtoBuf_0.4.14.tar.gz

RUN apt-get update  \
        && apt-get install -y \
        libcurl4-gnutls-dev \
        libxml2-dev \
        libprotobuf-dev \
        libprotoc-dev \
        protobuf-compiler \
        r-cran-rprotobuf \
        dnsutils \
        net-tools \
        netcat \
        && wget https://cran.r-project.org/src/contrib/$RSERVE \
        && wget https://cran.r-project.org/src/contrib/$RCURL \
        && wget https://cran.r-project.org/src/contrib/$RPROTOBUF \
        && R CMD INSTALL $RSERVE $RCURL $RPROTOBUF \
        && rm $RSERVE $RCURL $RPROTOBUF \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* \
        && mkdir -p /rscripts
VOLUME /rscripts
WORKDIR /rscripts
CMD ["Rscript", "start.R"]

EXPOSE 6311
