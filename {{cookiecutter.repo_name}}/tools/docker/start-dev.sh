#!/bin/sh
## This script is used for django development and is responsible for
## migrating our models to our database and running our python development
## server
python manage.py migrate
python manage.py runserver 0.0.0.0:8000
