#!/bin/bash

# Author: Sankshit Pandoh
# Please go through the info.md for more details

sudo echo "Checking system details"
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    *)          machine="UNKNOWN:${unameOut}"
esac
echo ${machine} " device found"

echo "Checking for nginx!!"
if ! which nginx > /dev/null 2>&1; 
    then
        echo "Nginx not installed!"
        echo "Installing nginx!"
        if [ "$machine" = "Mac" ];
            then
                brew install nginx
            else
                sudo apt isntall nginx
        fi
    else
        echo "Nginx already installed!"
fi

echo "Setting up nginx configuration file"
if [ "$machine" = "Mac" ];
    then 
        : > /usr/local/etc/nginx/nginx.conf
        cp ./nginx.conf /usr/local/etc/nginx/nginx.conf
    else 
        : > /etc/nginx/nginx.conf && cp ./nginx.conf /etc/nginx/nginx.conf
fi
echo "Configuration setup done"
echo "Reloading Nginx"

if [ "$machine" = "Mac" ];
    then 
        sudo nginx -s reload
    else 
        sudo service nginx reload 
    fi
echo "We are good to go!";


