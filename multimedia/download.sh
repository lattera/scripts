#!/usr/local/bin/bash

year=$(/bin/date +%Y)
month=$(/bin/date +%m)
day=$(/bin/date +%d)

function download
{
	name=$1
	url=$2
	duration=$3
	kbps=$4

	if [ ! -d /home/shawn/Podcasts/$name/$year/$month ]
	then
		/bin/mkdir -p /home/shawn/Podcasts/$name/$year/$month
	fi

	/usr/local/bin/vlc -I dummy -vvv --run-time=$duration "$url" ":sout=#transcode{vcodec=none,acodec=vorb,ab=$kbps,channels=2,samplerate=44100}:file{dst=/home/shawn/Podcasts/$name/$year/$month/$day.ogg}" :no-sout-rtp-sap :no-sout-standard-sap :ttl=1 :sout-keep -d > /tmp/podcast.log 2>&1
	pid=$!
	sleep $duration
	kill $pid
}
