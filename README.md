# CakePHP devtools

Common CakePHP developer tools in a bundle.

This package is primarily a composer meta-package for common (Cake)PHP developer tools, like
PHPUnit, phpcs, phpcbf, phpmd, phpcpd, phpstan.

Instead of adding (and maintaining) all dev dependencies in each CakePHP project,
this package bundles the dev tools and some helper scripts in a single meta package.

The goal is to have a reusabe build-environment for CakePHP applications and CakePHP plugins following CakePHP's philosophy of
 'convention-over-configuration'.

## Installation

```
 # In your CakePHP project directory
 $ composer require --dev fm-labs/cakephp-devtools
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
``` 

Under the hood all build targets will be executed using `phing` .
The phing configuration file is located at `configs/phing.xml` .

### Build Targets

A build target is an alias for series of build steps.


| Target    | Description    | Depends    |
| --- | :--- | --- |
| info | Displays info |
| prepare | Prepare build |
| clean | Remove all existing build artifacts |
| lint | Perform syntax check of sourcecode files | |
| phploc | Measure project size using PHPLOC and print human readable output. Intended for usage on the command line | |
| phploc-ci | Measure project size using PHPLOC and log result in CSV and XML format. Intended for usage within a continuous integration environment. | |
| pdepend | Calculate software metrics using PHP_Depend and log result in XML format. Intended for usage within a continuous integration environment. | |
| phpmd | Perform project mess detection using PHPMD and print human readable output. Intended for usage on the command line before committing. | |
| phpmd-ci | Perform project mess detection using PHPMD and log result in XML format. Intended for usage within a continuous integration environment. | |
| phpcs | Find coding standard violations using PHP_CodeSniffer and print human readable output. Intended for usage on the command line before committing. | |
| phpcs-ci | Find coding standard violations using PHP_CodeSniffer and log result in XML format. Intended for usage within a continuous integration environment. | |
| phpcbf | Automatically fix coding standard violations using PHP_CodeSniffer. | |
| phpcpd | Find duplicate code using PHPCPD and print human readable output. Intended for usage on the command line before committing. | |
| phpcpd-ci | Find duplicate code using PHPCPD and log result in XML format. Intended for usage within a continuous integration environment. | |
| phpunit | Run unit tests with PHPUnit | |
| phpunit-no-coverage | Run unit tests with PHPUnit (without generating code coverage reports) | |
| phpdox | Generate project documentation using phpDox | phploc-ci, phpcs-ci, phpmd-ci |
| phpstan | Perform static analysis using PHPSTAN and print human readable output. Intended for usage on the command line before commiting. | |
| phpstan | Perform static analysis using PHPSTAN and log result in XML format. Intended for usage within a continuous integration environment. | |
| static-analysis | | lint, phploc-ci, pdepend, phpmd-ci, phpcs-ci, phpcpd-ci |
| static-analysis-parallel | | lint, phploc-ci, pdepend, phpmd-ci, phpcs-ci, phpcpd-ci |
| quick-test | | phpunit-no-coverage | 
| quick-build | | lint, phpunit-no-coverage |
| full-build | | static-analysis, phpunit, phpdox |
| full-build-parallel | | static-analysis-parallel, phpunit, phpdox |


## Usage with Jenkins CI

### Project Configuration

