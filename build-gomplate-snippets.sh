#!/bin/bash
rm -rf config_templates/gomplate_snippets
mkdir config_templates/gomplate_snippets

counter=0

echo "{" >> config_templates/gomplate_snippets/snippets.json

for f in config_templates/xml_snippets/*.xml
do
    echo "counter! "$counter

    if [ $counter -gt "0" ]; then
        echo "," >> config_templates/gomplate_snippets/snippets.json

    fi
    basename=$(basename "$f")
    filename="${basename%.*}"
    echo "\"$filename\":\""$(cat config_templates/xml_snippets/$filename.xml | base64 --wrap=0)"\"" >> config_templates/gomplate_snippets/snippets.json
    counter=$((counter+1))
done

echo "}" >> config_templates/gomplate_snippets/snippets.json
cat config_templates/gomplate_snippets/snippets.json
