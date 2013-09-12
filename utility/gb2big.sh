SOURCE_DIR="/www/netkiller.8800.org/htdocs/archives/technology"
TARGET_DIR="/www/netkiller.8800.org/htdocs/archives/technology/zh-tw"

    for dir in $(find $SOURCE_DIR -type d | grep -v 'zh-tw' | sed -e "s:^$SOURCE_DIR/::g");
    do
        mkdir -p $TARGET_DIR/$dir
    done


    for file in $(find $SOURCE_DIR -type f | grep -v 'zh-tw')

    do

 	output_file=$(echo $file | sed -e "s:^$SOURCE_DIR:$TARGET_DIR:g") # -e "s:^/::g")
if [ "${file##*.}" = "html" ]
then 
    	cconv -f UTF8-CN -t UTF8-HK $file -o $output_file &
else

	cp $file $output_file &
fi
	echo $file
    done 

