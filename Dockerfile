FROM php:8.3-fpm

# Install system dependencies
RUN apt update && apt install -y \
    git \
    curl \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libpq-dev

# Install PHP extensions
RUN docker-php-ext-configure intl
RUN docker-php-ext-configure opcache
RUN docker-php-ext-install pdo_mysql pgsql pdo_pgsql mbstring exif pcntl bcmath intl opcache
RUN pecl install apcu

# Copy Composer from the official Composer image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy existing application directory permissions
COPY --chown=www-data:www-data . /var/www

# Change current user to www
USER www-data
