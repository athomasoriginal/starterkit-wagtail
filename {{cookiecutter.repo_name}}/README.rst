*************************************
Welcome to {{cookiecutter.repo_name}}
*************************************

welcome to **{{cookiecutter.repo_name}}**!  The following is a step-by-step guide to get this project running on your local environment.

.. note:: The following will work on OSX.

Prerequisites
=============

Please make sure you have the following installed on your local development environment:

* docker

Please be sure that **Docker** is running before you start running through these commands

Quick Start
===========

**1.  Move into your project root directory**

.. code-block:: bash

  cd {{cookiecutter.repo_name}}


**4.  Generate your .env file**

.. code-block:: bash

  source ./tools/scripts/generate-env-file.sh

.. epigraph::

   The above generates a ``.env`` file in this projects ``src`` dir


**5.  Run wagtail**

.. code-block:: bash

  docker-compose up --build


If things went as expected you should be able to visit http://localhost:8000 in your browser.  Did it work?  Congratulations!  You now have your base Wagtail site configured and ready for local development.

Add Super User
==============

Run through the following steps to access the wagtail admin

**1.  Attach yourself to docker container interactively**

.. code-block:: bash

  docker exec -it wagtail bash


**2.  Move into src directory**

.. code-block:: bash

  cd src


**3. Create super user**

.. code-block:: bash

  python manage.py createsuperuser


Settings
========

+---------------------------+----------------------------------------+
| Setting                   | value                                  |
+===========================+========================================+
| database name             | {{cookiecutter.db_name}}               |
+---------------------------+----------------------------------------+
| database username         | {{cookiecutter.db_user}}               |
+---------------------------+----------------------------------------+
| database password         | {{cookiecutter.db_password}}           |
+---------------------------+----------------------------------------+
| database host             | {{cookiecutter.db_host}}               |
+---------------------------+----------------------------------------+
| django superuser name     | {{cookiecutter.django_login_username}} |
+---------------------------+----------------------------------------+
| django superuser password | {{cookiecutter.django_login_password}} |
+---------------------------+----------------------------------------+

Docker
======

A few things to note about Docker:

* We have provided a dockerized postgres instance.  Data is persisted in the ``db_data`` volume.
* Your postgres host is called ``db`` as this is the service name of the dockerized postgres instance

Logging
=======

Logging is an important part of apps.  Fortunately, this is already configured for you in this template.  To start using logs, go into any
python file inside of ``apps`` and add the following:

.. code-block:: python

  import logging

  logger = logging.getLogger(__name__)

When you want to log something in a function or a class you can use one of these calls

.. code-block:: python

  logger.debug("debug")
  logger.info("info")
  logger.warning("warning")
  logger.error("error")


Gotchas
=======

.. epigraph::

   I have too many containers running?

   You have to clear out your local images and containers every now and again.  See this thread for a discussion:

   https://github.com/docker/docker/issues/23371

   https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes


.. epigraph::

  I ran `docker-compose up` and I get a can't connect to db - 5432

  If you have not already done so, create your .env file by running `step 4` form the quick start guide above.  If you have done this
  and you are still running into issues please try 1.  ensure the host has a db server running on it.


.. epigraph::

  I was coding just fine at work and then I moved to another location and I get a can't connect to db - 5432 error.

  If you are running your DB locally the problem is that your IP Address has changed.  This is no problem.  Just run `source ./tools/script/update_ip_addr.sh` from
  the {{cookiecutter.repo_name}} root directory and you should be good to go.
