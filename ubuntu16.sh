#!/bin/sh

apt update

apt-get install python3-pip

pip install shadowsocks

IP=$( ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' )

cat > /etc/shadowsocks.json <<EOF 
{
   "server":"${IP}",
   "server_port":8443,
   "local_port":0,
   "password":"shadow18",
   "timeout":600,
   "method":"aes-256-cfb"
}

EOF

ssserver -c /etc/shadowsocks.json -d start 
