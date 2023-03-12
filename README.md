# CakePHP devtools

Bundle of common CakePHP developer tools.

The goal is to have a reusable build-environment for CakePHP projects, following CakePHP's philosophy of
 'convention-over-configuration'.
 
This package is primarily a composer meta-package for common PHP developer tools, like
`phpunit`, `phpcs`, `phpcbf`, `phpmd`, `phpstan`, ~~`phpcpd`~~, ~~`phploc`~~
and CakePHP's own essential tools `debug_kit`, `bake` and `repl`.

Instead of adding and maintaining all dev dependencies in each CakePHP project,
this package bundles a common set of dev tools and some helper scripts.

## Installation
```
 # In your CakePHP project directory
 composer require --dev fm-labs/cakephp-devtools dev-master
```

## Usage
### `bin/cakedev`
Helper script to execute tool commands with shared configurations.

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

### `vendor/bin/phing`

Under the hood all build targets will be executed using `phing` .
The phing configuration file is located at `configs/phing.xml` .

```
 // Phing command
 $ ./vendor/bin/phing -Dbasedir=$(pwd) -f ./vendor/fm-labs/cakephp-devtools/configs/phing.xml [BUILD-TARGET]
```

### `composer run`

Add "scripts" to your `composer.json`

```
// Example scripts in composer.json
{
    [...]
    "scripts": {
        // Run tools via cakedev script
        // (shared configs apply automatically)
        "phpunit": "cakedev phpunit",
        "phpunit-no-coverage": "cakedev phpunit-no-coverage",
        "pdepend": "cakedev pdepend",
        "phpcbf": "cakedev phpcbf",
        "phpcs": "cakedev phpcs",
        "phpmd": "cakedev phpmd",
        "phpstan": "cakedev phpstan",

        // Aliases
        "check": [
            "@test",
            "@cs-check"
        ],
        "cs-check": "cakedev phpcs",
        "cs-fix": "cakedev phpcbf",
        "quick-test": "cakedev quick-test",
        "test": "cakedev phpunit",
        "stan": "cakedev phpstan",
        "quick-build": "cakedev quick-build",
        "full-build": "cakedev full-build",
        "static-analysis": "cakedev static-analysis",


        // Alternative: Run tools directly
        // (shared configs do not apply)
        "check": [
            "@test",
            "@cs-check"
        ],
        "cs-check": "phpcs --colors -p --standard=vendor/cakephp/cakephp-codesniffer/CakePHP src/ tests/",
        "cs-fix": "phpcbf --colors --standard=vendor/cakephp/cakephp-codesniffer/CakePHP src/ tests/",
        "stan": "phpstan analyse src/",
        "test": "phpunit --colors=always tests/",
    },
}
```

```
# Execute script with
# composer run [script-name]
# Example:
$ composer run check
```

### Direct tool usage

Any tool can also be used directly from the `vendor/bin` directory,
naturally the shared devtools configurations won't apply automatically. 

```
# Example:
$ ./vendor/bin/phpunit --no-coverage
$ ./vendor/bin/phpstan analyse src/
...
```

### Build Targets

A build target is an alias for a series of build steps.


