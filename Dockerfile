# Specify the base image
FROM wordpress:latest

LABEL maintainer="Ahmad Malekiha (a-malex) <ahmadmalekiha@gmail.com>"

# Set the working directory to /var/www/html
WORKDIR /var/www/html

# Copy the contents of the current directory to /var/www/html in the container
COPY wp-content/themes/ahmad-theme/ wp-content/themes/ahmad-theme/

RUN chown -R www-data:www-data wp-content/themes && \
    chmod -R 775 wp-content/themes

# Expose port 80 so that it can be accessed from outside the container
EXPOSE 80

# Start Apache and MySQL services when the container starts
CMD ["apache2-foreground"]
