FROM joshhsoj1902/docker-ogpweb

MAINTAINER joshhsoj1902

# Remove install file
RUN mv /var/www/html/install.php /var/www/html/install.php.bac

# Setup rsync server
RUN echo "kong.dustless.club" > /var/www/html/modules/gamemanager/rsync_sites_local.list

# Setup rsync games
RUN echo "openttd" > /var/www/html/modules/gamemanager/rsync.list
RUN echo "terraria" > /var/www/html/modules/gamemanager/rsync.list
