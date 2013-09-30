#!/bin/bash
set -e # Exit immediately when something break

pushd /root &> /dev/null
setenforce 0

yum install -y puppet facter tar bind

# Generate the TSIG Key
TSIG_KEY=$(/usr/sbin/dnssec-keygen -a HMAC-MD5 -b 512 -n USER -r /dev/urandom -K /var/named $(hostname -f); cat /var/named/K$(hostname -f).*.key  | awk '{print $8}')

# Add the TSIG Key into configure_origin.pp
sed -i -e "s#TSIG_KEY#$(echo $TSIG_KEY)#" /root/configure_origin.pp

puppet module install openshift/openshift_origin

# Write the class configuration to stdout
cat configure_origin.pp
puppet apply --verbose configure_origin.pp
popd
