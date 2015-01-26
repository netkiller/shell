#!/bin/bash

sudo apt-get install php5-fpm

sudo cp /etc/php5/fpm/php-fpm.conf{,.original}
#vim /etc/php5/fpm/php-fpm.conf <<end > /dev/null 2>&1
#:wq
#end

sudo cp /etc/php5/fpm/pool.d/www.conf{,.original}
sudo vim /etc/php5/fpm/pool.d/www.conf <<EOF > /dev/null 2>&1
:99,99s/pm.max_children = 5/pm.max_children = 256/
:125,125s/;pm.max_requests = 500/pm.max_requests = 1024/
:322,322s/;rlimit_files = 1024/rlimit_files = 40960/
:wq
EOF

sudo vim /etc/php5/fpm/php.ini <<end > /dev/null 2>&1
:299,299s$;open_basedir =$open_basedir = /www/:/tmp/:/var/tmp/:/var/lib/php5:$
:366,366s/expose_php = On/expose_php = Off/
:396,396s/memory_limit = 128M/memory_limit = 32M/
:869,869s:;date.timezone =:date.timezone = Asia/Hong_Kong:
:1346,1346s:;session.save_path = "/tmp":session.save_path = "/dev/shm":
:1372,1372s/session.name = PHPSESSID/session.name = JSESSIONID/
:wq
end

#disable_functions = pcntl_alarm,pcntl_fork,pcntl_waitpid,pcntl_wait,pcntl_wifexited,pcntl_wifstopped,pcntl_wifsignaled,pcntl_wexitstatus,pcntl_wtermsig,pcntl_wstopsig,pcntl_signal,pcntl_signal_dispatch,pcntl_get_last_error,pcntl_strerror,pcntl_sigprocmask,pcntl_sigwaitinfo,pcntl_sigtimedwait,pcntl_exec,pcntl_getpriority,pcntl_setpriority