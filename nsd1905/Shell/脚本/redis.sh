#/bin/bash
sed -i '70s/127.0.0.1/192.168.4.58/' /etc/redis/6379.conf
sed -i '93s/6379/6358/' /etc/redis/6379.conf
sed -i '815s/#//' /etc/redis/6379.conf
sed -i '823s/#//' /etc/redis/6379.conf
sed -i '829s/#//' /etc/redis/6379.conf

