#!/bin/bash
sed -i "12s|dockerd|dockerd --registry-mirror=https://docker.mirrors.ustc.edu.cn|" /usr/lib/systemd/system/docker.service
systemctl daemon-reload
systemctl restart docker