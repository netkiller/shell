dnf install -y mrtg
cp /etc/mrtg/mrtg.cfg{,.original}

cfgmaker --global "HtmlDir: /var/www/mrtg" \
--global "ImageDir: /var/www/mrtg" \
--global "LogDir: /var/lib/mrtg" \
--global "ThreshDir: /var/lib/mrtg" \
--global "Options[_]: growright,bits"  \
--ifref=name --ifdesc=descr --subdirs=Switch251 public@172.16.254.251 \
--ifref=name --ifdesc=descr --subdirs=Switch252 public@172.16.254.252 \
--ifref=name --ifdesc=descr --subdirs=Switch253 public@172.16.254.253 \
--ifref=name --ifdesc=descr --subdirs=MSR2600 public@172.16.254.254 \
> /etc/mrtg/mrtg.cfg

indexmaker --output=/var/www/mrtg/index.html /etc/mrtg/mrtg.cfg