#-------------------------------------------------------------
# CONFIGS DEV
#-------------------------------------------------------------

repo_name="{{ cookiecutter.repo_name }}"
project_name="src"
home_path="/home/vagrant"
repo_dir="${home_path}/${repo_name}"
app_dir="${repo_dir}/src"
django_reqs="${home_path}/${repo_name}/${project_name}/requirements/dev.txt"
virtualenv_dir="${home_path}/.virtualenvs"
db_engine="{{cookiecutter.db_engine}}"
db_user="{{cookiecutter.db_user}}"
db_password="{{cookiecutter.db_password}}"
db_host="{{cookiecutter.db_host}}"
db_name="{{cookiecutter.db_name}}"
vm_user="{{cookiecutter.vm_user}}"
django_user="{{cookiecutter.django_login_username}}"
django_pass="{{cookiecutter.django_login_password}}"
python_2="/usr/bin/python"
python_3="/usr/bin/python3"
software=(
    "python-pip"

    {% if cookiecutter.db_engine == "postgres" -%}

    "expect"
    "python-dev"
    "python3-dev"
    "postgresql"
    "postgresql-contrib"
    "libpq-dev"

    {% endif %}
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

logit "Setting Ubuntu Locales"
sudo locale-gen "en_US.UTF-8"
sudo dpkg-reconfigure locales
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

logit "Add locale settings to the end of /etc/environment"
sed -e '$a\
\
# locale settings\
LC_ALL=en_US.UTF-8\
LANG=en_US.UTF-8
' /etc/environment

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

logit "Installing virtualenvwrapper"
sudo pip install virtualenvwrapper

#-------------------------------------------------------------
# CONFIGURE VIRTUALENVWRAPPER
#-------------------------------------------------------------

logit "configuring .profile"
sed -i '10i # virtualenvwrapper configuration' ~/.profile
sed -i '11i export WORKON_HOME=/home/vagrant/.virtualenvs' ~/.profile
sed -i '12i source /usr/local/bin/virtualenvwrapper.sh' ~/.profile

logit "Reloading .profile"
source ~/.profile


{% if cookiecutter.db_engine == "postgres" -%}
#-------------------------------------------------------------
# SETUP DATABASE
#-------------------------------------------------------------

logit "setting up project database"
expect ${repo_dir}/tools/vagrant/expects/set_db.exp ${db_name} ${db_user} ${db_password} ${vm_user}

{% endif %}
#-------------------------------------------------------------
# CREATE VIRTUAL ENVIRONMENTS
#-------------------------------------------------------------

# INFO: initialize virtualenvironment - Python 2
logit "Creating ${repo_name} Python 2 virtual environment"
mkvirtualenv -r ${django_reqs} ${repo_name}2

# INFO: initialize virtualenvironment - Python 3
logit "Creating ${repo_name} Python 3 virtual environment..."
mkvirtualenv -r ${django_reqs} --python=${python_3} ${repo_name}3

# setup the python path and django_settings_module
logit "Configuring postactivate hook for virtualenv..."
cat << EOF >> ${virtualenv_dir}/postactivate
    # django settings
    export PYTHONPATH="$PYTHONPATH:${repo_dir}"
    export DJANGO_SETTINGS_MODULE="config.settings.dev"
EOF

# remove django_settings_module when user deactivate virtualenv
logit "Configuring postdeactivate hook for virtualenv..."
cat << EOF >> ${virtualenv_dir}/postdeactivate
    # unset project environment variables
    unset DJANGO_SETTINGS_MODULE
EOF

#-------------------------------------------------------------
# DJANGO SETUP
#-------------------------------------------------------------

# INFO: activate virtualenv
logit "Activate virtual environment"
source ${virtualenv_dir}/${repo_name}3/bin/activate

# INFO: move into django project
logit "Changing ${repo_name} folder"
cd ${repo_name}

# INFO: log user into virtualenv when they ssh into VM
logit "Configuring .bashrc"
cat << EOF >> /home/vagrant/.bashrc
    # login to virtualenv
    workon ${repo_name}3
    # project directory
    cd ${app_dir}
    export PYTHONDONTWRITEBYTECODE=1
EOF

# INFO: move into django project
logit "Changing to ${repo_name} directory"
cd ${repo_dir}

# INFO: build initial Django DB tables
logit "Migrating Django DB"
python ${app_dir}/manage.py migrate

#-------------------------------------------------------------
# CREATE SUPER USER
#-------------------------------------------------------------
# createsuperuser
logit "creating project superuser"
expect $repo_dir/tools/vagrant/expects/set_admin.exp ${vm_user} ${repo_name} ${repo_dir} ${django_user} {{cookiecutter.email}} ${django_pass}

logit "provisioning complete"
