CREATE USER $POSTGRES_USER WITH PASSWORD $POSTGRES_PASSWORD;

CREATE DATABASE myApp_dev;
GRANT ALL PRIVILEGES ON DATABASE myApp_dev TO myUser;

CREATE DATABASE myApp_test;
GRANT ALL PRIVILEGES ON DATABASE myApp_test TO myUser;

-- TODO: add lifestone user
-- RUN systemctl start postgresql
-- $RUN sudo serivce postgresql start
-- #fails because the postgres service is not started
-- RUN sudo -u postgres psql --command="CREATE USER lifestone WITH PASSWORD 'V3geHanu';"