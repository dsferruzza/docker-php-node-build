FROM debian:8.2
MAINTAINER David Sferruzza <david.sferruzza@gmail.com>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Add Node.js repo
RUN apt-get update \
 && apt-get install -y \
 curl \
 apt-transport-https
RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
RUN echo "deb https://deb.nodesource.com/node_5.x jessie main" > /etc/apt/sources.list.d/nodesource.list

# Install tools
RUN apt-get update \
 && apt-get install -y \
 git \
 php5-cli \
 nodejs-legacy

# Show versions
RUN php -v
RUN node -v
RUN npm -v

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer selfupdate

# Install node tools
RUN npm install -g grunt-cli bower
RUN grunt --version
RUN bower --allow-root --version

# Slim down image
RUN apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/?? /usr/share/man/??_*
