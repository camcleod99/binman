FROM debian:bullseye

# Install Chromium, ImageMagick, nginx
RUN apt-get update && apt-get install -y \
  chromium \
  imagemagick \
  nginx \
  curl \
  tzdata \
  && apt-get clean

# Set timezone (adjust as needed)
ENV TZ=Europe/London
  
# Copy your files
COPY binman.sh /binman.sh
COPY index.html /var/www/html/index.html
COPY .env /.env

# Give execute permissions
RUN chmod +x /binman.sh

# Expose port
EXPOSE 80

# Run binman.sh at container start, then start nginx
CMD ["/bin/bash", "-c", "/binman.sh && nginx -g 'daemon off;'"]
