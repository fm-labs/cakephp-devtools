# CakePHP devtools

Bundle of common CakePHP developer tools.

The goal is to have a reusable build-environment for CakePHP applications and CakePHP plugins following CakePHP's philosophy of
 'convention-over-configuration'.
 
This package is primarily a composer meta-package for common (Cake)PHP developer tools, like
PHPUnit, phpcs, phpcbf, phpmd, phpcpd, phpstan.

Instead of adding (and maintaining) all dev dependencies in each CakePHP project,
this package bundles the dev tools and some helper scripts in a single meta package.

## Installation

```
 # In your CakePHP project directory

 composer config minimum-stability dev
 composer config prefer-stable 1
 composer require --dev fm-labs/cakephp-devtools dev-master
```

## Usage

```
 $ ./vendor/bin/cakedev [BUILD-TARGET]
 
 // Examples
 // List available build targets
 $ ./vendor/bin/cakedev list

 // Run PHPUnit
 $ ./vendor/bin/cakedev phpunit

 // Run PHPUnit without coverage
 $ ./vendor/bin/cakedev phpunit-no-coverage
 
 // Run PHPStan
 $ ./vendor/bin/cakedev phpstan

 // ... see full build target list below ...
``` 

Under the hood all build targets will be executed using `phing` .
The phing configuration file is located at `configs/phing.xml` .

```
 // Phing command
 $ ./vendor/bin/phing -Dbasedir=$(pwd) -f ./vendor/fm-labs/cakephp-devtools/configs/phing.xml [BUILD-TARGET]
```

### Build Targets

A build target is an alias for a series of build steps.


| Target    | Description    |
| --- | :--- |
| ***HELPER TARGETS*** |
| info | Displays info |
| prepare | Prepare build |
| clean | Remove all existing build artifacts |
| ***ANALYSE TARGETS*** |
| lint | Perform syntax check of sourcecode files |
| phploc | Measure project size using PHPLOC and print human readable output. Intended for usage on the command line |
| phploc-ci | Measure project size using PHPLOC and log result in CSV and XML format. Intended for usage within a continuous integration environment. |
| pdepend | Calculate software metrics using PHP_Depend and log result in XML format. Intended for usage within a continuous integration environment. |
| phpmd | Perform project mess detection using PHPMD and print human readable output. Intended for usage on the command line before committing. |
| phpmd-ci | Perform project mess detection using PHPMD and log result in XML format. Intended for usage within a continuous integration environment. |
| phpcs | Find coding standard violations using PHP_CodeSniffer and print human readable output. Intended for usage on the command line before committing. |
| phpcs-ci | Find coding standard violations using PHP_CodeSniffer and log result in XML format. Intended for usage within a continuous integration environment. |
| phpcbf | Automatically fix coding standard violations using PHP_CodeSniffer. | |
| phpcpd | Find duplicate code using PHPCPD and print human readable output. Intended for usage on the command line before committing. |
| phpcpd-ci | Find duplicate code using PHPCPD and log result in XML format. Intended for usage within a continuous integration environment. |
| phpstan | Perform static analysis using PHPSTAN and print human readable output. Intended for usage on the command line before commiting. |
| phpstan | Perform static analysis using PHPSTAN and log result in XML format. Intended for usage within a continuous integration environment. |
| ***TEST TARGETS*** |
| phpunit | Run unit tests with PHPUnit |
| phpunit-no-coverage | Run unit tests with PHPUnit (without generating code coverage reports) |
| phpdox | Generate project documentation using phpDox. Runs: phploc-ci, phpcs-ci, phpmd-ci |
| ***WRAPPER TARGETS*** |
| static-analysis | Runs: lint, phploc-ci, pdepend, phpmd-ci, phpcs-ci, phpcpd-ci |
| static-analysis-parallel | Runs: lint, phploc-ci, pdepend, phpmd-ci, phpcs-ci, phpcpd-ci |
| quick-test | Runs: phpunit-no-coverage | 
| quick-build | Runs: lint, phpunit-no-coverage |
| full-build | Runs: static-analysis, phpunit, phpdox |
| full-build-parallel | Runs: static-analysis-parallel, phpunit, phpdox |


