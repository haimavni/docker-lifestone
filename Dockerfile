FROM python:3-slim-stretch

ENV WEB2PY_ROOT=/opt/web2py

# overridable environment variables
ENV WEB2PY_VERSION=
ENV WEB2PY_PASSWORD=
ENV WEB2PY_ADMIN_SECURITY_BYPASS=
ENV UWSGI_OPTIONS=

WORKDIR $WEB2PY_ROOT
# COPY app $WEB2PY_ROOT

RUN apt-get update && apt-get -y install \
    gcc \
    git \
    libpcre3-dev \
    libpq-dev \
    build-essential
    # python2-dev

RUN git clone https://github.com/haimavni/lifestone-web2py.git ${WEB2PY_ROOT}
RUN pip install uwsgi psycopg2-binary 
RUN pip install beautifulsoup4
RUN pip install langdetect
RUN pip install oauthlib
RUN pip install Pillow
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

RUN git clone https://github.com/haimavni/place_stories_server.git $WEB2PY_ROOT/../tol_master
COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "http" ]
USER web2py

EXPOSE 8080 9090