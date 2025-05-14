# CakePHP devtools

**! THIS PACKAGE IS FOR CAKEPHP 4 !**

[![Build Status](https://travis-ci.org/fm-labs/cakephp-devtools.svg?branch=master)](https://travis-ci.org/fm-labs/cakephp-devtools)
[![Latest Stable Version](https://poser.pugx.org/fm-labs/cakephp-devtools/v/stable.svg)](https://packagist.org/packages/fm-labs/cakephp-devtools)
[![Total Downloads](https://poser.pugx.org/fm-labs/cakephp-devtools/downloads.svg)](https://packagist.org/packages/fm-labs/cakephp-devtools)
[![License](https://poser.pugx.org/fm-labs/cakephp-devtools/license.svg)](https://packagist.org/packages/fm-labs/cakephp-devtools)

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
composer require fm-labs/cakephp-devtools:^4
```


## Usage

### CLI usage

Helper tool to execute commands with shared configurations.

```
 $ cakedev [BUILD-TARGET]
 
 // Examples
 // List available build targets
 $ cakedev list

 // Run PHPUnit
 $ cakedev phpunit

 // Run PHPUnit without coverage
 $ cakedev phpunit-no-coverage
 
 // Run PHPStan
 $ cakedev phpstan

 // ... see full build target list below ...
``` 

### Add scripts to your `composer.json`


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
        // "cs-check": "phpcs --colors -p --standard=vendor/cakephp/cakephp-codesniffer/CakePHP src/ tests/",
        // "cs-fix": "phpcbf --colors --standard=vendor/cakephp/cakephp-codesniffer/CakePHP src/ tests/",
        // "stan": "phpstan analyse src/",
        // "test": "phpunit --colors=always tests/",
    },
}
```

```
# Execute script with
# composer run [script-name]
# Example:
$ composer run check
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


## Phing

Under the hood all build targets will be executed using `phing` .
The phing configuration file is located at `configs/phing.xml` .

```
 // Phing command
 $ ./vendor/bin/phing -Dbasedir=$(pwd) -f ./vendor/fm-labs/cakephp-devtools/configs/phing.xml [BUILD-TARGET]
```

### Phing Properties

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


---

## License

This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <https://unlicense.org>


[LICENSE](LICENSE)