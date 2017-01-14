## Dockerfile
## Dockerfile for startkit.wagtail which is used to build the development
## container for starterkit.wagtail.  Note that we do not need to run
## apt-get update because this is being run in our base image:
## https://github.com/docker-library/python/blob/7eca63adca38729424a9bab957f006f5caad870f/3.6/Dockerfile

# base image
FROM python:3.6

# fills out the author information for your image
MAINTAINER Thomas Mattacchione

# create an admin user and run the following build instructions as admin
# guide to useradd http://www.tecmint.com/add-users-in-linux/
RUN useradd -ms /bin/bash admin
USER admin

# environment variables
# http://www.sudhirwarrier.com/python-unbuffered/
ENV PYTHONUNBUFFERED 1

# django app tasks
COPY ./src/requirements /requirements
RUN pip install -r /requirements/dev.txt
WORKDIR /src

# initial command to run when container starts
CMD ["./start-dev.sh"]
