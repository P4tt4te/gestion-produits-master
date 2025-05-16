FROM php:8.2-apache

# Installation des dépendances nécessaires
RUN apt-get update && apt-get install -y \
    libpq-dev \
    && docker-php-ext-install mysqli pdo pdo_mysql

# Activation du module rewrite d'Apache
RUN a2enmod rewrite

# Définir le répertoire de travail
WORKDIR /var/www/html

# Copie des fichiers de l'application
COPY php/www/ /var/www/html/

# S'assurer que le dossier uploads a les bonnes permissions
RUN chmod 777 /var/www/html/uploads && \
    chown -R www-data:www-data /var/www/html