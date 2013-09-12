#!/bin/bash
RSNODE="172.16.1.21 172.16.1.22 172.16.1.31 172.16.1.52 172.16.1.53"

function cache_count(){
        for host in $RSNODE
        do
                echo -n "${host}: "
                ssh root@${host} "ls /www/zoshow/product/ |wc -l"
        done
}

function cache_delete(){
        for host in $RSNODE
        do
                ssh root@${host} "find /www/zoshow/product/ -name '*.html' -type f -print | xargs rm -rf"
                echo "${host}: OK"
        done
}

function quiet(){
        if [ $1 = "delete" ]; then
            cache_delete  >/dev/null 2>&1
        else
            usage
        fi

}

function usage(){
        echo $"Usage: $0 [OPTION] {count|delete}"
        echo $"
Options
 -v, --verbose               increase verbosity
 -q, --quiet                 suppress non-error messages
 -h, --help                  show this help (-h works with no other options)
"
}

#cache_count
#cache_delete
#cache_count

case "$1" in
    count)
        cache_count
        ;;
    delete)
        cache_delete
        ;;
    -q)
        quiet $2
        ;;
    "--quiet")
        quiet $2
        ;;
    *)
        usage
        RETVAL=2
        ;;
esac

exit $RETVAL

