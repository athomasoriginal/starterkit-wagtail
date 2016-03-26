**********
Change Log
**********

All enhancements and patches to cookiecutter-django will be documented in this file. This project adheres to `Semantic Versioning`_.

[2016-03-26]
============

**Changed**

* Added ``React`` to the webpack config - it is now an automatically configured option for developers - no extra weight added

* Dev dependencies in package.json will not auto upgrade to latest versions.  At the time of this writing there are breaking changes with some of the latest packages.  This situation will be fixed shortly.

[2016-03-25]
============

**Changed**

* Updated Wagtail from 1.3 to 1.4

* Removed the 'compressor' third party package from INSTALLED_APPS.  This is a recent change outlined in the `Wagtail 1.4 release notes`_

* Updated README with notes on how to test the cookiecutter

* Updated projects package.json dependency versions

* Webpack Dev Task

    - Updated the task to point to stylesheets

* .eslintrc

    - Added a new rule:  4 spaces for JS
    - Updated documentation to explain the configuration file

* Updated the repo README

    - corrected grammar and broken/incorrectly assigned links

* Cookiecutter.json

    - changed default values for database password and name

[2016-02-29]
============

**Added**

* stylesheets directory

  - added stylesheets/base
  - added stylesheets/utils
  - added main.styl

* javascripts directory
* tests directory

  - renamed ``js`` directory to ``javascripts``

* config directory

  - custom error pages - 400, 404, 500
  - documentation for error pages
  - configured to support favicon

* apps directory

  - custom wagtail branding templates

**Changed**

* ``javascripts/index.js`` - comments added
* ``tools.config.js`` - configured to reflect changed to static directory structure
* ``webpack.config.js`` - configured to reflect changed to static directory structure
* ``docs`` - updated the readme for the documentation.
* ``tasks/css-dev`` - removed sourcemap generation

[2016-02-28]
============

initial commit (@tkjone)

.. _Semantic Versioning: http://semver.org/
.. _Wagtail 1.4 release notes: http://docs.wagtail.io/en/v1.4.1/releases/1.4.html
