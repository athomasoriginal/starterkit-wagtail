# base image
FROM python:3.6

# fills out the author information for your image
MAINTAINER Thomas Mattacchione

# environment variables - http://www.sudhirwarrier.com/python-unbuffered/
ENV PYTHONUNBUFFERED 1
ENV APP_HOME /app

# create non-root user
RUN groupadd -r admin \
    && useradd -r -g admin admin

# set and creating a workin dir
WORKDIR $APP_HOME

# install python dependencies
COPY ./src/requirements /app/requirements
RUN pip install --no-cache-dir -r /app/requirements/dev.txt

RUN chown -R admin /app

# copy source code
COPY . $APP_HOME

ENTRYPOINT ["./tools/docker/wagtail/entrypoint.sh"]
