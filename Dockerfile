FROM ubuntu:14.04
MAINTAINER Karan Singh <contact@dockerworx.com>
#ENV http_proxy "Corporate_proxy:8080"

RUN apt-get update
RUN apt-get -qqy upgrade
RUN apt-get -qqy install apache2-utils squid3

# If you are prone to gouging your eyes out, do not read the following 2 lines
RUN sed -i 's@#\tauth_param basic program /usr/lib/squid3/basic_ncsa_auth /usr/etc/passwd@auth_param basic program /usr/lib/squid3/basic_ncsa_auth /usr/etc/passwd\nacl ncsa_users proxy_auth REQUIRED@' /etc/squid3/squid.conf
RUN sed -i 's@^http_access allow localhost$@\0\nhttp_access allow ncsa_users@' /etc/squid3/squid.conf

RUN mkdir /usr/etc

EXPOSE 3128
VOLUME /var/log/squid3

ADD init /init
CMD ["/init"]
