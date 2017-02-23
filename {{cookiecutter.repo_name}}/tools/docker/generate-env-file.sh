# !/bin/sh
#
# SCRIPT: generate-env-file
# AUTHOR: tkjone
# LAST-UPDATED: Feb 11, 2017
# PLATFORM: OSX, Linux
#
# USAGE: source ./path/to/generate-env-file.sh
#
# DESCRIPTION: This script will create a .env file and populate it with the required
#              environment variables that you set inside this script.  If you already
#              have a .env file, this script will dynamically grab your IP address
#              and update the environment variables that you specify.  For example,
#              if you change work locations and your IP address changes, you would
#              need to update your variable IP_ADDR=102.39.9.28 to reflect that.
#              This script will do that for you.
#


# ==============================================================================
# FUNCTIONS
# ==============================================================================

# -----------------------------------------------------------------------------
# SUMMARY: Logger
# FORM: logit <msg>
# EXAMPLE: logit "This is a console log"
# PARAMETERS:  msg - enter a string that you want logit to log
#
# -----------------------------------------------------------------------------

logit () {
    echo -e "${log_color} [INFO] $1"
}

log_color="\e[00;34m" # blue

# -----------------------------------------------------------------------------
# SUMMARY:  create a file
# FORM:  createFile <filename>
# EXAMPLE: createFile .env
# ARGUMENTS: filename - $1 - the name of the file you want to create
#
# -----------------------------------------------------------------------------

createFile() {
  logit "Creating .env file"
  touch $1
}

# -----------------------------------------------------------------------------
# SUMMARY:  loop over variables and add to file
# FORM:  writeEnvVariables <list> <fileName>
# EXAMPLE: createFile ${writeEnvVariables} .env
# PARAMETERS: list - $1 - provide a list
#             fileName - $2 - provide name of file to write too
#
# NOTES:  http://askubuntu.com/questions/674333/how-to-pass-an-array-as-function-argument
#         using printf because echo will not consistently print to a new line.
#         Not using sed because the variable that will need to be added to the
#         list will have characters that require escaping and no way to dynamically
#         fix this.  There is something strange going on when passing an array
#         as an argument to a function which makes it difficult to get each item
#         in the array to print on its own line
#
# -----------------------------------------------------------------------------

writeEnvVariables() {
  host_ip_address=$(ipconfig getifaddr en0)
  env_variables=(
    DJANGO_DATABASE_URL=postgres://{{cookiecutter.db_user}}:{{cookiecutter.db_password}}@${host_ip_address}/{{cookiecutter.db_name}}
    DJANGO_DEBUG=True
  )
  file="$1"

  logit "writing env variables to $file"

  printf "%s\n" "${env_variables[@]}" >> $file
}

# -----------------------------------------------------------------------------
# SUMMARY: change variable in file
# FORM: updateEnvVariable <varToFind> <varToReplace>
# EXAMPLE: updateEnvVariable DJANGO_DATABASE_URL DJANGO_DATABASE_URL=updated
# PARAMETERS: env_variable - $1 - DJANGO_DATABASE_URL
#             file_name - $2 - file to search in

# NOTES: http://www.grymoire.com/Unix/Sed.html#uh-4a
#        https://www.safaribooksonline.com/library/view/regular-expressions-cookbook/9780596802837/ch07s16.html
#
# -----------------------------------------------------------------------------

updateEnvVariable() {
  env_variable="$1"
  file_name="$2"

  logit "Updated $env_variable variable"
  line_number=$(grep -n "$env_variable" "$file_name" | cut -f1 -d:)
  new_ip_address=$(ipconfig getifaddr en0)

  # replace the ip address on specific line -E seems to be OSX specific
  sed -i '' -E "$line_number s/([0-9]{1,3}\.){3}[0-9]{1,3}/$new_ip_address/" $file_name
}

# -----------------------------------------------------------------------------
# SUMMARY:  check where the user ran this script
# FORM:  currentWorkingDir <expectedDirName>
# EXAMPLE: currentWorkingDir test.sarah
# PARAMETERS: directory - $1 - directory user should be in when running script
#
# NOTES: This script is going to return true (0) or false (1).
#
# -----------------------------------------------------------------------------

currentWorkingDir() {
  full_path=$(pwd)
  current_working_dir=$(basename ${full_path})

  if [ ${current_working_dir} != $1 ]; then
     return 1
  fi

  return 0
}

# ==============================================================================
# MAIN
# ==============================================================================

# check if user ran script from correct directory
if ! currentWorkingDir client; then
  logit "----------------------------------------------------------------------"
  logit "Please run this script from client dir"
  logit "----------------------------------------------------------------------"
  return
fi

# check if file exists and if it does exist do not rewrite the file
# just update the IP_ADDR
if [ ! -f .env ]; then
  createFile .env

  writeEnvVariables .env
else
  updateEnvVariable DJANGO_DATABASE_URL ./src/.env
fi
