#!/bin/bash
docker pull centos
docker images centos
docker run centos:latest cat /etc/centos-release