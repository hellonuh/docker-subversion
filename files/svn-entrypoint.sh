#!/bin/bash

if [ -n "$SVN_REPO" ]; then
test ! -d "/var/local/svn/$SVN_REPO" && svnadmin create /var/local/svn/$SVN_REPO
echo "Creating the repository: $SVN_REPO into /var/local/svn/"
else
test ! -d "/var/local/svn/testrepo" && svnadmin create /var/local/svn/testrepo
echo "Warning: SVN_REPO variable not defined, starting with svn default repository: testrepo into /var/local/svn/"
fi

if [ ! -f /etc/httpd/dav_svn/dav_svn.passwd ]
then
    echo "generating default password for admin,jenkins, and readonly."
    echo "password is same as username"
    htpasswd -bc /etc/httpd/dav_svn/dav_svn.passwd admin admin
    htpasswd -b /etc/httpd/dav_svn/dav_svn.passwd jenkins jenkins
    htpasswd -b /etc/httpd/dav_svn/dav_svn.passwd readonly readonly
fi

chown -R apache:apache "/var/local/svn/" && chmod -R 775 "/var/local/svn/"

httpd -D FOREGROUND