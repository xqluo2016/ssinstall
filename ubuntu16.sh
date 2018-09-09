#!/bin/sh

apt update

apt-get --assume-yes install python3-pip

pip install shadowsocks

IP=$( ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' )
PWD=$(date +%y%m%d)

echo Your PWD is: ${PWD}

cat > /etc/shadowsocks.json <<EOF 
{
   "server":"${IP}",
   "server_port":8443,
   "local_port":0,
   "password":"Ss${PWD}",
   "timeout":600,
   "method":"aes-256-cfb"
}

EOF

ssserver -c /etc/shadowsocks.json -d start 
sed -i '2issserver -c /etc/shadowsocks.json -d start' /etc/rc.local

