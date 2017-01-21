#-------------------------------------------------------------
# CONFIGS DEV
#-------------------------------------------------------------

repo_name="{{ cookiecutter.repo_name }}"
project_name="src"
home_path="/home/vagrant"
repo_dir="${home_path}/${repo_name}"
app_dir="${repo_dir}/src"
db_engine="postgres"
db_user="{{cookiecutter.db_user}}"
db_password="{{cookiecutter.db_password}}"
db_host="{{cookiecutter.db_host}}"
db_name="{{cookiecutter.db_name}}"
vm_user="{{cookiecutter.vm_user}}"
software=(
    "python-pip"
    "expect"
    "postgresql"
    "postgresql-contrib"
    "libpq-dev"
    "libjpeg-dev"
    "libtiff-dev"
    "zlib1g-dev"
    "libfreetype6-dev"
    "liblcms2-dev" )

log_color="\e[00;34m" # blue

#-------------------------------------------------------------
# UTILITIES
#-------------------------------------------------------------


#    SUMMARY:  Logging Utility
#    EXAMPLE:  logit "This is a console log"
#    PARAMETERS:
#       MSG - enter a string that you want logit to log
logit () {
    echo -e "${log_color} $1"
}


#-------------------------------------------------------------
# Locales
#-------------------------------------------------------------

logit "Set up locales"
sudo locale-gen en_US.UTF-8
sudo sed -i '$ a LANGUAGE="en_US.UTF-8"' /etc/default/locale
sudo sed -i '$ a LC_ALL="en_US.UTF-8"' /etc/default/locale

#-------------------------------------------------------------
# Update and Upgrade
#-------------------------------------------------------------

logit "Updating Ubuntu"
sudo apt-get update

logit "Upgrading Ubuntu"
sudo apt-get upgrade


#-------------------------------------------------------------
# INSTALL SOFTWARE
#-------------------------------------------------------------

logit "Installing software"
for i in "${software[@]}"
do
   logit "Installing $i"
   sudo apt-get install -y $i
done


#-------------------------------------------------------------
# SETUP DATABASE
#-------------------------------------------------------------

logit "setting up project database"
expect ${repo_dir}/tools/vagrant/expects/set_db.exp ${db_name} ${db_user} ${db_password} ${vm_user}


#-------------------------------------------------------------
# COMPLETION ACTIVITIES
#-------------------------------------------------------------

logit "------------------------------------------------------"

logit "provisioning complete"

logit "To run the development environment:"

logit "    vagrant ssh dev"

logit "------------------------------------------------------"

sed -i '1/
hello' .env

sed -i '' -e '$ a\
hi
' .env
