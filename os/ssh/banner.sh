#!/bin/bash

cat > /etc/ssh/banner <<EOF
#########################################
# Operation System Configure Management #
# http://www.netkiller.cn/              #
#########################################

  _   _      _   _    _ _ _              ____   _____  _____ __  __ 
 | \ | |    | | | |  (_) | |            / __ \ / ____|/ ____|  \/  |
 |  \| | ___| |_| | ___| | | ___ _ __  | |  | | (___ | |    | \  / |
 | .   |/ _ \ __| |/ / | | |/ _ \ '__| | |  | |\___ \| |    | |\/| |
 | |\  |  __/ |_|   <| | | |  __/ |    | |__| |____) | |____| |  | |
 |_| \_|\___|\__|_|\_\_|_|_|\___|_|     \____/|_____/ \_____|_|  |_|

EOF

vim /etc/ssh/sshd_config <<EOF > /dev/null 2>&1
:%s$#Banner none$Banner /etc/ssh/banner$
:wq
EOF

systemctl restart sshd
