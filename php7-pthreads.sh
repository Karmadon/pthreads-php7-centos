sudo yum group install -y "Development Tools"
sudo  yum install -y libxml2-devel openssl-devel bzip2-devel enchant-devel curl-devel libjpeg-devel libpng-devel libXpm-devel freetype-devel gmp-devel libicu-devel openldap openldap-devel libtidy-devel libxslt-devel aspell-devel readline-devel libzip-devel 
cd /usr/src/
wget https://github.com/php/php-src/archive/php-7.3.17.tar.gz
tar xvf php-7.3.17.tar.gz
cd php-7.3.17
./buildconf --force
CONFIGURE_STRING="--prefix=/etc/php7 --with-bz2 --with-zlib --enable-zip --disable-cgi \
   --enable-soap --enable-intl --with-openssl --with-readline --with-curl \
   --enable-ftp --enable-mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd \
   --enable-sockets --enable-pcntl --with-pspell --with-enchant --with-gettext \
   --with-gd --enable-exif --with-jpeg-dir --with-png-dir --with-freetype-dir --with-xsl \
   --enable-bcmath --enable-mbstring --enable-calendar --enable-simplexml --enable-json \
   --enable-hash --enable-session --enable-xml --enable-wddx --enable-opcache \
   --with-pcre-regex --with-config-file-path=/etc/php7/cli \
   --with-config-file-scan-dir=/etc/php7/etc --enable-cli --enable-maintainer-zts \
   --with-tsrm-pthreads --enable-debug --enable-fpm \
   --with-fpm-user=www-data --with-fpm-group=www-data"

./configure $CONFIGURE_STRING
make -j4 && sudo make install

sudo chmod o+x /etc/php7/bin/phpize
sudo chmod o+x /etc/php7/bin/php-config
cd
git clone https://github.com/krakjoe/pthreads.git
cd pthreads
/etc/php7/bin/phpize

./configure \
--prefix='/etc/php7' \
--with-libdir='/lib/x86_64-linux-gnu' \
--enable-pthreads=shared \
--with-php-config='/etc/php7/bin/php-config'
make && sudo make install


cd $HOME/php-7.3.17
sudo mkdir -p /etc/php7/cli/
sudo cp php.ini-production /etc/php7/cli/php.ini

echo "extension=pthreads.so" | sudo tee -a /etc/php7/cli/php.ini
echo "zend_extension=opcache.so" | sudo tee -a /etc/php7/cli/php.ini
sudo ln -s /etc/php7/bin/php /usr/bin/php
