FROM node:20-alpine

# Instala nginx (si lo usas en el mismo contenedor)
RUN apk add --no-cache nginx

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

# Copia start.sh a la RAÍZ del contenedor
COPY start.sh /start.sh

# Normaliza finales de línea y da permisos de ejecución
RUN sed -i 's/\r$//' /start.sh && chmod +x /start.sh

# Diagnóstico: verifica que está ahí y ejecutable
RUN ls -l /start.sh && head -n 3 /start.sh

EXPOSE 80

# Opción A (recomendada): llama sh explícitamente (evita problemas de shebang/CRLF)
CMD ["sh", "/start.sh"]

# Opción B (si confías en el shebang):
# CMD ["/start.sh"]
