#!/bin/bash
sed -i "12s|dockerd|dockerd --registry-mirror=http://576a74e5.m.daocloud.io|" /usr/lib/systemd/system/docker.service
systemctl daemon-reload
systemctl restart docker