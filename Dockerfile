# Use the latest official Apache HTTP Server image
FROM httpd:latest

# Update and install security patches
RUN apt-get update && apt-get upgrade -y && apt-get clean

# Copy website files into the Apache document root
COPY index.html /usr/local/apache2/htdocs/

# Expose port 80 for HTTP traffic
EXPOSE 80

# Ensure Apache runs in the foreground (default behavior in httpd image)
CMD ["httpd-foreground"]
