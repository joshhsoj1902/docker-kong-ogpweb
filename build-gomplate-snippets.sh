#!/bin/bash
counter=0

echo "{" >> gomplate_snippets/snippets.json

for f in xml_snippets/*.xml
do
    echo "counter! "$counter

    if [ $counter -gt "0" ]; then
        echo "," >> gomplate_snippets/snippets.json

    fi
    basename=$(basename "$f")
    filename="${basename%.*}"
    echo "\"$filename\":\""$(cat xml_snippets/$filename.xml | base64 --wrap=0)"\"" >> gomplate_snippets/snippets.json
    counter=$((counter+1))
done

echo "}" >> gomplate_snippets/snippets.json
cat gomplate_snippets/snippets.json
