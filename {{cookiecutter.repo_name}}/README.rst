*************************************
Welcome to {{cookiecutter.repo_name}}
*************************************

welcome to **{{cookiecutter.repo_name}}**!  The following is a step-by-step guide to get this project running on your local environment.

.. note:: The following will work on OSX.  Further, I missed this in the instructions, but for the time being you will need to manually create
your role and database in Postgres.app.

Prerequisites
=============

Please make sure you have the following installed on your local development environment:

* `vagrant`_
* `virtualbox`_
* `docker`_
* `postgres.app`_

Quick Start
===========

With the above completed, open a new terminal window and move into the ``{{cookiecutter.repo_name}}`` root directory and run through the following steps.

**1. Start Postgres.app**

open the postgres.app application


**2.  Start Docker for mac app**

Open the application


**3.  Move into your project root directory**

.. code-block:: bash

  cd {{cookiecutter.repo_name}}


**4.  Build .env file**

.. code-block:: bash

  source ./tools/docker/build-env.sh

.. epigraph::

   The above generates a ``.env`` file in this projects ``src`` dir


**5.  Build the docker image**

.. code-block:: bash

  docker build -t cms/wagtail:v0.1 -f ./tools/docker/Dockerfile .

.. epigraph::

   ``docker build:``  *cms/wagtail:v0.1* is the tag for our image.  name:version
   ``-t``: tags the image we are building - feel free to replace this with something meaningful to your project
   ``-f``: specify the path to the Dockerfile.  If we do not specify, the ``docker build`` command is not going to find it.
   ``.``: specify the ``build context``

**5.  Run the docker image**

.. code-block:: bash

  docker run -p 8000:8000 --name wagtail-cms -v $(pwd)/src:/src -v $(pwd)/logs:/logs cms/wagtail:v0.1



If things went as expected you should be able to visit http://localhost:8000 in your browser.  Did it work?  Congratulations!  You now have your base Wagtail site configured and ready for local development.

For more information on this project, please head over to the docs.


Gotchas
=======

.. epigraph::

   I have too many containers running?

   You have to clear out your local images and containers every now and again.  See this thread for a discussion:

   https://github.com/docker/docker/issues/23371

   https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes
