#!/bin/bash
COPIES=30
find /var/log/nginx/ -type f -mtime +$COPIES -delete