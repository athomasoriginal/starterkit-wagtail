#!/bin/sh
## This script is used for django development and is responsible for
## generating a .env file and initializing the DJANGO_DATABASE_URL

#    SUMMARY:  Logging Utility
#    EXAMPLE:  logit "This is a console log"
#    PARAMETERS:
#       MSG - enter a string that you want logit to log
logit () {
    echo -e "${log_color} $1"
}

# maybe do a check for where we currently are so when this script is run, and if the
# user ran it from the wrong location, we will find the right place to put it in this project

logit "Generating hosts ip address"
host_ip_address=$(ipconfig getifaddr en0)

env_variables=(
  DJANGO_DATABASE_URL={{cookiecutter.db_engine}}://{{cookiecutter.db_user}}:{{cookiecutter.db_password}}@${host_ip_address}/{{cookiecutter.db_name}}
)

logit "Create .env file"
touch .env

# check if the file already exists, and if it does, only update the DJANGO_DATABASE_URL
# instead of creating the file from scratch
# https://blog.ed.gs/2016/01/26/os-x-sed-invalid-command-code/
logit "Populating .env file"
for i in "${env_variables[@]}"
do
   logit "Adding $i variable"
   echo $i >> .env
done
