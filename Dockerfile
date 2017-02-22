FROM 1and1internet/ubuntu-16-apache-php-7.0:latest
MAINTAINER brian.wojtczak@1and1.co.uk
ARG DEBIAN_FRONTEND=noninteractive
WORKDIR /var/www/html
COPY files /
ENV DRUPAL_DB_HOST=mysql \
    DRUPAL_DB_PORT=3306 \
    DRUPAL_DB_USER=drupal \
    DRUPAL_DB_NAME=drupal \
    DRUPAL_DB_PASSWORD=EnvVarHere \
    DRUPAL_DB_DRIVER=mysql \
    DRUPAL_DB_PREFIX=''
RUN \
    apt-get update && apt-get install -y libpng12-dev libjpeg-dev libpq-dev drush && \
    rm -rf /var/lib/apt/lists/* && \
    DRUPAL_DOWNLIAD_LINK=$(/usr/bin/php /usr/custom-bin/drupal-latest-release-download-link.php) && \
    echo "Downloading ${DRUPAL_DOWNLIAD_LINK} to /usr/src/drupal.tar.gz" && \
    curl -fSL "${DRUPAL_DOWNLIAD_LINK}" -o /usr/src/drupal.tar.gz && \
    chmod -R 755 /hooks /init
