domain=$1

spf=$(dig ${domain} txt | grep "v=spf1")

echo $spf

#echo $spf | egrep -o "\"(.+)\"" 

for host in $(echo $spf | egrep -o "include:(.+) ")
do
	dig $(echo $host | cut -d":" -f2) txt | grep "v=spf1"
done