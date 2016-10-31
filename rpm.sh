#!/bin/bash

git clone https://github.com/oscm/shell.git

topdir=~/rpmbuild
#rm -rf $topdir
mkdir -p $topdir/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

#echo "%_topdir ~/rpmbuild" > ~/.rpmmacros
#echo "%_tmppath /tmp" > ~/.rpmmacros
#echo "%packager Neo Chen <netkiller@msn.com>" > ~/.rpmmacros
#cat ~/.rpmmacros

cat << EOF >> ~/.rpmmacros
%_signature gpg
%_gpg_name Neo Chen (netkiller) <netkiller@msn.com>
%_gpgpath ~/.gnupg
%_gpgbin /usr/bin/gpg
EOF

#rpm -Vp
name=oscm
rpmbuild -ba --sign test.spec --define "book ${name}"
rpm -qpi ~/rpmbuild/RPMS/x86_64/netkiller-${name}-*.x86_64.rpm
rpm -qpl ~/rpmbuild/RPMS/x86_64/netkiller-${name}-*.x86_64.rpm