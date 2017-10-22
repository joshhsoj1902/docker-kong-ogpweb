FROM ubuntu:16.04 as snippets

ADD build-gomplate-snippets.sh .
COPY config_templates/xml_snippets xml_snippets
RUN mkdir gomplate_snippets \
    && sh build-gomplate-snippets.sh


FROM hairyhenderson/gomplate as config

ENTRYPOINT [ "sh" ]

ADD gomplate-build.sh .

COPY config_templates/templates templates

COPY --from=snippets gomplate_snippets/ ./gomplate_snippets/

RUN mkdir server_configs \
    && chmod +x ./gomplate-build.sh \ 
    &&./gomplate-build.sh

RUN ls -ltr server_configs


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
COPY --from=config server_configs/ /var/www/html/modules/config_games/server_configs/

# COPY config_templates /var/www/html/modules/config_games/server_configs/

RUN ls -ltr /var/www/html/modules/config_games/server_configs/

RUN cat /var/www/html/modules/config_games/server_configs/lgsm_docker.xml

ADD validate-xml-config.sh /
RUN chmod 777 /validate-xml-config.sh
