FROM kohlby/base:latest

RUN set -x && \
    apt-get --quiet --yes update && \
    apt-get --quiet --yes install curl apt-transport-https && \
    curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    echo 'deb https://deb.nodesource.com/node_5.x trusty main' > /etc/apt/sources.list.d/nodesource.list && \
    echo 'deb-src https://deb.nodesource.com/node_5.x trusty main' >> /etc/apt/sources.list.d/nodesource.list && \
    apt-get --quiet --yes update && \
    apt-get --quiet --yes install nodejs && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

ENV PATH "./node_modules/.bin:$PATH"

RUN set -x && \
    groupadd --gid 2000 media && \
    useradd --uid 2100 --no-create-home --groups media adrien
USER root

WORKDIR /tmp
ADD npm-shrinkwrap.json /tmp/npm-shrinkwrap.json
ADD package.json /tmp/package.json
RUN npm install

COPY . /app/resume
WORKDIR /app/resume

RUN set -x && \
    mv /tmp/node_modules /app/resume && \
    chown -R adrien:media /app/resume && \
    resume export --format html --theme slick dist/index.html && \
    gzip --keep --best dist/index.html

ENV SHR_EXEC_MODE development
ENV SHR_EXEC_USER adrien

CMD ["node", "index.js"]
