#!/bin/bash

# Script de deployment FTP pentru Opall
# Utilizare: ./deploy.sh

# Incarca variabilele din .env
if [ -f .env ]; then
    export $(cat .env | grep -v '#' | xargs)
else
    echo "Eroare: Fisierul .env nu exista!"
    exit 1
fi

echo "=== Deployment Opall ==="
echo "Se conecteaza la: $FTP_HOST"
echo "Utilizator: $FTP_USER"
echo "Director destinatie: $FTP_DIR"
echo ""

# Functie pentru upload fisier
upload_file() {
    local file=$1
    local remote_path="$FTP_DIR/$file"

    echo "Upload: $file -> $remote_path"
    curl -s -T "$file" "ftp://$FTP_HOST$remote_path" \
        --user "$FTP_USER:$FTP_PASS" \
        --ftp-create-dirs

    if [ $? -eq 0 ]; then
        echo "  OK"
    else
        echo "  EROARE!"
        return 1
    fi
}

# Lista fisierelor de uploadat
FILES=(
    "index.html"
    "contact.html"
    "style.css"
    "script.js"
)

# Upload fiecare fisier
errors=0
for file in "${FILES[@]}"; do
    if [ -f "$file" ]; then
        upload_file "$file" || ((errors++))
    else
        echo "SKIP: $file (nu exista)"
    fi
done

echo ""
if [ $errors -eq 0 ]; then
    echo "=== Deployment finalizat cu succes! ==="
    echo "Site-ul este live la: https://app.opall.ro"
else
    echo "=== Deployment finalizat cu $errors erori ==="
    exit 1
fi
