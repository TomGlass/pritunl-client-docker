FROM debian:11-slim
WORKDIR /home/.provision

#=======================================
# Pritunl Client Dependencies
#=======================================


RUN apt update
RUN apt install dirmngr
RUN tee /etc/apt/sources.list.d/pritunl.list << EOF
deb https://repo.pritunl.com/stable/apt bullseye main
EOF
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
RUN apt update
RUN apt install pritunl-client -y

#=======================================
# Pritunl Client
#=======================================
COPY ./*.sh ./
RUN ./bootstrap-pritunl.sh
RUN cat "./run-profile.sh" >> ~/.bashrc

VOLUME /conf/pritunl-profiles

ENTRYPOINT [ "./run-pritunl.sh" ]
