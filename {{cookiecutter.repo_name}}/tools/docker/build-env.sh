#!/bin/sh
## =============================================================================
## This script is used for django development and is responsible for
## generating a .env file and initializing the DJANGO_DATABASE_URL
## further note for those expanding on this script - please use $() for
## variables over backticks `` - backticks are easier to mess up ;)
## =============================================================================

# Helpers
# ==============================================================================

# SUMMARY: Logging Utility
# FORM: logit <msg>
# EXAMPLE: logit "This is a console log"
# PARAMETERS:
#   MSG - enter a string that you want logit to log
logit () {
    echo -e "${log_color} [INFO] $1"
}

log_color="\e[00;34m" # blue

# SUMMARY:  create a file
# FORM:  createFile <filename>
# EXAMPLE: createFile .env
# PARAMETERS:
#   filename - $1 - the name of the file you want to create
createFile() {
  logit "Creating .env file"
  touch $1
}

# SUMMARY:  loop over variables and add to file
# FORM:  writeEnvVariables <list> <fileName>
# EXAMPLE: createFile ${writeEnvVariables} .env
# PARAMETERS:
#   list - $1 - provide a list
#   fileName - $2 - provide name of file to write too
# EXTRA: Always pass the first argument as a list, which means it should
#        be written with a ${} for shell script to see its a variable
writeEnvVariables() {
  logit "Writing .env variables"

  for i in "$1"
  do
     logit "Adding $i variable"
     echo $i >> $2
  done
}

# SUMMARY:  change variable in file
# FORM:  updateEnvVariable <varToFind> <varToReplace>
# EXAMPLE: updateEnvVariable DJANGO_DATABASE_URL DJANGO_DATABASE_URL=updated
# PARAMETERS:
#   word to match - $1 - DJANGO_DATABASE_URL
#   word to replace match with - $2 - provide name of file to write too
#   file_name - $3 - file to search in
# http://www.grymoire.com/Unix/Sed.html#uh-4a
# https://www.safaribooksonline.com/library/view/regular-expressions-cookbook/9780596802837/ch07s16.html
updateEnvVariable() {
  env_variable="$1"
  file_name="$2"

  logit "Updated $env_variable variable"
  line_number=$(grep -n "$env_variable" "$file_name" | cut -f1 -d:)
  new_ip_address=$(ipconfig getifaddr en0)

  # replace the ip address on specific line -E seems to be OSX specific
  sed -i '' -E "$line_number s/([0-9]{1,3}\.){3}[0-9]{1,3}/$new_ip_address/" $file_name
}

# SUMMARY:  check where the user ran this script
# FORM:  currentWorkingDir <expectedDirName>
# EXAMPLE: currentWorkingDir test.sarah
# RETURN: return true (0) or false (1)
currentWorkingDir() {
  full_path=$(pwd)
  current_working_dir=$(basename ${full_path})

  if [ ${current_working_dir} != $1 ]; then
     return 1
  fi

  return 0
}

# Main
# ==============================================================================

# check if user ran script from correct directory
if ! currentWorkingDir {{cookiecutter.repo_name}}; then
  logit "----------------------------------------------------------------------"
  logit "Please run this script from {{cookiecutter.repo_name}} dir"
  logit "----------------------------------------------------------------------"
  return
fi

# environment variables
logit "Get hosts ip address"
host_ip_address=$(ipconfig getifaddr en0)
env_variables=(
  DJANGO_DATABASE_URL=postgres://{{cookiecutter.db_user}}:{{cookiecutter.db_password}}@${host_ip_address}/{{cookiecutter.db_name}}
  DJANGO_DEBUG=True
)

# check if file exists and if it does exist do not rewrite the file
# just update the DJANGO_DATABASE-URL
if [ ! -f ./src/.env ]; then
  createFile ./src/.env

  writeEnvVariables ${env_variables} ./src/.env
else
  updateEnvVariable DJANGO_DATABASE_URL ${env_variables[1]} ./src/.env
fi
