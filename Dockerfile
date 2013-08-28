FROM ubuntu:precise
MAINTAINER Christian Simon <simon@swine.de>
# Ensure using universe
RUN echo "deb http://archive.ubuntu.com/ubuntu precise universe main multiverse restricted" > /etc/apt/sources.list
RUN echo "deb http://security.ubuntu.com/ubuntu/ precise-security universe main multiverse restricted" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-client apache2 libapache2-mod-php5 python-setuptools nano mc vim-tiny php5-mysql php5-memcached php5-geoip php5-gd php5-ldap php5-imap php5-pgsql php5-mcrypt
RUN easy_install supervisor
ADD ./start.sh /start.sh
ADD ./foreground.sh /etc/apache2/foreground.sh
ADD ./supervisord.conf /etc/supervisord.conf
RUN chmod 755 /start.sh
RUN chmod 755 /etc/apache2/foreground.sh
EXPOSE 80
CMD ["/bin/bash", "/start.sh"]
