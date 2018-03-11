FROM ubuntu:16.04 as snippets

ADD build-gomplate-snippets.sh .
COPY config_templates/xml_snippets xml_snippets
RUN mkdir gomplate_snippets \
    && sh build-gomplate-snippets.sh
RUN cat gomplate_snippets/snippets.json


FROM hairyhenderson/gomplate:v2.0.0-slim as config

ADD gomplate-build.sh .

COPY config_templates/templates templates

COPY --from=snippets gomplate_snippets/ ./gomplate_snippets/

RUN mkdir server_configs \
    && chmod +x ./gomplate-build.sh \ 
    && sleep 1 \
    && ./gomplate-build.sh


FROM joshhsoj1902/docker-ogpweb

#Only added for testing...
RUN apt-get update \
 && apt-get -y install tidy libxml2-utils

COPY www /var/www/html
COPY --from=config server_configs/ /var/www/html/modules/config_games/server_configs/

ADD validate-xml-config.sh /
RUN chmod 777 /validate-xml-config.sh
