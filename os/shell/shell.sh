#!/bin/sh

read a 
if [ "$a" == "y" || "$a" == "Y"] 
then 
    echo "YES" 
elif [ "$a" == "n" || "$a" == "N"] 
then 
    echo "NO" 
fi
