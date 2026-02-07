\# 📊 Projet Data - Gestion de Produits (UTT)



Ce projet déploie une infrastructure de base de données conteneurisée avec suivi automatique de l'historique des prix.



\## 🏗️ Architecture

\- \*\*Base de données\*\* : MySQL 8.0

\- \*\*Gestionnaire DB\*\* : Adminer (Port 8080)

\- \*\*Monitoring\*\* : Portainer (Port 9444)

\- \*\*Réseau\*\* : `prod-network` (Isolé)



\## 🚀 Installation rapide

1\. Configurer le fichier `.env` à partir du template.

2\. Lancer l'infrastructure :

&nbsp;  ```bash

&nbsp;  docker-compose -f compose.yml up -d

