#!/bin/bash

PASSFILE=nginx.password
[ ! -f $PASSFILE ] && touch $PASSFILE

while read username password
do
	htpasswd -b -d $PASSFILE $username $password
done << EOF
neo	FwJSYxD4WBzPr4CQvxI8HIbV0yDkQi
chen	2hsD3OgkeM4GPPcNYUceqL8ccMzXjU
bg7nyt	XAq7Zcln8dGCTIIKt8GwwEwqmCN8d1
netkiller	fcCIY3GaroTPCSW40XBrg0HNlmbLD7
neochen	DPSiWJtqUIaI2bUUobuX2PjdyzDGgI
EOF

