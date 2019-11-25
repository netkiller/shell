#!/bin/bash

dnf install -y incron

systemctl enable incrond
systemctl start incrond