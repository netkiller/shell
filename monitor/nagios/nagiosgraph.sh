#!/bin/bash

dnf install -y perl-GD rrdtool perl-rrdtool 

wget http://jaist.dl.sourceforge.net/project/nagiosgraph/nagiosgraph/1.5.2/nagiosgraph-1.5.2.tar.gz
tar zxf nagiosgraph-1.5.2.tar.gz
cd nagiosgraph-1.5.2
