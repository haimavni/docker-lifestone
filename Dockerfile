FROM python:2-slim-stretch

ENV WEB2PY_ROOT=/opt/web2py

# overridable environment variables
ENV WEB2PY_VERSION=
ENV WEB2PY_PASSWORD=
ENV WEB2PY_ADMIN_SECURITY_BYPASS=
ENV UWSGI_OPTIONS=

WORKDIR $WEB2PY_ROOT
COPY app $WEB2PY_ROOT

RUN apt-get update && apt-get -y install \
    gcc \
    git \
    libpcre3-dev \
    libpq-dev \
    build-essential
    # python2-dev
RUN pip install uwsgi psycopg2-binary 
RUN groupadd -g 1000 web2py \
 && useradd -r -u 1000 -g web2py web2py \
 && chown -R web2py:web2py $WEB2PY_ROOT

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "http" ]
USER web2py

EXPOSE 8080 9090