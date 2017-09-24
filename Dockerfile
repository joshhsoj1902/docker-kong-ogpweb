FROM joshhsoj1902/docker-ogpweb

MAINTAINER joshhsoj1902

# Setup rsync server
RUN echo "kong.dustless.club" > /var/www/html/modules/gamemanager/rsync_sites_local.list

# Remove default rsync servers
RUN echo "" > /var/www/html/modules/gamemanager/rsync_sites.list

# Setup rsync games
RUN echo "openttd" >> /var/www/html/modules/gamemanager/rsync.list
RUN echo "terraria" >> /var/www/html/modules/gamemanager/rsync.list

COPY www /var/www/html
