*************************************
Welcome to {{cookiecutter.repo_name}}
*************************************

welcome to **{{cookiecutter.repo_name}}**!  The following is a step-by-step guide to get this project running on your local environment.

.. note:: The following has been tested on OSX and Linux.  Windows may require some additional setup.

Prerequisites
=============

Please make sure you have the following installed on your local development environment:

* `vagrant`_
* `virtualbox`_
* `docker`_
* `postgres.app`

Quick Start
===========

With the above completed, open a new terminal window and move into the ``{{cookiecutter.repo_name}}`` root directory and run through the following steps.

**1. Start Postgres.app**

open the postgres.app application


**2.  Move into your project root directory**

.. code-block:: bash

  cd {{cookiecutter.repo_name}}


**3. Create a .env file and add the following to it**

.. code-block:: bash

    DJANGO_DATABASE_URL="{{cookiecutter.db_engine}}://{{cookiecutter.db_user}}:{{cookiecutter.db_password}}@{{cookiecutter.db_host}}/{{cookiecutter.db_name}}"

.. epigraph::

   You are going to have to update the above url where it says ``localhost`` to your computers IP address.  To quickly get this,
   run ``ipconfig getifaddr en0`` which will return something like ``192.128.3.142`` and then just replace localhost in the above DJANGO_DATABASE_URL
   with the IP address returned in the above step like so:  DJANGO_DATABASE_URL="{{cookiecutter.db_engine}}://{{cookiecutter.db_user}}:{{cookiecutter.db_password}}@192.128.3.142/{{cookiecutter.db_name}}".
   The reason we do this is because of the way that our process works.  We are not going to run our database in a docker container.  At the time of
   writing this, database in containers is not best practice.  In the spirit of enforcing good practices, we will avoid using the database in a container process.


**4.  Run docker-compose**

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
