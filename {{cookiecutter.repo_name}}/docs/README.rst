****************************************
{{cookiecutter.repo_name}} Documentation
****************************************

Welcome to **{{cookiecutter.repo_name}}** 's documentation.  This document will provide you with a high level overview of this project.

GETTING STARTED
===============

Hey there and welcome to **{{cookiecutter.repo_name}}**'s documentation.  Hopefully you will be able to find some answers here.  If you have already completed the `quickstart`_ and are still looking for more info, this is the place.  Below you will find a little more information about the *quickstart* process.

server side
-----------

**App - home**

This project starts you off with a *home* page.  The app does not really do much, it's more of a placeholder.  What is nice about it is that there is a migration file that creates the page for your and initializes you site.  This is about 4-8 steps removed from the process.  This is implemented by Wagtail itself in their ``wagtail start`` project template.  Check out `Extend the HomePage model`_ in wagtails documentation to see how you can work with this.

**Favicon**

The favicon is configured to be served in two way for this project:

* ``config/urls.py``
* ``link`` tag in ``base.html``

The reason for both is browser behavior can be strange for favicons.  This is an extra measure to help make sure that the favicon is handled correctly.  For more information read `Fail Proof Favicons`_.

**error pages**

This project comes with templates for ``400``, ``404`` and ``500``.  I have provided urls in the ``config/urls.py``.  You can test the 500 page while in development, but if you want to test the ``400`` or ``404`` pages, you will need to set ``DEBUG=False``

http://localhost:8111/500

Keep in mind that when you are styling these, it is good practice to keep the styles and javascript inline just to be safe.

**Overextends**

This third party django templating helper is added by default with this project.

**Customize Wagtail Admin**

This project comes with the templates required to customize the pages for the wagtail admin site.  There are four templates:

*branding_logo : base.html*

.. code-block:: html

    {% raw %}
    {% block branding_logo %}
        <img src="{{ STATIC_URL }}images/custom-logo.svg" alt="Custom Project" width="80" />
    {% endblock %}
    {% endraw %}

*branding_favicon : admin_base.html*

.. code-block:: html

    {% raw %}
    {% block branding_favicon %}
        <link rel="shortcut icon" href="{{ STATIC_URL }}images/favicon.ico" />
    {% endblock %}
    {% endraw %}

*branding_login : login.html*

.. code-block:: html

    {% raw %}
    {% block branding_login %}Sign in to Frank's Site{% endblock %}
    {% endraw %}

*branding_welcome : home.html*

.. code-block:: html

    {% raw %}
    {% block branding_welcome %}Welcome to Frank's Site{% endblock %}
    {% endraw %}

**settings**

+---------------------------+----------------------------------------+
| Setting                   | value                                  |
+===========================+========================================+
| database engine           | {{cookiecutter.db_engine}}             |
+---------------------------+----------------------------------------+
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


client side
-----------

This project uses stylus as the default, hoever, the structure of the project is preprocessor agnostic both in the way that the ``static`` dir is setup and in the way that the gulp task ``css-dev`` and ``css-prod`` are setup.  If you do not want to use ``stylus`` simply head over to the ``tools/tasks`` directory and change the ``stylus`` variable to the preprocessor of your choice.

commands
--------

**django-admin**

This command is the equivalent of ``python manage.py``.  The difference between the two is that django-admin provides a little more flexibility to the developer.  `standalone django scripts`_ has a good overview of what I am talking about.

**gulp start**

This is a gulp task found in ``gulpfile.js``.  When you run this command it actually runs two additional tasks: ``css-dev`` and ``browsersync``. The first task will initialize you build directory with some css and browsersync will launch a light weight webserver.  Immediatley this is going to provide you with interaction syncronization, remote debugging, live reload and watches and injects your css as you make changes - without reloading the page.

In addition to this, browsersync uses webpack.  Webpack is going to watch and bundle your JS files.It also provides you with Hot Module Reloading.  For the unitiated, it will update you JS without reloading the page.  Keep in mind that webpack will store your js file in memory.  It does not output anything so do not be surprised when you don't see any JS files in your build directory.

This task will provide developers with a faster and more continuous development workflow.

**gulp build**

Run this command when you want to produce production ready JS and CSS files.  Do not use this for development...it won't do much for you.

**gulp test**

Run this command when you are writing unit tests for your JS.  This will run them in the browser s you can see if you JS works as you expect.  It run on browsersync, webpack and tape.

Configuration Files
-------------------

Configuration files are located in the ``tools/configs`` directory.

**.eslintrc**

This is the file that allows you to set specific rules for eslint.  As a default, I have configured it to follow the ES6 style guide proposed by airbnb.  To make adjustments, add them to the ``rules`` property.

The only rule change imposed is to allow the JS to have 4 spaces.

Project Overview
================

This project uses the following technologies

+----------------+----------------------------------------------------------------+
| responsibility | examples                                                       |
+================+================================================================+
| server side    | Django 1.9.1, Wagtal 1.3.1                                     |
+----------------+----------------------------------------------------------------+
| client side    | es6, stylus                                                    |
+----------------+----------------------------------------------------------------+
| tooling        | vagrant, node, browsersync, webpack, tape, eslint, babel, gulp |
+----------------+----------------------------------------------------------------+

Project Structure
=================

.. code-block::

    taye_diggs
        ├── build <- generated by gulp.  contains compiled static files.
        ├── docs  <- project wide documentation.
        ├── logs  <- logs for the server, front end, webserver etc.
        ├── src   <- application source code - django, javascript, css, html etc
        ├── tests <- javascript unit tests
        └── tools <- project wide tools - vagrant, gulp, webpack etc.


Deploying
=========

This section describes how to deploy this project


Contributing
============

This section outlines how you want people to contribute to your project.

Git Workflow: Forking and Branching
-----------------------------------

All contributors will Fork and Clone a copy of the official repository.  Run through the following steps:

Lead Developer:
...............

1.  Initialize a new bare repository
2.  Create a development branch
3.  Add working project to master
4.  pull working code to development branch

Contributors:
............

1.  Fork the project repo
2.  Clone a copy of the forked repo

.. code-block:: bash

    git clone https://user@github.com/user/repo.git

4.  Add remote Repositories (The location of the official repo)

.. code-block:: bash

    git remote add upstream https://github.com/maintainer/repo

5. When each contributor works on a new feature, they create a new branch based off their local main repo branch

.. code-block:: bash

    git checkout -b your-feature master

6. Contributors work in this feature branch then when they are satisfied with their code, or the main branch has moved forward, run the following command:

.. code-block:: bash

    git pull --rebase upstream development

8.  When ready to commit the branch - push to your public fork

.. code-block:: bash

    git push origin your-feature

10. Make a PR

Git Workflow: Feature Branch Naming Conventions
-----------------------------------------------

Please use dashes for names, not underscores or camel case:

.. code-block:: bash

    // bad :(
    your_feature

    // bad :(
    yourFeature

    // good :)
    your-feature

.. _quickstart: http://google.ca
.. _standalone django scripts: http://www.b-list.org/weblog/2007/sep/22/standalone-django-scripts/
.. _Extend the HomePage model: http://docs.wagtail.io/en/v1.3.1/getting_started/tutorial.html
.. _Fail Proof Favicons: http://staticfiles.productiondjango.com/blog/failproof-favicons/

