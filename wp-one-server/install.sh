#!/bin/bash

# Update system
sudo apt upgrade -y && sudo apt update -y 

# Install  dependencies
sudo apt install php nginx mysql php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip

# Download Wordpress, set config files and move files to designated file.

sudo cd /tmp/

sudo curl -LO https://wordpress.org/latest.tar.gz 

tar xzvf latest.tar.gz

cp /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php

# Copy files to document root

sudo cp -a /tmp/wordpress/. /var/www/wordpress

sudo rm -rf wordpress

# Change ownership of file so nginx can edit
sudo chown -R www-data:www-data /var/www/wordpress

# Add authorized user to group for future edits

sudo usermod -aG www-data $USER
sudo chmod g+rw /var/www/wordpress

# Edit nginx config

# Edit wordpress config file

sudo curl -s https://api.wordpress.org/secret-key/1.1/salt/ | awk -F"'" '{ print $4 }' > secure_keys


# 