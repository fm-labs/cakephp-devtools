#!/bin/bash

PHP_VERSION="7.2"

sudo apt install curl
sudo apt install php-curl php-xdebug
sudo apt install php${PHP_VERSION}-cli \
                  php${PHP_VERSION}-fpm \
                  php${PHP_VERSION}-intl  \
                  php${PHP_VERSION}-pdo \
                  php${PHP_VERSION}-pdo-sqlite \
                  php${PHP_VERSION}-mcrypt \
                  php${PHP_VERSION}-mbstring \
                  php${PHP_VERSION}-curl