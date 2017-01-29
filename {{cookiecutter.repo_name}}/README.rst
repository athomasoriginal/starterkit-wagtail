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


## Branches

This section is going to outline and provide context to the `eternal` branches in this repo.

My descriptions and approaches outlined below are not considered be the one true way, just the best that I know how at this moment.  Along these lines,  I apologize in advance for any generalizations I make as when it comes to how to structure a project, it is a very personal thing.

With this in mind, there are three main approaches to app architecture:

1.  **Monolithic:**  This is the idea that the whole app is composed as one piece of software.  It is developed and deployed as one piece.

2. **Monopurpose:**  This would be the idea of a micro service architecture.  Your app is divided into multiple sub repositories that are orchestrated to talk to one another.

3. **Monorepo:**  This combines 1 + 2.  The idea is that you create separate services that live entirely on their own, but instead of living in separate repos, you put them all in one repo - like the monolithic, just clearer distinctions of functionality and purpose.

As I mentioned, there are many who will argue that my descriptions above are too generic and not reflective of the reality of each architecture.  This is understood. However, with the above in mind, we can now start to understand the different `eternal` branches.

### v1.0

- Wagtail App
- React Front End
- vagrant development environment

This is the `monolithic` architecture and represents my approach to developing about a year ago (wrote this in January of 2017)

I started to move away from this because I wanted a greater separation of the front and the backend.

At this point, v1.0 is for posterity.

### master

- Wagtail App
- vagrant development environment

This is the `monopurpose` architecture.  The Wagtail App are kept latest and the Front End has been removed.  This means that this can act solely as a service for an app and the front end is separated.

This branch will be the default as I believe this is a more common approach to developing and easier to understand.

### dockerized

- Wagtail App
- Docker development environment

This is the `monopurpose` architecture again, except dockerized.  Thus, it means that it is already part way to being ready to be deployed to production as a docker container.

This branch will be kept up to date regarding the dependencies

### dockerized-monorepo

- Wagtail App
- Docker development environment

This is the `monorepo` architecture.  Everything regarding the app is the same as `master` and `dockerized`.  The difference is that I have removed the `git`, `docker-compose` and a few other code quality files.  This has been done because now we can pop this into a monorepo and it is ready to go as an isolated app, but does not have the extras needed to be a repo on its own.


Gotchas
=======

.. epigraph::

   I have too many containers running?

   You have to clear out your local images and containers every now and again.  See this thread for a discussion:

   https://github.com/docker/docker/issues/23371

   https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes
