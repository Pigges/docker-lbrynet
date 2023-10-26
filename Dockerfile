FROM debian:latest
EXPOSE 5279 5280

RUN apt update && \
    apt install curl unzip -y

WORKDIR /app

RUN curl -OL "https://github.com/lbryio/lbry-sdk/releases/download/v0.113.0/lbrynet-linux.zip"
RUN unzip lbrynet-linux.zip
RUN rm lbrynet-linux.zip

VOLUME /storage
COPY conf/daemon_settings.yml ./
COPY conf/test_daemon_settings.yml ./
COPY conf/regtest_daemon_settings.yml ./

COPY launcher.sh ./launcher.sh
COPY scripts/probe.sh ./probe.sh
RUN chmod +x lbrynet ./*.sh
CMD ["./launcher.sh"]
