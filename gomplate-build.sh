#!/bin/sh
for f in templates/*
do
    basename=$(basename "$f")
    filename="${basename%.*}"
    filenameagain="${filename%.*}"

    /gomplate -d snippets=file://./gomplate_snippets/snippets.json \
            -f templates/$basename \
            -o server_configs/$filenameagain.xml

done