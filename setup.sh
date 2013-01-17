#!/bin/bash
cd $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
apt-get -y install bind9

if [ ! -e /etc/bind/named.conf.log ]; then
        cp named.conf.log /etc/bind/named.conf.log
else
        echo "named.conf.log already exists. overwrite? (y/n)"
        read overwrite
        if [ "$overwrite" = "y" ]; then
                cp named.conf.log /etc/bind/named.conf.log
        fi
fi


mkdir /etc/bind/zones
chown -R bind:bind /etc/bind/zones
mkdir /var/log/bind
cd /var/log/bind

touch bind.log queries.log security_info.log update_debug.log
chown -R bind:bind /var/log/bind

if ! grep -q named.conf.log /etc/bind/named.conf; then
        echo 'include "/etc/bind/named.conf.log";' >> /etc/bind/named.conf
else
        echo "named.conf.log already in named.conf"
fi
