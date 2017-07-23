#!/bin/sh
## Start django
cd ./src
python manage.py migrate
python manage.py runserver 0.0.0.0:8000
