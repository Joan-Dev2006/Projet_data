#!/bin/bash  

echo "--- 🛠️  DÉBUT DU DÉPLOIEMENT ---"

# 1. Gestion de Git
echo "📦 Sauvegarde sur la branche feature-sql..."
# On crée la branche et on y va
git checkout -b feature-sql
git add .
git commit -m "Auto-commit: Mise à jour infra $(date +'%H:%M')"

echo ""

# 2. Lancement de l'infrastructure
echo "🏗️  Lancement de docker-compose..."
# Le -d permet de rendre la main au script immédiatement
docker-compose -f compose.yml up -d

echo ""

# 3. Diagnostic final
echo "📋 DIAGNOSTIC FINAL :"
docker ps 

echo ""
echo "✅ Terminé !"
echo "🌐 Adminer : http://localhost:8080"
echo "🔐 Portainer : https://localhost:9443"