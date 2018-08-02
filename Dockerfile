FROM ubuntu:16.04@sha256:da6fba872ef36657a66384ffb2c2b5b5dc1672ec5f3b310a613c0ceb6f9b299a as snippets

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


FROM joshhsoj1902/docker-ogpweb:latest@sha256:d0d70820134535dda39fa13ab355a0c2c5c5219a0df079007dd7473511b80d7c

# Remove templates that I'll never need
RUN cd "/var/www/html/modules/config_games/server_configs" \
  && rm *win* \
  && rm zps.xml xonotic*.xml wolfrtcw*.xml wolfet*.xml \
  && rm warsow*.xml vicecitymp*.xml ventrilo*.xml vbox*.xml \
  && rm ut3*.xml ut2004*.xml urban*.xml unreal*.xml track*.xml \
  && rm tfc.xml teamspeak*.xml squad*.xml soldat*.xml smokin*.xml \
  && rm shoutcast*.xml shootmania*.xml sanandreasmp*.xml rust*.xml \
  && rm ror*.xml ricochet*.xml quake*.xml nuclear*.xml nmrih*.xml \
  && rm nexuiz*.xml natural*.xml multitheftauto*.xml mohsp*.xml \
  && rm pvkii*.xml mohaa*.xml tf2.xml \
  && rm mafia*.xml jedi*.xml jcmp*.xml ivmp*.xml insurgency*.xml \
  && rm hurtworld*.xml hidden*.xml freecol*.xml fistful*.xml fgms*.xml \
  && rm esmod*.xml dystopia*.xml dontstarve*.xml doi.xml dods.xml dod.xml \
  && rm dmc.xml dayz*.xml czero*.xml cspro*.xml csgo*.xml cs2d*.xml \
  && rm counterstrike*.xml callofduty*.xml brain*.xml blood*.xml \
  && rm big*.xml bf*.xml avorion*.xml assettocorsa*.xml arma*.xml \
  && rm aoc*.xml Synergy*.xml Smashball*.xml

#Only added for testing...
RUN apt-get update \
 && apt-get -y install tidy libxml2-utils

COPY www /var/www/html
COPY --from=config server_configs/ /var/www/html/modules/config_games/server_configs/

ADD validate-xml-config.sh /
RUN chmod 777 /validate-xml-config.sh
