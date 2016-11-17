#Here we're going from Ubuntu instead of Alpine, due to Puppet restrictions
FROM ubuntu:16.04
MAINTAINER Ivan Gaas <ivan.gaas@gmail.com>

#First I need some default packages which are missed in default image
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y wget && \
#Then install puppet and needed modules
    wget -q https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb && \
    dpkg -i puppetlabs-release-pc1-xenial.deb && \
    rm -f puppetlabs-release-pc1-xenial.deb && \
    apt-get update && apt-get install -y puppet && \
    puppet module install puppetlabs-tomcat --version 1.6.0 && \
    puppet module install puppet-nginx --version 0.5.0 && \
    puppet module install puppetlabs-java --version 1.6.0 && \
#Clean up
    apt-get clean && rm -rf /var/tmp/* /tmp/*

COPY rootfs /

#Port needs to be exposed to access from node or another containers
EXPOSE 8888

ENTRYPOINT ["/init"]
