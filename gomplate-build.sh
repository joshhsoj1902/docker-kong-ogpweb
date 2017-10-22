#!/bin/sh
for f in templates/*
do
    basename=$(basename "$f")
    filename="${basename%.*}"
    filenameagain="${filename%.*}"

    
    echo "basename: "$basename
    echo "filename: "$filename
    # echo "filenameagain: "$filenameagain

    /gomplate -d snippets=file://./gomplate_snippets/snippets.json \
            -f templates/$basename \
            -o server_configs/$filenameagain.xml

    # echo "\"$filename\":\""$(cat config_templates/xml_snippets/$filename.xml | base64 --wrap=0)"\"" >> config_templates/gomplate_snippets/snippets.json
    # counter=$((counter+1))
done