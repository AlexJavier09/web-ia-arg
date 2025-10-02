#!/bin/sh
set -e
nginx
exec node /app/server.js
