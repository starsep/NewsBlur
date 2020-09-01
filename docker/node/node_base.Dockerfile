FROM node:14.4.0
WORKDIR /usr/src/app
RUN       set -ex \
          && rundDeps=' \
                  libpq5 \
                  libjpeg62 \
                  libxslt1.1 \
                            ' \
          && buildDeps=' \
                    patch \
                    python-dev \
                    gfortran \
                    lib32ncurses5-dev  \
                    libblas-dev \
                    libffi-dev \
                    libjpeg-dev \
                    default-libmysqlclient-dev \
                    libpq-dev \
                    libreadline6-dev \
                    liblapack-dev \
                    libxml2-dev \
                    libxslt1-dev \
                    ncurses-dev \
                    zlib1g-dev \
                            ' \
            && apt-get update \
            && apt-get install -y $rundDeps $buildDeps --no-install-recommends \
            && pip install -r requirements.txt \
            && apt-get purge -y --auto-remove ${buildDeps} \
            && rm -rf /var/lib/apt/lists/*

COPY ./node /usr/src/app/
RUN npm install