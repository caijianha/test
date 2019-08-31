#!/bin/bash
yum -y install gcc pcre-devel openssl-devel 
 useradd -s /sbin/nologin nginx
cd lnmp_soft/
cp nginx-1.12.2.tar.gz /root/
tar -xf nginx-1.12.2.tar.gz
cd nginx-1.12.2/
./configure --user=nginx --group=nginx --with-http_ssl_module --with-stream --with-http_stub_status_module
make && make install