| Target                   | Description                                                                                                                                         |
|--------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------|
| ***HELPERS***            |
| info                     | Displays info                                                                                                                                       |
| prepare                  | Prepare build                                                                                                                                       |
| clean                    | Remove all existing build artifacts                                                                                                                 |
| ***ANALYSE***            |
| lint                     | Perform syntax check of sourcecode files                                                                                                            |
| ~~phploc~~               | (Project abandoned) Measure project size using PHPLOC and print human readable output. Intended for usage on the command line                                           |
| ~~phploc-ci~~            | (Project abandoned) Measure project size using PHPLOC and log result in CSV and XML format. Intended for usage within a continuous integration environment.             |
| pdepend                  | Calculate software metrics using PHP_Depend and log result in XML format. Intended for usage within a continuous integration environment.           |
| phpmd                    | Perform project mess detection using PHPMD and print human readable output. Intended for usage on the command line before committing.               |
| phpmd-ci                 | Perform project mess detection using PHPMD and log result in XML format. Intended for usage within a continuous integration environment.            |
| phpcs                    | Find coding standard violations using PHP_CodeSniffer and print human readable output. Intended for usage on the command line before committing.    |
| phpcs-ci                 | Find coding standard violations using PHP_CodeSniffer and log result in XML format. Intended for usage within a continuous integration environment. |
| phpcbf                   | Automatically fix coding standard violations using PHP_CodeSniffer.                                                                                 | |
| ~~phpcpd~~               | (Project abandoned) Find duplicate code using PHPCPD and print human readable output. Intended for usage on the command line before committing.     |
| ~~phpcpd-ci~~            |(Project abandoned)  Find duplicate code using PHPCPD and log result in XML format. Intended for usage within a continuous integration environment.                      |
| phpstan                  | Perform static analysis using PHPSTAN and print human readable output. Intended for usage on the command line before commiting.                     |
| phpstan                  | Perform static analysis using PHPSTAN and log result in XML format. Intended for usage within a continuous integration environment.                 |
| ***TEST***               |
| phpunit                  | Run unit tests with PHPUnit                                                                                                                         |
| phpunit-no-coverage      | Run unit tests with PHPUnit (without generating code coverage reports)                                                                              |
| ***DOC GENERATOR***      |
| phpdox                   | Generate project documentation using phpDox. Runs: phploc-ci, phpcs-ci, phpmd-ci                                                                    |
| ***ALIASES***            |
| static-analysis          | Runs: lint, phploc-ci, pdepend, phpmd-ci, phpcs-ci, phpcpd-ci, phpstan-ci                                                                           |
| static-analysis-parallel | Runs: lint, phploc-ci, pdepend, phpmd-ci, phpcs-ci, phpcpd-ci, phpstan-ci                                                                           |
| quick-test               | Runs: phpunit-no-coverage                                                                                                                           | 
| quick-build              | Runs: lint, phpunit-no-coverage                                                                                                                     |
| full-build               | Runs: static-analysis, phpunit, phpdox                                                                                                              |
| full-build-parallel      | Runs: static-analysis-parallel, phpunit, phpdox                                                                                                     |


## Reports

| Tool       | Report    | Format    | Description     |
|------------| ---       | ---       | ---    |
| ~~phploc~~ | logs/phploc.csv | csv |
| ~~phploc~~ | logs/phploc.xml | xml |
| phpunit    | logs/crap4j.xml | xml | Coverage Crap4j format |
| phpunit    | logs/clover.xml | xml | Coverage Clover format |
| phpunit    | logs/phpunit.php | php | Coverage PHP format |
| phpunit    | logs/phpunit.txt| txt | Coverage TXT format |
| phpunit    | coverage/html | directory | Coverage HTML format |
| phpunit    | coverage/xml | directory | Coverage XML format |
| phpunit    | logs/junit.xml | xml | Test results JUNIT format |
| phpcs      | logs/checkstyle.xml | xml | Checkstyle XML |
| phpcs      | logs/checkstyle.diff | diff | DIFF format |
| phpmd      | logs/pmd.xml | xml | |
| ~~phpcpd~~ | logs/pmd-cpd.xml | xml | PMD XML format |
| phpstan    | logs/phpstan.xml | xml | |
| pdepend    | logs/jdepend.xml | xml | Jdepend XML format |
| pdepend    | pdepend/dependencies.svg | svg | Jdepend Chart Image |
| pdepend    | pdepend/overview-pyramid.svg | svg | Jdepend Pyramid Image |
| pdepend    | pdepend/dependencies.xml | xml | Jdepend Dependencies XML |
| pdepend    | pdepend/summary.xml | xml | Jdepend Summary XML |

## Phing Properties

