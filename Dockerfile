FROM mattdm/fedora:f19
MAINTAINER mfojtik

WORKDIR /root

ADD configure_origin.pp /root/configure_origin.pp
ADD build_script.sh /root/build_script.sh

RUN sh build_script.sh

EXPOSE 22,80,8080,443
