#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

aptitude clean
aptitude update
aptitude -y safe-upgrade

apt-get install -y apache2 mysql-server php5 php5-gmp php-pear php5-mysql php5-ldap
rm -f /var/www/index.html

wget https://sourceforge.net/projects/phpipam/files/phpipam-1.2.1.tar/download -O /tmp/phpipam-1.2.1.tar
tar xf /tmp/phpipam-1.2.1.tar --strip-components 1 -C /var/www/
mv /var/www/config.dist.php /var/www/config.php

rm -rf /var/www/install/
mysql -u root -e "CREATE DATABASE phpipam;"
mysql -u root phpipam  < /var/www/db/SCHEMA.sql
mysql -u root  -e "grant ALL on phpipam.* to phpipam@localhost identified by 'phpipamadmin';"
service mysql restart

chown -R www-data: /var/www/

a2enmod rewrite
sed -i s/None/All/g /etc/apache2/sites-available/default
service apache2 reload
