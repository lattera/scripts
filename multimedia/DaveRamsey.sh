#!/usr/local/bin/bash

. /home/shawn/Podcasts/download.sh

podname="DaveRamsey"

podcast=$(/usr/local/bin/wget -q -O - http://www.daveramsey.com/radio/home/the_dave_ramsey_show_live.asx | /usr/bin/grep mms | /usr/bin/sed 's/<.*=\ "//g;s/".*//g')

download $podname $podcast 10800 128
