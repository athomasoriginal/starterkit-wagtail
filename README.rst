*******************
Wagtail Starter Kit
*******************

Welcome to Wagtail Starter Kit, a cookiecutter template for Django Projects.

Warning
=======

This branch is being actively refactored.  It will fail if you try to build and use using the instructions listed below.

Overview
========

Wagtail Starter Kit provides you with a flexible starting point for your Django wagtail project.  Included in this template is a Django/Wagtail development environment provided by vagrant, a project layout inspired by pydanny's `cookiecutter django`_ and `Two Scoops of Django`_ and a lean set of dependencies.  The goal is to provide you with everything you need to quickly and easily start a new Django Wagtail project.

Wagtail Starter Kit uses a scaffolding tool called `cookiecutter`_.  Cookiecutter is similar to `Yeoman`_.  These tools are used to automatically build out entire projects instead of you having to create files manually and modify their configurations.

.. _cookiecutter django: https://github.com/pydanny/cookiecutter-django
.. _Two Scoops of Django: https://www.twoscoopspress.com/products/two-scoops-of-django-1-8
.. _Yeoman: http://yeoman.io/
.. _cookiecutter: https://cookiecutter.readthedocs.org/en/latest/index.html

Quick Start
===========

1. Install Cookiecutter
-----------------------

* OSX
   .. code-block:: bash

       brew install cookiecutter

* Linux + Windows
   .. code-block:: bash

       pip install cookiecutter

2. Build your Django project based on wagtail starter kit
---------------------------------------------------------

   .. code-block:: bash

       cookiecutter https://github.com/tkjone/wagtail-starter-kit.git

You are going to be prompted to answer some questions about your project and the answers you provide will be used to build and configure your new Django Wagtail project.  These questions are called `prompts`.  If you leave a `prompt` blank, Cookiecutter will use the default answer in the square brackets.  For a list of the prompts used by this template, please see the `prompts documentation`_

For example, let us pretend your a huge fan of Taye Diggs and you want to make a website celebrating his life.  This is how that would look:

.. image:: ./cookiecutter_example.gif


Out of the Box
==============

The `wagtail starter kit` provides you with the following feature set:


* Django 1.9.x

* Wagtail 1.4.x

* React

    Project is configured to use React automatically.  While React might not be your thing, and I do want to keep this project flexible, it is very easy to remove the depedency.

* Vagrant Setup - Ubuntu 14.04

    This includes a 100% configured Vagrantfile with a Ubuntu 14.04 vagrant box.

* Provisioning Scripts

    Shell scripts to automate the configuration of your vagrant box, setup your virtualenvironments, initialize and migrate your projects database, install Django dependencies and create project superuser.

* Multiple virtualenvironments

    The provisioning scripts will provide you with two virtualenvironments.  One uses Python 2 and the other uses Python 3.  No configuration required, no changes to the Ubuntu default version of Python, just switch between one or the other using virtualenvwrapper's `workon` command

    We also provide a ``dev`` environment and a ``qa`` environment out-of-the-box.  This enables a better simulation of different development flows and can be a good training tool for other developers.

* 12 Factor App

    Project is inspired by `12 factor app`_ which means it comes configured to use environment variables, database connection strings and other methodologies outlined in the 12 Factor manifesto.  Each one has defaults, which means you don't have to setup a `.env` or export variables to start development work.

* Multiple database choices (Postgres or sqlite)

    Are you working on a Proof of Concept and don't need a full blown database?  No worries, this project gives you the choice of sqlite or postgres and everything will be configured accordingly.

* lean project layout - HTML5 Boilerplate + Home App

    This project tries to provide a lean project layout.  HTML5 boilerplate inspired base.html file.  In addition, I have included a bare bones Home app which will start you off with a wagtail page and also initialize a site for you!

* Configured Django dev setup

    Providing you with some essential tools to get you up and running.  This includes:

    * django-extensions
    * django-nose
    * coverage
    * django-debug-toolbar

* Complete front end build workflow

    I have provided a complete front end workflow that includes

    * gulp
    * browsersync
    * webpack
    * tape
    * es6 support
    * eslint

* Collaboration - dotfiles and documentation structure

    Documentation is important, wagtail-starter-kit provides you with a basic documentation structure that and dot-files for improved collaboration.

.. _12 factor app: http://12factor.net/


Note on Branches
================

Currently there are two branches:  ``master`` and ``development``.  The ``master`` branch has not seen updates in about 8 months and also takes on a more traditional approach to working with wagtail.  The ``development`` branch will see many of the Django dependencies updated.  In addition, I have configured it with a more experimental approach to web development.  This means that the wagtail server will act more as an API and React will render everything on the backend.  Please see the ``CHANGELONG`` for more changes.

Constraints
===========

* Vagrant setup tested on Linux and OSX

    Project has not yet been tested on Windows OS.

* Postgres 9.0 or sqlite

    While you can configure this project to use other databases, I only provide configurations for Postgres and sqlite at this moment.

* Environment Variables (these won't work with Apache/mod_wsgi)


Deeper Dive
===========

Check out `guides django`_ for a step by step guide that explains this project in great detail.  Wagtail starter kit is built as a learning tool to help early and intermediate django developers get a better understanding, through practical application, of how to setup and configure a Django project.

.. _guides django: https://github.com/tkjone/guides-django

Contributing
============

I am a believer in the community creating things together. If you are reading through anything I have written here and find that it is incorrect, outdated or lacking in proper documentation, please feel free to create an issue or fork this repo and make a PR.

Branches
--------

If you are running tests for this project, change into the root directory of the cookiecutter and run ``py.test``.

Branches
--------

This repo's branches correspond to the version of Django being used.  This project will always default to the latest version of Django and the branches will follow the `django roadmap`_.  Currently there is only a master branch and it will stay this way until the next Django release (1.10).

.. _django roadmap: https://www.djangoproject.com/weblog/2015/jun/25/roadmap/
.. _prompts documentation: https://github.com/tkjone/wagtail-starter-kit/blob/master/docs/prompts.rst


