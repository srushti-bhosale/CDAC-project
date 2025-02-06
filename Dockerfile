# Use Alpine-based Apache for better security
FROM httpd

# Copy website files into the Apache document root
COPY index.html /usr/local/apache2/htdocs/

# Expose port 80 for HTTP traffic
EXPOSE 80

