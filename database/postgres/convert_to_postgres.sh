#!/bin/bash

# Vérifier que le fichier SQL MySQL existe
if [ ! -f "./database/gestion_produits.sql" ]; then
    echo "Le fichier SQL MySQL n'existe pas"
    exit 1
fi

# Conversion basique de MySQL à PostgreSQL
cat ./database/gestion_produits.sql | \
    # Remplacer les AUTO_INCREMENT par SERIAL
    sed 's/AUTO_INCREMENT/SERIAL/g' | \
    # Remplacer les définitions de type
    sed 's/int(/integer/g' | \
    sed 's/varchar(/character varying(/g' | \
    sed 's/TEXT/text/g' | \
    # Adapter la syntaxe des clés primaires
    sed 's/PRIMARY KEY *(\([^)]*\))/PRIMARY KEY (\1)/g' | \
    # Supprimer les ENGINE=InnoDB
    sed 's/ENGINE=InnoDB[^;]*//g' > ./database/postgres/gestion_produits.sql

echo "Conversion terminée. Vérifiez le fichier ./database/postgres/gestion_produits.sql"