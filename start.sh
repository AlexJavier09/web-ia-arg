#!/bin/sh
set -e

# Arranca Nginx en background
nginx

# Arranca tu app Node en primer plano
exec node /app/server.js
