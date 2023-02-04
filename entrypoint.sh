#!/bin/bash

useradd $SAMBA_USER
(echo $SAMBA_PASS; echo $SAMBA_PASS) | smbpasswd -a $SAMBA_USER

groupadd samba
gpasswd -a $SAMBA_USER samba

testparm -s
setfacl -R -m "g:samba:rwx" /srv/private/

/usr/sbin/smbd --foreground --no-process-group
/usr/sbin/nmbd --foreground --no-process-group
