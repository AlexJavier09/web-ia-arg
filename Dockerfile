# Imagen base con Node
FROM node:20-alpine

# Instala Nginx
RUN apk add --no-cache nginx

# Directorios necesarios
WORKDIR /app
RUN mkdir -p /run/nginx /var/log/nginx /usr/share/nginx/html

# Backend (Node)
COPY package*.json ./
RUN npm ci --only=production
COPY server.js ./server.js

# Frontend estático
COPY index.html /usr/share/nginx/html/index.html

# Config Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Script de arranque
COPY start.sh /start.sh
RUN sed -i 's/\r$//' /start.sh && chmod +x /start.sh

# Fuerza Node en 3000 (¡NO 80!)
ENV PORT=3000

EXPOSE 80
CMD ["sh", "/start.sh"]
