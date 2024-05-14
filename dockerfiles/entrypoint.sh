#!/bin/sh
set -e

# Démarrer PostgreSQL
su - postgres -c "postgres -D /app" &

# Attendre que PostgreSQL soit prêt
sleep 5

# Exécuter le script init.sql avec psql
echo "POSTGRES_USER: $POSTGRES_USER"
echo "POSTGRES_DB: $POSTGRES_DB"

su - postgres -c "psql -U postgres -f /init.sql" || { echo "Error executing init.sql"; exit 1; }

su - postgres -c "psql -U test -d db -f /script.sql" || { echo "Error executing script.sql"; exit 1; }

# Garder le script en cours d'exécution indéfiniment
while true; do
    sleep 60    # Vous pouvez ajuster la fréquence de la vérification ici
done