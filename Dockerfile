FROM php:7.3-fpm-stretch

# Copy composer.lock and composer.json
COPY composer.lock composer.json /var/www/app_1/

# Set working directory
WORKDIR /var/www/app_1/

# Install dependencies
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
apt-get update && apt-get install -y \
nodejs \
build-essential \
mariadb-client \
libssl-dev \
zlib1g-dev \
libjpeg-dev \
libwebp-dev \
libxpm-dev \
pkg-config \
libpng-dev \
libjpeg62-turbo-dev \
libfreetype6-dev \
locales \
zip \
jpegoptim optipng pngquant gifsicle \
vim \
nano \
unzip \
libzip-dev \
git \
curl && \
npm install -g npm


# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl
RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-webp-dir --with-jpeg-dir --with-libzip
RUN docker-php-ext-install gd

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy existing application directory contents
COPY . /var/www

# Copy existing application directory permissions
COPY --chown=www:www . /var/www

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]

