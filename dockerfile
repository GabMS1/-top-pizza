FROM php:8.2-apache

# Habilita o módulo de reescrita do Apache
RUN a2enmod rewrite

# Instala as extensões PHP necessárias para o banco de dados
RUN docker-php-ext-install pdo pdo_mysql

# Define o diretório de trabalho dentro do contêiner
WORKDIR /var/www/html

# Remove a configuração padrão do Apache
RUN rm /etc/apache2/sites-enabled/000-default.conf

# Copia a configuração personalizada do vhost para o local correto
COPY vhost.conf /etc/apache2/sites-available/000-default.conf

# Habilita o novo vhost
RUN a2ensite 000-default.conf

# Expõe a porta do servidor web
EXPOSE 80

# Comando para iniciar o servidor Apache
CMD ["apache2-foreground"]