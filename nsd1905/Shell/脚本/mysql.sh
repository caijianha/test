#!/bin/bash
tar -xf mysql/mysql-5.7.17.tar
yum -y install mysql-community*
systemctl restart mysqld
systemctl enable mysqld
a=`grep "password is generated" /var/log/mysqld.log  | awk '{print $11}'`
mysql -uroot --connect-expired-password  -p"$a" -e "alter user root@localhost identified by '123qqq...A'"
b=123qqq...A
mysql -uroot  -p"$b" -e "set global validate_password_policy=0;"
mysql -uroot -p"$b" -e "set global validate_password_length=6;"
mysql -uroot -p"$b" -e "alter user root@"localhost" identified by '123456';"

