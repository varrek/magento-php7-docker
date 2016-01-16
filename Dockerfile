FROM php:7.0.1-apache

RUN build_packages="libmcrypt-dev libpng12-dev libfreetype6-dev libjpeg62-turbo-dev libxml2-dev" \
    && apt-get update && apt-get install -y vim nano $build_packages \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install soap

RUN touch /usr/local/etc/php/conf.d/xdebug.ini; \
	echo xdebug.remote_enable=1 >> /usr/local/etc/php/conf.d/xdebug.ini; \
  	echo xdebug.remote_autostart=0 >> /usr/local/etc/php/conf.d/xdebug.ini; \
  	echo xdebug.remote_connect_back=1 >> /usr/local/etc/php/conf.d/xdebug.ini; \
  	echo xdebug.remote_port=9000 >> /usr/local/etc/php/conf.d/xdebug.ini; \
  	echo xdebug.remote_log=/tmp/php5-xdebug.log >> /usr/local/etc/php/conf.d/xdebug.ini;
RUN	mkdir ~/software && \
	cd  ~/software/ && \
	apt-get install -y wget && \
	wget http://xdebug.org/files/xdebug-2.4.0beta1.tgz && \
	tar -xvzf xdebug-2.4.0beta1.tgz && \
	cd xdebug-2.4.0beta1 && \
	phpize && \
	./configure && \
	make && \
	cp modules/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20151012 && \
	echo "zend_extension = /usr/local/lib/php/extensions/no-debug-non-zts-20151012/xdebug.so" >>  /usr/local/etc/php/php.ini && \
	apachectl graceful

COPY ./docker/data/php.ini /usr/local/etc/php/conf.d/zz-magento.ini

RUN a2enmod rewrite headers

COPY ./docker/data/magento.conf /etc/apache2/conf-enabled/

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
CMD ["apache2-foreground"]
