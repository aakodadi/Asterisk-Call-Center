#!/bin/bash

echo "Updating the system"
apt-get --yes --force-yes update

echo "Upgading the system"
apt-get --yes --force-yes upgrade

echo "Downloading and installing dependencies"
apt-get --yes --force-yes install build-essential libxml2-dev libncurses5-dev linux-headers-`uname -r` libsqlite3-dev libssl-dev libmysqlclient15-dev libmysql++-dev libmysqld-dev

#echo "Downloading and installing apache2"
#apt-get --yes --force-yes install apache2 apache2-doc

#echo "Downloading and installing php5 modules"
#apt-get --yes --force-yes install libapache2-mod-php5 php5 php5-common php5-curl php5-dev php5-gd php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-mysql php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl

echo "Compiling and installing asterisk-11.7.0 + MySQL Addons"
cd certified-asterisk-1.8.15-cert5/
./configure
make menuselect.makeopts
menuselect/menuselect --enable app_mysql --enable cdr_mysql --enable res_config_mysql menuselect.makeopts
make
make install
make samples
make config
cd ..

cd config_files/
cp http.conf /etc/asterisk/
cp manager.conf /etc/asterisk/
cp extensions.conf /etc/asterisk/
cp agents.conf /etc/asterisk/
cp queues.conf /etc/asterisk/
cp users.conf /etc/asterisk/ 
cd ..

#echo "Compiling and installing asterisk-gui"
cd asterisk-gui/
./configure
make
make install
make checkconfig
cd ..

echo "Thank you for choosing asterisk-call-center"
echo "Asterisk-call-center is now installed and ready to be used ..."
