#!/bin/bash

PHP_VERSION=$1

if [[ -z ${PHP_VERSION} ]]; then
   echo "No php version selected. Selecting/ PHP version 7.4 by default"
   PHP_VERSION="7.4"
fi

# Basic
sudo apt install -y php${PHP_VERSION}-cli \
                  php${PHP_VERSION}-common \
                  php${PHP_VERSION}-intl \
                  php${PHP_VERSION}-mysql \
                  php${PHP_VERSION}-pdo \
                  php${PHP_VERSION}-sqlite3 \
                  php${PHP_VERSION}-xml \
                  php${PHP_VERSION}-xsl \
                  php${PHP_VERSION}-simplexml \
                  php${PHP_VERSION}-dom \
                  php${PHP_VERSION}-mbstring \
                  php${PHP_VERSION}-json \
                  php${PHP_VERSION}-soap

# Image processing
sudo apt install -y php${PHP_VERSION}-gd

# Curl
sudo apt install -y curl php-curl php${PHP_VERSION}-curl

# Xdebug
sudo apt install -y php-xdebug

exit 0
