#!/bin/sh -l

echo "Deploying to Zendesk..."

PASSWORD="\"password\""
APP_ID="\"app_id\""


for FILE in ./*.zat;
do
    cp $FILE .zat;
    if  grep -q "$APP_ID" "$FILE" ; then
        echo "App ID detected, running update" ; 
        zat clean
        zat update
    elif grep -q "$PASSWORD" "$FILE" ; then
        echo "No existing APP ID detected, creating new app." ; 
        zat clean
        zat create
    else
        echo "Can't deploy. Please check your .zat file" ; 
    fi
    rm -f .zat
done
