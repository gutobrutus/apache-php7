# Apache com PHP7
Dockerfile para build de imagem com Apache+PHP7, dervida da imagem Alpine:latest.

## 1 - Análise de vulnerabilidades
O docker possui integração com o [Snyk](https://snky.io), que uma solução de que escaneia a imagem docker em busca de vulnerabilidades conhecidas. 
```bash
$ docker scan gutofunny/apachephp7-alpine                           

Testing gutofunny/apachephp7-alpine...

Organization:      gutofunny
Package manager:   apk
Project name:      docker-image|gutofunny/apachephp7-alpine
Docker image:      gutofunny/apachephp7-alpine
Platform:          linux/amd64
Licenses:          enabled

✓ Tested 49 dependencies for known issues, no vulnerable paths found.
```
## 2 - Repositório da imagem no Docker Hub
O repositório está público no Docker Hub a partir do link:
https://hub.docker.com/r/gutofunny/apachephp7-alpine

Para fazer o pull da imagem:
```bash
docker pull gutofunny/apachephp7-alpine
```

## 3 - Como executar
Para rodar o container a partir da imagem:
```bash
docker run -d -p 8080:80 --name webserver gutofunny/apachephp7-alpine
```
## 4 - Pacotes instalados na imagem
- zip, libcap, unzip, curl, bash, apache2,  php7-apache2, php7, php7-simplexml, php7-json, php7-phar, php7-iconv, php7-openssl, openssl, openntpd, tzdata

## 5 - Workdir
Foi configurado na imagem o WORKDIR para o caminho:
```bash
/app/public
```
### 5.1 - Usuário e Grupo do apache
Foi definido como usuário de serviço e grupo como **apache2:apache2**
Mais detalhes podem ser consultados diretamente no [Dockerfile](Dockerfile).

Licença pode ser consultada [aqui](LICENSE)