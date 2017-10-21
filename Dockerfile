# FROM python:latest as configs

# ADD xmlcombine.xml .

# COPY modules/config_games/server_configs configs

# RUN python xmlcombine.py ?.xml > combined.xml


FROM joshhsoj1902/docker-ogpweb

MAINTAINER joshhsoj1902

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
