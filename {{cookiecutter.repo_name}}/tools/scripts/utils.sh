
# !/bin/sh
#
# SCRIPT: utils
# AUTHOR: tkjone
# PLATFORM: OSX, Linux
#
# USAGE: source ./utils
#
#        logit 'I am the log function from a different file'
#
# DESCRIPTION: This file contains some functions that are not specific to any
#              one shell script.  For example, a logging function that can be
#              reused in any other shell script.  Thus, feel free to source this
#              in your other shell scripts.
#
#
# FUNCTIONS: logit
#            createFile
#            currentWorkingDir
#            getHostIp
#            updateEnvVariable


#
# UTILITY FUNCTIONS
#

#
# SUMMARY: Logger
# FORM: logit <msg>
# EXAMPLE: logit "This is a console log"
# PARAMETERS:  msg - enter a string that you want logit to log
#

log_color="\e[00;34m" # blue

function logit () {
    echo -e "${log_color} [INFO] $1"
}


#
# SUMMARY:  create a file
# FORM:  createFile <filename>
# EXAMPLE: createFile .env
# ARGUMENTS: filename - $1 - the name of the file you want to create
#

function createFile() {
  logit "Creating .env file"
  touch $1
}


# SUMMARY:  check where the user ran this script
# FORM:  currentWorkingDir <expectedDirName>
# EXAMPLE: currentWorkingDir test.sarah
# PARAMETERS: directory - $1 - directory user should be in when running script
#
# NOTES: This script is going to return true (0) or false (1).
#

function currentWorkingDir() {
  full_path=$(pwd)
  current_working_dir=$(basename ${full_path})

  if [ ${current_working_dir} != $1 ]; then
     return 1
  fi

  return 0
}

# SUMMARY:  check where the user ran this script
# FORM:  currentWorkingDir <expectedDirName>
# EXAMPLE: currentWorkingDir test.sarah
# PARAMETERS: directory - $1 - directory user should be in when running script
#
# NOTES: This script is going to return true (0) or false (1).
#        http://www.linuxjournal.com/content/return-values-bash-functions
#

function getHostIp() {
  local host_ip_address=$(ipconfig getifaddr en0)

  echo "$host_ip_address"
}

# SUMMARY: change variable in file
# FORM: updateEnvVariable <varToFind> <varToReplace>
# EXAMPLE: updateEnvVariable DJANGO_DATABASE_URL DJANGO_DATABASE_URL=updated
# PARAMETERS: env_variable - $1 - DJANGO_DATABASE_URL
#             file_name - $2 - file to search in
#
# DESCRIPTION:  Pass updateEnvVariable the name of the variable you want to
#               update and the file this variable is in.  This function will
#               find that variable and if it has an ip address will update it
#               with the host machines ip address
#
# NOTES: http://www.grymoire.com/Unix/Sed.html#uh-4a
#        https://www.safaribooksonline.com/library/view/regular-expressions-cookbook/9780596802837/ch07s16.html
#

updateEnvVariable() {
  # arguments
  env_variable="$1"
  file_name="$2"

  logit "Updated $env_variable variable"
  line_number=$(grep -n "$env_variable" "$file_name" | cut -f1 -d:)
  next_ip_address=$(getHostIp)

  # replace the ip address on specific line -E seems to be OSX specific
  sed -i '' -E "$line_number s/([0-9]{1,3}\.){3}[0-9]{1,3}/$next_ip_address/" $file_name
}
