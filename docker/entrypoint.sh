#!/bin/bash
set -e

echo "=========================================="
echo " NutriPlanner — Starting up..."
echo "=========================================="

# Wait for MySQL to be ready
echo "[*] Waiting for MySQL at ${DB_HOST}:${DB_PORT:-3306}..."
MAX_RETRIES=30
RETRY=0
until mysqladmin ping -h "${DB_HOST}" -P "${DB_PORT:-3306}" --silent 2>/dev/null; do
    RETRY=$((RETRY + 1))
    if [ $RETRY -ge $MAX_RETRIES ]; then
        echo "[!] MySQL not available after ${MAX_RETRIES} retries. Exiting."
        exit 1
    fi
    echo "[*] MySQL not ready yet (attempt ${RETRY}/${MAX_RETRIES})... waiting 2s"
    sleep 2
done
echo "[✓] MySQL is ready!"

# Generate app key if not set
if [ -z "$APP_KEY" ] || [ "$APP_KEY" = "" ]; then
    echo "[*] Generating application key..."
    php artisan key:generate --force
fi

# Clear and cache config
echo "[*] Caching configuration..."
php artisan config:clear
php artisan config:cache

# Run migrations
echo "[*] Running database migrations..."
php artisan migrate --force

# Seed database if accounts table is empty
ACCOUNT_COUNT=$(php artisan tinker --execute="echo \App\Models\AccountModel::count();" 2>/dev/null || echo "0")
if [ "$ACCOUNT_COUNT" = "0" ]; then
    echo "[*] Database is empty. Running seeders..."
    php artisan db:seed --force
else
    echo "[*] Database already has data. Skipping seeder."
fi

# Ensure storage link exists
php artisan storage:link 2>/dev/null || true

# Fix permissions
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

echo "=========================================="
echo " NutriPlanner — Ready! Starting services."
echo "=========================================="

exec "$@"
