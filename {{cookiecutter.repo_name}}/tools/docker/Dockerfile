## Dockerfile
## Dockerfile for startkit.wagtail which is used to build the development
## container for starterkit.wagtail.  Note that we do not need to run
## apt-get update because this is being run in our base image:
## https://github.com/docker-library/python/blob/7eca63adca38729424a9bab957f006f5caad870f/3.6/Dockerfile

# base image
FROM python:3.6

# fills out the author information for your image
MAINTAINER Thomas Mattacchione

# environment variables
# http://www.sudhirwarrier.com/python-unbuffered/
ENV PYTHONUNBUFFERED 1

# copy over requirements files and create a new group called admin, also
# create a new user called admin with group admin
# guide to useradd http://www.tecmint.com/add-users-in-linux/
COPY ./src/requirements /requirements
RUN pip install -r /requirements/dev.txt \
  && groupadd -r admin \
  && useradd -g admin -ms /bin/bash admin

COPY ./tools/docker/start-dev.sh /start-dev.sh
RUN sed -i 's/\r//' /start-dev.sh
RUN chmod +x /start-dev.sh

WORKDIR /src

# switch to admin user
USER admin

CMD ["/start-dev.sh"]
