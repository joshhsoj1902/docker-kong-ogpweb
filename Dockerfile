FROM ubuntu:16.04@sha256:9ee3b83bcaa383e5e3b657f042f4034c92cdd50c03f73166c145c9ceaea9ba7c as snippets

ADD build-gomplate-snippets.sh .
COPY config_templates/xml_snippets xml_snippets
RUN mkdir gomplate_snippets \
    && sh build-gomplate-snippets.sh
RUN cat gomplate_snippets/snippets.json


FROM hairyhenderson/gomplate:v2.0.0-slim@sha256:c4dd5588cfc4a27ec59a1cb47edea36f421ac7803028781a5d81ca0bdba66967 as config

ADD gomplate-build.sh .

COPY config_templates/templates templates

COPY --from=snippets gomplate_snippets/ ./gomplate_snippets/

RUN mkdir server_configs \
    && chmod +x ./gomplate-build.sh \ 
    && sleep 1 \
    && ./gomplate-build.sh


FROM joshhsoj1902/docker-ogpweb:latest@sha256:ae4d72f3c902111d91c75eadb55cf44cb82831279100a5903f7e3d9add7722e8

#Only added for testing...
RUN apt-get update \
 && apt-get -y install tidy libxml2-utils

COPY www /var/www/html
COPY --from=config server_configs/ /var/www/html/modules/config_games/server_configs/

ADD validate-xml-config.sh /
RUN chmod 777 /validate-xml-config.sh
