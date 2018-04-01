FROM oraclelinux:7-slim
LABEL maintainer="neyazul.haque@hellonuh.com"

ENV LANG C.UTF-8

RUN yum install -y httpd subversion mod_dav_svn && \
    mkdir -p /var/local/svn && \
    mkdir /etc/httpd/dav_svn

ADD files/dav_svn.conf /etc/httpd/config.modules.d/
ADD dav_svn_authz /etc/httpd/dav_svn/
ADD files/svn-project-creator.sh /usr/local/bin/
ADD files/svn-entrypoint.sh /usr/local/bin/

RUN chmod a+x /usr/local/bin/svn*
VOLUME ["/var/local/svn", "/etc/httpd/dav_svn"]

# CMD ["/usr/local/bin/svn-entrypoint.sh"]
CMD ["svn-entrypoint.sh"]