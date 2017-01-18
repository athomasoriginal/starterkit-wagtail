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

  for i in "$1[@]"
  do
     logit "Adding $i variable"
     echo $i >> $2
  done
}

# SUMMARY:  change variable in file
# FORM:  updateEnvVariable <varToFind> <varToReplace>
# EXAMPLE: updateEnvVariable DJANGO_DATABASE_URL DJANGO_DATABASE_URL=updated
# PARAMETERS:
#   list - $1 - provide a list
#   fileName - $2 - provide name of file to write too
updateEnvVariable() {
  logit "Updated $1 variable"
  line_number=$(awk '/$1/{print NR}' .env)
  sed -i '' "$(echo $line_number)s/.*/$(echo $2)/" .env
}

# SUMMARY:  check where the user ran this script
# FORM:  currentWorkingDir <expectedDirName>
# EXAMPLE: currentWorkingDir {{cookiecutter.repo_name}}
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
  DJANGO_DATABASE_URL={{cookiecutter.db_engine}}://{{cookiecutter.db_user}}:{{cookiecutter.db_password}}@${host_ip_address}/{{cookiecutter.db_name}}
)

# check if file exists and if it does exist do not rewrite the file
# just update the DJANGO_DATABASE-URL
if [ ! -f .env ]; then
  createFile .env

  writeEnvVariables ${env_variables} .env
else
  updateEnvVariable DJANGO_DATABASE_URL ${env_variables[1]}
fi
