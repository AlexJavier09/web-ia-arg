# Etapa base con Node + Nginx
FROM node:20-alpine

# Instala nginx
RUN apk add --no-cache nginx

# Directorios
WORKDIR /app
RUN mkdir -p /run/nginx /var/log/nginx /usr/share/nginx/html

# Copia backend
COPY package*.json ./
RUN npm ci --only=production
COPY server.js ./server.js

# Copia frontend estático
COPY index.html /usr/share/nginx/html/

# Copia nginx.conf
COPY nginx.conf /etc/nginx/nginx.conf

# Script de arranque
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Exponer HTTP
EXPOSE 80

# Arranque
CMD ["/start.sh"]
