FROM ubuntu:16.04 as snippets

ADD build-gomplate-snippets.sh .
COPY config_templates/xml_snippets xml_snippets
RUN mkdir gomplate_snippets \
    && sh build-gomplate-snippets.sh


FROM hairyhenderson/gomplate as config

COPY config_templates/templates templates

COPY --from=snippets gomplate_snippets/ ./gomplate_snippets/

RUN /gomplate -d snippets=file://./gomplate_snippets/snippets.json \
            -f templates/lgsm_docker.tmpl.xml \
            -o lgsm_docker_foo.xml

RUN cat lgsm_docker_foo.xml

RUN exit -1

FROM joshhsoj1902/docker-ogpweb

#Only added for testing...
RUN apt-get update \
 && apt-get -y install tidy libxml2-utils

# Setup rsync server
RUN echo "kong.dustless.club" > /var/www/html/modules/gamemanager/rsync_sites_local.list

# Remove default rsync servers
RUN echo "" > /var/www/html/modules/gamemanager/rsync_sites.list

# Setup rsync games
RUN echo "openttd" >> /var/www/html/modules/gamemanager/rsync.list
RUN echo "terraria" >> /var/www/html/modules/gamemanager/rsync.list

COPY www /var/www/html
COPY config_templates /var/www/html/modules/config_games/server_configs/

ADD validate-xml-config.sh /
RUN chmod 777 /validate-xml-config.sh
