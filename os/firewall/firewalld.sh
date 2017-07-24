#!/bin/bash

systemctl stop firewalld
systemctl disable firewalld

yum remove -y firewalld
