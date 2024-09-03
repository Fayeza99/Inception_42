
FROM debian:buster

RUN apt-get update && apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/nginx-selfsigned.key \
	-out /etc/nginx/ssl/nginx-selfsigned.crt \
	-subj "/C=DE/ST=Baden Wurtemberg/L=Heilbronn/O=42Heilbronn/CN=fnikzad"

COPY ./nginx.conf /etc/nginx/nginx.conf

COPY index.html /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
