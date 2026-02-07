# 📊 Projet Data - Gestion de Produits (UTT)

> **Système d'infrastructure de base de données conteneurisée avec traçabilité dynamique des prix.**

---

## 🏗️ Architecture du Système
L'écosystème repose sur trois piliers principaux pour garantir la performance et la visibilité :

| Composant | Technologie | Port | Rôle |
| :--- | :--- | :--- | :--- |
| **Database** | `MySQL 8.0` | `3306` | Stockage persistant & Triggers |
| **Gestionnaire** | `Adminer` | `8080` | Interface de gestion SQL |
| **Monitoring** | `Portainer` | `9444` | Gestion des conteneurs Docker |



---

## 🚀 Déploiement Rapide

Pour lancer l'environnement de production sur votre machine locale, suivez ces étapes :

### 1️⃣ Configuration
Copiez le fichier d'exemple et renseignez vos identifiants :
```bash
cp .env.example .env
