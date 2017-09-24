#!/bin/bash
set -e

for i in /var/www/html/modules/config_games/server_configs/*.xml; do # Whitespace-safe but not recursive.
  xmllint --schema /var/www/html/modules/config_games/schema_server_config.xml --noout "$i"
done
