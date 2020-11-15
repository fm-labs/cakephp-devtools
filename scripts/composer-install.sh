#!/bin/sh

# This script is based on the script provided on getcomposer.org .
# https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md
# Last updated: 2020-04-17
PWD=$(pwd)
echo "PWD: $PWD"

echo "Downloading composer installer signature ..."
EXPECTED_CHECKSUM="$(wget -q -O - https://composer.github.io/installer.sig)"

echo "Downloading composer installer ..."
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

echo "Validating checksum ..."
ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]
then
    >&2 echo 'ERROR: Invalid installer checksum'
    rm composer-setup.php
    exit 1
fi

echo "Run composer installer ..."
php composer-setup.php --quiet
RESULT=$?
rm composer-setup.php

if [ $RESULT -eq 0 ]
then
  sudo mv $PWD/composer.phar /usr/local/bin/composer
  echo "Composer has been installed to /usr/local/bin/composer"
else
  echo "Composer installation failed"
fi

exit $RESULT