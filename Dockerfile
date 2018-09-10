FROM centos:7
WORKDIR /home/.provision

#=======================================
# Pritunl Client Dependencies
#=======================================
RUN yum update -y \
    && yum install -y epel-release openvpn \
    && yum clean all

#=======================================
# Pritunl Client
#=======================================
COPY ./*.sh ./
RUN ./bootstrap-pritunl.sh
RUN cat "./run-profile.sh" >> ~/.bashrc

VOLUME /conf/pritunl-profiles

ENTRYPOINT [ "./run-pritunl.sh" ]