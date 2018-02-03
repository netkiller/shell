####################################################
# Homepage: http://netkiller.github.io
# Author: netkiller<netkiller@msn.com>
# Script: https://github.com/oscm/shell
# Date: 2018-02-03
####################################################
[Unit]
Description=Ethereum Application by Netkiller
After=network.target

[Service]
User=ethereum
Group=ethereum
Type=simple
WorkingDirectory=/srv/go-ethereum
EnvironmentFile=/etc/sysconfig/go-ethereum
ExecStart=/srv/go-ethereum/bin/geth --networkid ${NETWORKID} --rpc --rpcaddr="${RPCADDR}" --rpccorsdomain "*" --nodiscover

[Install]
WantedBy=multi-user.target