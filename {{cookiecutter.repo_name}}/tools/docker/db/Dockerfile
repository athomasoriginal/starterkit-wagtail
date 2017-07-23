FROM postgres:9.6.1

ENV POSTGRES_USER=postgres

WORKDIR /docker-entrypoint-initdb.d

COPY ./tools/docker/db/init_user_db.sh /docker-entrypoint-initdb.d
