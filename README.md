# 📊 Infrastructure Cloud & Service-Desk (UTT)

> **Projet de déploiement conteneurisé d'une base de données analytique avec traçabilité dynamique.**

---

## 📝 Description
Ce projet déploie une infrastructure complète via Docker Compose. Il intègre une logique métier SQL avancée pour la gestion d'un catalogue produit, incluant un système d'audit automatique des prix.

## 🏗️ Architecture des Services
| Service | Technologie | Port | Usage |
| :--- | :--- | :--- | :--- |
| **Database** | `MySQL 8.0` | `3306` | Moteur de données & Triggers |
| **Adminer** | `PHP 8.2` | `8080` | Interface de gestion SQL |
| **Portainer** | `Docker` | `9444` | Monitoring des conteneurs |

## 🧠 Intelligence de Données (SQL)
Le système ne se contente pas de stocker, il analyse :
* **Trigger `avant_changement_prix`** : Historisation automatique de l'ancien prix avant chaque mise à jour.
* **Vue `vue_alerte_inflation`** : Détection en temps réel des hausses de prix > 10%.

## 🚀 Installation
1. Configurer le fichier `.env` (voir `.env.example`).
2. Lancer l'infrastructure :
```bash
docker-compose up -d