```
<!-- Tools binary location properties -->
<property name="pdepend.bin" value="${basedir}/vendor/bin/pdepend"/>
<property name="phpcpd.bin"  value="${basedir}/vendor/bin/phpcpd"/>
<property name="phpcs.bin"   value="${basedir}/vendor/bin/phpcs"/>
<property name="phpcbf.bin"  value="${basedir}/vendor/bin/phpcbf"/>
<property name="phpdox.bin"  value="${basedir}/vendor/bin/phpdox"/>
<property name="phploc.bin"  value="${basedir}/vendor/bin/phploc"/>
<property name="phpmd.bin"   value="${basedir}/vendor/bin/phpmd"/>
<property name="phpunit.bin" value="${basedir}/vendor/bin/phpunit"/>
<property name="phpstan.bin" value="${basedir}/vendor/bin/phpstan"/>

<!-- phpunit.args: Additional command line arguments for phpunit -->
<property name="phpunit.args" value="" />
<!-- Configuration location properties -->
<property name="phpunit.configuration"          value="${basedir}/phpunit.xml.dist" />
<property name="phpdox.configuration"           value="${basedir}/phpdox.xml.dist" />
<property name="phpmd.configuration"            value="${devtools.configdir}/phpmd.xml" />
<property name="pdepend.configuration"          value="${devtools.configdir}/pdepend.xml" />
<property name="phpstan.configuration"          value="${devtools.configdir}/phpstan.neon" />
<!-- Log location properties -->
<property name="phpunit.log.coverage-html-dir"  value="${basedir}/build/coverage/html" />
<property name="phpunit.log.coverage-xml-dir"   value="${basedir}/build/coverage/xml" />
<property name="phpunit.log.coverage-php"       value="${basedir}/build/logs/phpunit.php" />
<property name="phpunit.log.coverage-text"      value="${basedir}/build/logs/phpunit.txt" />
<property name="phpunit.log.coverage-clover"    value="${basedir}/build/logs/clover.xml" />
<property name="phpunit.log.coverage-crap4j"    value="${basedir}/build/logs/crap4j.xml" />
<property name="phpunit.log.junit"              value="${basedir}/build/logs/junit.xml" />
<property name="phploc.log.csv"                 value="${basedir}/build/logs/phploc.csv" />
<property name="phploc.log.xml"                 value="${basedir}/build/logs/phploc.xml" />
<property name="phpcs.log.report-checkstyle"    value="${basedir}/build/logs/checkstyle.xml" />
<property name="phpcs.log.report-diff"          value="${basedir}/build/logs/checkstyle.diff" />
<property name="phpmd.log.report-xml"           value="${basedir}/build/logs/pmd.xml" />
<property name="phpcpd.log.pmd-xml"             value="${basedir}/build/logs/pmd-cpd.xml" />
<property name="phpstan.log.xml"                value="${basedir}/build/logs/phpstan.xml" />
<property name="pdepend.log.jdepend-xml"        value="${basedir}/build/logs/jdepend.xml" />
<property name="pdepend.log.jdepend-chart-svg"  value="${basedir}/build/pdepend/dependencies.svg" />
<property name="pdepend.log.pyramid-svg"        value="${basedir}/build/pdepend/overview-pyramid.svg" />
<property name="pdepend.log.dependency-xml"     value="${basedir}/build/pdepend/dependencies.xml" />
<property name="pdepend.log.summary-xml"        value="${basedir}/build/pdepend/summary.xml" />
```

### Custom Properties

Create a `build.properties` file in your project root directory and set one key-value pair per line.
```
#Example build.properties file:
phpunit.bin=/my/custom/path/to/phpunit
phpunit.log.junit=/my/custom/path/junit.xml
phpunit.args=--exclude-group someTestGroupName
phpstan.configuration=/my/custom/config/path/phpstan.neon
```

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
composer install --no-interaction --no-suggest --no-progress --no-ansi
#composer update --no-interaction --no-suggest --no-progress --no-ansi

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
  
* ***Exclude files from code sniffing:***
  Use the `//phpcs:ignoreFile` comment line at the top of the excluded file.

# Acknowledgements

This project has been inspired by ***jenkins-php***
 ([Website](https://jenkins-php.org))
 ([Github](https://github.com/sebastianbergmann/php-jenkins-template))

---

Copyright (c) 2020 fm-labs |
[LICENSE](LICENSE)