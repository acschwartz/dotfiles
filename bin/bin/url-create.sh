#!/bin/bash

# ==============================================================================
##  URL CREATE 

# $ url-create.sh <name> <url>

## creates the file: name.url
# ==============================================================================

## Under the hood, a .url file is just a text file with the following contents:
# [InternetShortcut]
# URL=https://helloworld.com/

# This script automates creation of the file in this format. 

## Source: https://superuser.com/questions/689441/how-do-i-create-a-url-file-on-os-x

#!/bin/bash
if [[ $# -le 1 || $# -ge 3 ]] ; then
    echo Usage: $0 '<namefile> <url>'
    echo
    echo Creates '<namefile>.url'.
    echo Openning '<namefile>.url' in Finder, under OSX, will open '<url>' in the default browser.
    exit 1
fi

file="$1.url"
url=$2
echo '[InternetShortcut]' > "$file"
echo -n 'URL=' >> "$file"
echo $url >> "$file"
#echo 'IconIndex=0' >> "$file"