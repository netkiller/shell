#!/bin/bash
ping -q -c 100 -f $1 | grep % | sed "s:.*\ \([0-9]\+\)%.*:\1:"
