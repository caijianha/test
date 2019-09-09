#/bin/bash
read -p "请输入自己的IP :" a
rm -rf /root/Zabbix/php-*
yum -y install gcc pcre-devel openssl-devel
tar -xf Zabbix/nginx-1.12.2.tar.gz
useradd -s /sbin/nologin nginx
cd nginx-1.12.2/
./configure --user=nginx --group=nginx --with-http_ssl_module --with-stream --with-http_stub_status_module
make && make install
sed -i '20a fastcgi_buffers 8 16k; fastcgi_buffer_size 32k; fastcgi_connect_timeout 300; fastcgi_send_timeout 300; fastcgi_read_timeout 300;' /usr/local/nginx/conf/nginx.conf
sed -i '66,72s/#//' /usr/local/nginx/conf/nginx.conf
sed -i '70d' /usr/local/nginx/conf/nginx.conf
sed -i '70s/fastcgi_params/fastcgi.conf/' /usr/local/nginx/conf/nginx.conf

cp /root/Zabbix/libevent-devel-2.0.21-4.el7.x86_64.rpm /root/
cd /root/
yum -y install php php-mysql mariadb mariadb-devel mariadb-server.x86_64 php-fpm
yum -y install  libevent-devel-2.0.21-4.el7.x86_64.rpm
systemctl start mariadb
systemctl start php-fpm
/usr/local/nginx/sbin/nginx
yum -y install net-snmp-devel curl-devel 
tar -xf /root/Zabbix/zabbix-3.4.4.tar.gz -C /root/
cd /root/zabbix-3.4.4/
./configure --enable-server --enable-proxy --enable-agent --with-mysql=/usr/bin/mysql_config --with-net-snmp --with-libcurl
make install
mysql -uroot -e "create database zabbix character set utf8"
mysql -uroot -e "grant all on zabbix.* to zabbix@'localhost' identified by 'zabbix'"
cd /root/zabbix-3.4.4/database/mysql/
mysql -uzabbix -pzabbix zabbix < schema.sql
mysql -uzabbix -pzabbix zabbix < images.sql
mysql -uzabbix -pzabbix zabbix < data.sql
cp -r /root/zabbix-3.4.4/frontends/php/* /usr/local/nginx/html/
chmod -R 777 /usr/local/nginx/html/*
sed -i '85s/# //' /usr/local/etc/zabbix_server.conf
sed -i '119s/# DBPassword=/DBPassword=zabbix/' /usr/local/etc/zabbix_server.conf
useradd -s /sbin/nologin zabbix
zabbix_server 
sed -i "93s/$/,$a/" /usr/local/etc/zabbix_agentd.conf
sed -i "134s/$/,$a/" /usr/local/etc/zabbix_agentd.conf
sed -i '280s/# UnsafeUserParameters=0/UnsafeUserParameters=1/' /usr/local/etc/zabbix_agentd.conf
zabbix_agentd 
yum -y install php-gd php-xml php-bcmath.x86_64 php-mbstring.x86_64  php-ldap.x86_64 
sed -i '878s/;date.timezone =/date.timezone = Asia\/Shanghai/' /etc/php.ini
sed -i '384s/30/300/' /etc/php.ini
sed -i '394s/60/300/' /etc/php.ini
sed -i '672s/8M/32M/' /etc/php.ini

systemctl restart php-fpm

