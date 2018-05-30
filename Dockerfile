FROM ubuntu:14.04
RUN apt-get update && \
	apt-get -y upgrade && \
	apt-get install -y build-essential && \
	apt-get install -y wget && \
	apt-get install -y nginx

RUN apt-get install -y libxml2-dev openssl libssl-dev curl libcurl4-gnutls-dev libjpeg-dev libpng12-dev libfreetype6 libfreetype6-dev libmcrypt4 libmcrypt-dev

RUN apt-get install -y software-properties-common python-software-properties && \
	add-apt-repository ppa:ondrej/php && \
	apt-get update && \
	apt-get -y --force-yes upgrade && \
	apt-get install -y --force-yes php-zip

# install php7.1

RUN apt-get install -y --force-yes php7.1
# install php extensions

RUN apt-get install -y --force-yes php7.1-zip

# install composer

RUN cd /usr/local/bin && \
	curl -s https://getcomposer.org/installer | php && \
	chmod a+x composer.phar && \
	mv composer.phar /usr/local/bin/composer && \
	composer self-update


# install lavarel

RUN composer global require "laravel/installer"
ENV PATH $PATH:./root/.composer/vendor/bin/

ADD keep_alive.sh /usr/local/bin
RUN chmod +x /usr/local/bin/keep_alive.sh
