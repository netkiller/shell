#!/bin/bash
url=$1
curl -o /dev/null -s -w  %{time_connect}:%{time_starttransfer}:%{time_total}:%{time_namelookup}:%{speed_download} ${url}