# Use Alpine-based Apache for better security
FROM httpd:alpine

# Update all system packages to fix vulnerabilities
RUN apk update && apk upgrade && rm -rf /var/cache/apk/*

# Copy website files into the Apache document root
COPY index.html /usr/local/apache2/htdocs/

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start Apache in the foreground
CMD ["httpd-foreground"]
