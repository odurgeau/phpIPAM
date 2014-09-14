#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

aptitude clean
aptitude update
aptitude -y safe-upgrade

apt-get install -y apache2 mysql-server php5 php5-gmp php-pear php5-mysql php5-ldap
rm -f /var/www/index.html

wget http://downloads.sourceforge.net/project/phpipam/phpipam-1.0.tar -O /tmp/phpipam-1.0.tar
tar xf /tmp/phpipam-1.0.tar --strip-components 1 -C /var/www/

rm -rf /var/www/install/
cp  /vagrant/config.php  /var/www/
mysql -u root -e "CREATE DATABASE phpipam;"
mysql -u root phpipam  < /var/www/db/SCHEMA.sql 

chown -R www-data: /var/www/
chmod go-rwx /var/www/config.php

a2enmod rewrite
cp /vagrant/default /etc/apache2/sites-available/default
service apache2 restart
