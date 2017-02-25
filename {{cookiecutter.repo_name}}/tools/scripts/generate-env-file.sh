# !/bin/sh
#
# SCRIPT: generate-env-file
# AUTHOR: tkjone
# PLATFORM: OSX, Linux
#
# USAGE: source ./path/to/generate-env-file
#
# DESCRIPTION: This script will create a .env file and populate it with the required
#              environment variables that you set inside this script.  If you already
#              have a .env file, this script will dynamically grab your IP address
#              and update the environment variables that you specify.  For example,
#              if you change work locations and your IP address changes, you would
#              need to update your variable IP_ADDR=102.39.9.28 to reflect that.
#              This script will do that for you.
#


# import utility function
source $(dirname "$0")/utils.sh

#
# SUMMARY:  loop over variables and add to file
# FORM:  writeEnvVariables <list> <fileName>
# EXAMPLE: writeEnvVariables env.example .env
# PARAMETERS: env_variables_file - $1 - file with env variables
#             file - $2 - file to write contents of env_variables_file to
#

writeEnvVariables() {
  # arguments
  env_variables_file="$1"
  file="$2"

  logit "writing env variables to $file"

  # copy contents of one file to another
  cat $env_variables_file >> $file
}


#
# MAIN
#

# check if user ran script from the {{cookiecutter.repo_name}} directory
if ! currentWorkingDir {{cookiecutter.repo_name}}; then
  logit "----------------------------------------------------------------------"
  logit "Please run this script from {{cookiecutter.repo_name}} dir"
  logit "----------------------------------------------------------------------"
  return
fi

# generate env file and populate with environment variables
createFile ./src/.env

writeEnvVariables env.example ./src/.env
