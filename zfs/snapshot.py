#!/usr/local/bin/python

import os, time, sys

if len(sys.argv) < 2:
  print "USAGE: " + sys.argv[0] + " [frequent|hourly|daily|weekly|monthly]"
  exit(1)

date = time.strftime("%Y-%m-%d_%H.%M.%S")

datasets = []
for line in os.popen("zfs list | sed '1d' | awk '{print $1}'"):
  line = line.strip()
  datasets.append(line)

snapsettings = {}
for dataset in datasets:
  p = os.popen("zfs get -H -o value autosnap:" + sys.argv[1] + " " + dataset)
  line = p.readline().strip()
  snapsettings[dataset] = {"autosnap": line}

for dataset in snapsettings:
  if snapsettings[dataset]["autosnap"] != "off":
    os.system("zfs snapshot " + dataset + "@" + date + ":autosnap:" + sys.argv[1])