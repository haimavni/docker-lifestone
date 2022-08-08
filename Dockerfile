FROM python:3-slim-buster

ENV WEB2PY_ROOT=/opt/web2py
ENV APP_LOCATION=/opt/tol_master
ENV UI_SRC_LOCATION=/opt/aurelia_src
ENV UI_LOCATION=$APP_LOCATION/static/aurelia

# overridable environment variables
ENV WEB2PY_VERSION=
ENV WEB2PY_PASSWORD=
ENV WEB2PY_ADMIN_SECURITY_BYPASS=
ENV UWSGI_OPTIONS=

WORKDIR $WEB2PY_ROOT
COPY app $WEB2PY_ROOT

RUN apt-get update && apt-get upgrade && apt-get -y install \
    sudo \
    curl \
    gcc \
    git \
    libpcre3-dev \
    libpq-dev \
    build-essential \
    postgresql \
    postgresql-client
    # python2-dev
RUN curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash -
RUN apt-get install -y nodejs

RUN pip install --upgrade pip
RUN pip install uwsgi psycopg2-binary 
RUN pip install beautifulsoup4
RUN pip install langdetect
RUN pip install oauthlib
#failed
#RUN pip install Pillow
RUN pip install pybktree
RUN pip install pycountry
RUN pip install qrcode
RUN pip install redmail
RUN pip install requests
RUN pip install simplejson
RUN pip install tornado
RUN pip install websockets
RUN pip install youtube-dl


RUN groupadd -g 1000 web2py \
 && useradd -r -u 1000 -g web2py web2py \
 && chown -R web2py:web2py $WEB2PY_ROOT

RUN git clone https://github.com/haimavni/place_stories_server.git $APP_LOCATION
RUN git clone https://github.com/haimavni/gbs.git $UI_SRC_LOCATION
RUN npm install aurelia-cli -g
RUN cd $UI_SRC_LOCATION
RUN au install
RUN au build
RUN mkdir $UI_LOCATION
RUN cp $UI_SRC_LOCATION/index.html $UI_LOCATION
#failed
# RUN cp -a $UI_SRC_LOCATION/scripts $UI_LOCATION/

#RUN systemctl start postgresql
#$RUN sudo serivce postgresql start
#fails because the postgres service is not started
#RUN sudo -u postgres psql --command="CREATE USER lifestone WITH PASSWORD 'V3geHanu';"

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "http" ]
USER web2py

EXPOSE 8080 9090