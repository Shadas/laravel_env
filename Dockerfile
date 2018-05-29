FROM ubuntu:14.04
RUN apt-get update && \
	apt-get -y upgrade && \
	apt-get install -y build-essential && \
	apt-get install -y wget && \
	apt-get install -y nginx

RUN apt-get install -y libxml2-dev openssl libssl-dev curl libcurl4-gnutls-dev libjpeg-dev libpng12-dev libfreetype6 libfreetype6-dev libmcrypt4 libmcrypt-dev

RUN wget http://mirrors.sohu.com/php/php-7.0.16.tar.gz && \
	tar zxvf php-7.0.16.tar.gz

RUN	cd php-7.0.16 && \
	./configure --prefix=/usr/local/php \
	--with-config-file-path=/usr/local/php/etc \ 
	--enable-fpm --with-fpm-user=www-data \ 
	--with-pdo-mysql=mysqlnd \ 
	--with-libxml-dir --with-gd \ 
	--with-jpeg-dir --with-png-dir \ 
	--with-freetype-dir --with-iconv-dir --with-zlib-dir \ 
	--with-mcrypt --enable-soap --enable-gd-native-ttf \ 
	--enable-ftp --enable-mbstring --enable-exif --disable-ipv6 \ 
	--with-pear --with-curl --with-openssl && \
	make && make install

RUN cd php-7.0.16 && \
	cp php.ini-production /usr/local/php/etc/php.ini && \
	cd /usr/local/php/etc && \
	cp php-fpm.conf.default php-fpm.conf && \
	cp php-fpm.d/www.conf.default php-fpm.d/www.conf

RUN groupadd nobody && /usr/local/php/sbin/php-fpm


ENV PATH $PATH:/usr/local/php/bin

ADD keep_alive.sh /usr/local/bin
RUN chmod +x /usr/local/bin/keep_alive.sh
