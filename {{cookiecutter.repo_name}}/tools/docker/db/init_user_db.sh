#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE ROLE {{cookiecutter.db_user}}  WITH SUPERUSER CREATEDB CREATEROLE LOGIN PASSWORD '{{cookiecutter.db_password}}';

    CREATE DATABASE {{cookiecutter.db_name}};

    GRANT ALL PRIVILEGES ON DATABASE {{cookiecutter.db_name}} TO {{cookiecutter.db_user}};
EOSQL
