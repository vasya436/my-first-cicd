#!/bin/bash

# Параметры
WEB_PORT=80
WEB_ROOT="/var/www/html"
INDEX_FILE="index.html"

# Функция логирования
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Проверка доступности порта
log_message "Checking port $WEB_PORT..."
if ! nc -z -w 2 localhost $WEB_PORT; then
    log_message "ERROR: Port $WEB_PORT is not accessible"
    exit 1
fi

# Дополнительная проверка HTTP‑ответа
log_message "Checking HTTP response on port $WEB_PORT..."
if ! curl -f -s -o /dev/null -I "http://localhost:$WEB_PORT/"; then
    log_message "ERROR: HTTP service not responding on port $WEB_PORT"
    exit 1
fi

# Проверка существования index.html
log_message "Checking if $INDEX_FILE exists in $WEB_ROOT..."
if [ ! -f "$WEB_ROOT/$INDEX_FILE" ]; then
    log_message "ERROR: File $INDEX_FILE not found in $WEB_ROOT"
    exit 1
fi

log_message "SUCCESS: All checks passed for port $WEB_PORT"
exit 0
