#!/bin/sh
for f in templates/*.xml
do
    basename=$(basename "$f")
    filename="${basename%.*}"
    filenameagain="${filename%.*}"

    gomplate -d snippets=file://./gomplate_snippets/snippets.json \
            --template common=./templates/common/ \
            -f templates/$basename \
            -o server_configs/$filenameagain.xml

done