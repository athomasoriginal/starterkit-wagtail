*******
PROMPTS
*******

When you run ``cookiecutter </path/to/coomiecutter/template>`` you will be asked a series of questions.  These are called `prompts`.  This document details the questions you will be asked by Cookiecutter when you use it to build `django starter`_.

Templated Values
================

project_name:
    Name of your project.  Can be anything you like.  This name is used to generate a default repo_name.

    default: my project

repo_name:
    What do you want to name your project repo?  No spaces.  Underscores or dashes only.

    default: my_project

db_user:
    Name of your postgres database user.  Not used by sqlite.

    default: dev

db_password:
    What do you want your postgres database password to be.  Not used by sqlite

    default: my_project_dev

db_host:
    The host name for your database.  This is usually always correct, so you can almost always leave this blank.

    default: localhost

db_name:
    Name of your database.

    default: my_project

vm_user:
    Name of your Vagrant user.  If you did not specify, vagrant will default this to Vagrant.  This is fine, there is really no reason to change, unless you want every detail of your vagrant the same as your production server.

    default: vagrant

django_login_username:
    The username that will login to the django/wagtail admin dashboard

django_login_password:
    The password that will login to the django/wagtail admin dashboard

author_name:
    Who created this project?  Either your company name, or your personal name.  Spaces are fine here.

author_email:
    Email of the corporation of person who will be maintaining / building this project.  Correctly formatted email address required.

domain_name:
    The URL of the website that this site will live at.  No worries if you don't have it yet.  You can specify later.

license:
    Which license do you want to build this project under?  MIT, Apache and GPL are very permissive Open Source licenses.  No License you are essentially making this closed source - no one can use unless you expressly give them permission.

current_year:
    The current calendar year.  This is used in your licenses.




.. _`django starter`: https://github.com/tkjone/django-starter
