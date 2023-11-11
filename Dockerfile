# Use an official PHP with Apache image based on Alpine Linux
FROM php:8.2.10-apache-alpine

# Install necessary build dependencies
RUN apk add --no-cache \
    $PHPIZE_DEPS \
    zlib-dev \
    libmemcached-dev

# Install the memcache extension
RUN pecl install memcache && docker-php-ext-enable memcache

# Install the Redis extension
RUN pecl install redis && docker-php-ext-enable redis

# Install additional PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Enable Apache modules
RUN a2enmod rewrite

# Set the working directory to /var/www/html
WORKDIR /var/www/html

# Copy the current directory contents into the container at /var/www/html
COPY . /var/www/html

# Create a volume for web files (optional, depending on your use case)
VOLUME /var/www/html

# Expose port 80 for Apache
EXPOSE 80

# Start Apache when the container launches
CMD ["httpd", "-D", "FOREGROUND"]
