FROM alpine:latest
LABEL maintainer="guto@devops.pro.br"

WORKDIR /app/public
#Buildar com a linha abaixo descomentada apenas para fins de teste
#COPY info.php /app/public
COPY index.html /app/public

#Instalar PHP7.x, essenciais e confurar user, owners dentre outros
RUN set -x \
    apk add --update && \
    apk add --no-cache zip \
    libcap \
    unzip \
    curl \
    bash \
    apache2 \
    php7-apache2 \
    php7 \
    php7-simplexml \
    php7-json \
    php7-phar \
    php7-iconv \
    php7-openssl \
    openssl \
    openntpd \
    tzdata && \
    rm -f /var/cache/apk/* && \
    addgroup -g 1000 -S apache2 && \
    adduser -S -D -H -u 1000 -h /etc/apache2/ -s /sbin/nologin -G apache2 -g apache2 apache2 && \
    chown -R apache2:apache2 /app && \
    chown -R apache2:apache2 /etc/apache2 && \
    chown -R apache2:apache2 /var/www && \
    chown -R apache2:apache2 /var/log/apache2 && \
    chown -R apache2:apache2 /run/apache2 && \
    setcap 'cap_net_bind_service=+ep' /usr/sbin/httpd && \
    ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log

RUN getcap /usr/sbin/httpd

USER apache2

#Configurar e executar o apache
RUN sed -i "s/#LoadModule\ rewrite_module/LoadModule\ rewrite_module/" /etc/apache2/httpd.conf \
 && sed -i "s/#LoadModule\ session_module/LoadModule\ session_module/" /etc/apache2/httpd.conf \
 && sed -i "s/#LoadModule\ session_cookie_module/LoadModule\ session_cookie_module/" /etc/apache2/httpd.conf \
 && sed -i "s/#LoadModule\ session_crypto_module/LoadModule\ session_crypto_module/" /etc/apache2/httpd.conf \
 && sed -i "s/#LoadModule\ deflate_module/LoadModule\ deflate_module/" /etc/apache2/httpd.conf \
 && sed -i "s#^DocumentRoot \".*#DocumentRoot \"/app/public\"#g" /etc/apache2/httpd.conf \
 && sed -i "s#/var/www/localhost/htdocs#/app/public#" /etc/apache2/httpd.conf \
 && sed -i "s/User\ apache/User\ apache2/" /etc/apache2/httpd.conf \
 && sed -i "s/Group\ apache/Group\ apache2/" /etc/apache2/httpd.conf \
 && sed -i "s/ServerTokens\ OS/ServerTokens\ Prod/" /etc/apache2/httpd.conf \
 && sed -i "s/ServerSignature\ On/ServerSignature\ Off/" /etc/apache2/httpd.conf \
 && printf "\n<Directory \"/app/public\">\n\tAllowOverride All\n</Directory>\n" >> /etc/apache2/httpd.conf

 EXPOSE 80
 CMD [ "httpd", "-D", "FOREGROUND" ]