## Usage with Jenkins CI

### Jenkins Project Configuration

#### General: Description
To display `pdepend` generated graphics in project overview add following
HTML snippet to the project description.
```html
<a href="ws/artifacts/pdepend/overview-pyramid.svg" target="_blank">
  <img type="image/svg+xml" src="ws/build/pdepend/overview-pyramid.svg" alt="Pdepend pyramid" width="500" />
</a>
<a href="ws/artifacts/pdepend/dependencies.svg" target="_blank">
  <img type="image/svg+xml" src="ws/build/pdepend/dependencies.svg" alt="Pdepend dependencies" width="500" />  
</a>
```

#### Build Step: Execute Shell 
Example shell build step to prepare the build environment.
```shell
#!/bin/bash

# Github pubkey authentication for checking out private repos
# Before use:
# * Generate SSH-Keypair (store eg. in /var/lib/jenkins/.ssh/jenkins)
# * Register public key in your Github-Account
# More Information:
# https://help.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh
# https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
#
# Start the ssh-agent in the background.
#eval "$(ssh-agent -s)"
# Add your SSH private key to ssh-agent
#ssh-add /var/lib/jenkins/.ssh/jenkins

# Load devtools on-the-fly via composer
# (not necessary if devtools are already defined in composer.json as a dependency)
#composer config minimum-stability dev
#composer config prefer-stable 1
#composer require --dev fm-labs/cakephp-devtools dev-master

# Install composer dependencies
composer update --no-interaction --no-suggest --no-progress --no-ansi

# Create a test database
#mysql -u root -proot -e 'CREATE DATABASE IF NOT EXISTS cakephp_test';

# Define test database connection for CakePHP
#export DB_DSN=mysql://root:root@127.0.0.1/cakephp_test

# Create custom configuration file for CakePHP
#cat > $WORKSPACE/config/app_local.php <<'CONFIG'
#<?php
#return [ /* ... config => here ... */ ];
#CONFIG

# Create custom build properties file for phing
#cat > $WORKSPACE/build.properties <<'BUILD'
#phpunit.args=--exclude-group integration
#BUILD

# Execute a phing build target manually
# Recommendation: use the Jenkins build step 'Invoke phing targets' instead
# a) via cakedev
#./vendor/bin/cakedev full-build
# b) via phing
#./vendor/bin/phing \
#    -Dbasedir=$(pwd) \
#    -f ./vendor/fm-labs/cakephp-devtools/configs/phing.xml \
#    -propertyfile ./build.properties \
#    full-build
```

#### Build step: Invoke phing targets
Add Jenkins build step 'Invoke phing targets' and use following configuration:

* Phing Version: any
* Targets: [target] (See target list)
* Phing Build File: $WORKSPACE/vendor/fm-labs/cakephp-devtools/configs/phing.xml
* Options: 
* Properties: basedir=$WORKSPACE
* Use ModuleRoot as working directory: yes

### Post-Build Actions

[ TODO ]

# Hints

## PhpUnit

* ***Exclude code blocks from code coverage:***
  Use the `@codecoverageIgnore`, `@codecoverageIgnoreStart`,
 `@codecoverageIgnoreEnd` PHP annotations on classes, methods or lines.
  Read more:
  [PHPUnit Manual:Ignoring Code Blocks](https://phpunit.readthedocs.io/en/8.5/code-coverage-analysis.html#code-coverage-analysis-ignoring-code-blocks)

## CodeSniffer

* ***Exclude code blocks from code sniffing:***
  Use the `//phpcs:disable` and `//phpcs:enable` comment lines around code you want to ignore.

# Acknowledgements

This project has been inspired by ***jenkins-php***
 ([Website](https://jenkins-php.org))
 ([Github](https://github.com/sebastianbergmann/php-jenkins-template))

---

Copyright (c) 2020 fm-labs |
[LICENSE](LICENSE)