./php7-pthreads.sh

cd 
git clone https://github.com/uber/h3.git

cd h3
cmake3 -DBUILD_SHARED_LIBS=ON .
make -j4 && sudo make install

sudo cp /usr/local/lib/libh3.* /usr/local/lib64/
sudo cp /usr/local/lib/libh3.* /usr/lib/
sudo cp /usr/local/lib/libh3.* /usr/lib64/
sudo echo '/usr/local/lib64/' >> /etc/ld.so.conf
sudo echo '/usr/lib64/' >> /etc/ld.so.conf
sudo ldconfig

cd 
git clone https://github.com/neatlife/php-h3.git
cd php-h3
/etc/php7/bin/phpize
./configure
make -j4 && sudo make install
echo "extension=h3.so" | sudo tee -a /etc/php7/cli/php.ini
