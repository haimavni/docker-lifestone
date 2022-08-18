#CREATE USER $POSTGRES_USER WITH PASSWORD '$POSTGRES_PASSWORD';
CREATE USER "lifestone" WITH PASSWORD 'V3geHanu';

CREATE DATABASE adm;
GRANT ALL PRIVILEGES ON DATABASE adm TO 'lifestone';

CREATE DATABASE test;
GRANT ALL PRIVILEGES ON DATABASE test TO $POSTGRES_USER;

-- TODO: add lifestone user
-- RUN systemctl start postgresql
-- $RUN sudo serivce postgresql start
-- #fails because the postgres service is not started
-- RUN sudo -u postgres psql --command="CREATE USER lifestone WITH PASSWORD 'V3geHanu';"