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


**2.  Start Docker**

Open the application


**3.  Move into your project root directory**

.. code-block:: bash

  cd {{cookiecutter.repo_name}}


**4.  Build .env file**

.. code-block:: bash

  source ./tools/docker/build-env.sh

.. epigraph::

   The above generates a ``.env`` file in this projects ``src`` dir


**5.  Run docker-compose**

.. code-block:: bash

  docker-compose up


If things went as expected you should be able to visit http://localhost:8000 in your browser.  Did it work?  Congratulations!  You now have your base Wagtail site configured and ready for local development.

For more information on this project, please head over to the docs.


Vagrant Environments
====================

There are two vagrant environments provided:  ``dev`` and ``qa``.  ``qa`` is meant to more closely simulate your deploy process and really enhances the confidence of the development team by providing an alternate environment to test in.

Gotchas
=======

.. epigraph::

   I was able to start my VM, SSH into it and start my dev server, but when I tried to visit http://localhost:8111 it did not seem to work.

The most common reason for this is that the port is not correct.  Check to see that you are supposed to be connecting on port ``8111``.  To do this, open a new terminal window, ``cd`` into the ``{{cookiecutter.repo_name}}`` directory and run ``vagrant port``.  This will show you two lines.  The second line will tell you which port to connect to.

.. epigraph::

   I tried to ``pip freeze`` inside of my vagrant machine and it returned ``locale.Error: unsupported locale setting``.

I will look into fixing this within the provisioning script, but for the time being it can be resolved by reinstalling the language packages:

.. code-block:: bash

    sudo apt-get install language-pack-en-base -y && sudo locale-gen en_US en_US.UTF-8 && sudo dpkg-reconfigure locales


.. _vagrant: https://www.vagrantup.com/downloads.html
.. _virtualbox: https://www.virtualbox.org/
.. _node: https://nodejs.org/en/
.. _gulp: https://github.com/gulpjs/gulp/blob/master/docs/getting-started.md
.. _NVM: https://github.com/creationix/nvm
.. _docker: https://docs.docker.com/docker-for-mac/
.. _postgres.app: https://postgresapp.com/
