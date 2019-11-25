#!/bin/bash

systemctl stop firewalld
systemctl disable firewalld

dnf remove -y firewalld
