# Application de Gestion des Rédacteurs

## 📋 Description
Application Flutter complète permettant la gestion CRUD (Create, Read, Update, Delete) des rédacteurs avec persistance des données via SQLite.

## 🏗️ Architecture MVC

### Structure des dossiers
```
lib/
├── main.dart                          # Point d'entrée de l'application
├── modele/
│   └── redacteur.dart                 # Modèle de données Redacteur
├── database/
│   └── database_manager.dart          # Gestionnaire de base de données SQLite
└── interfaces/
    └── redacteur_interface.dart       # Interface utilisateur principale
```

## 📦 Dépendances
- `sqflite: ^2.3.0` - Base de données SQLite
- `path_provider: ^2.1.1` - Accès aux chemins système
- `path: ^1.8.3` - Manipulation des chemins de fichiers

## 🎯 Fonctionnalités

### ✅ Opérations CRUD complètes
- **Create** : Ajouter un nouveau rédacteur
- **Read** : Afficher la liste de tous les rédacteurs
- **Update** : Modifier les informations d'un rédacteur
- **Delete** : Supprimer un rédacteur avec confirmation

### 🎨 Interface utilisateur
- Design moderne avec Material Design
- Palette de couleurs rose/magenta cohérente
- Formulaire de saisie avec validation
- Liste scrollable avec cartes élégantes
- Compteur de rédacteurs en temps réel
- Snackbars pour les notifications
- Dialogues de confirmation et modification

### 💾 Persistance des données
- Base de données SQLite locale (`redacteurs.db`)
- Données conservées après fermeture de l'application
- Chargement automatique au démarrage

## 🔧 Utilisation

### Ajouter un rédacteur
1. Remplir les champs Nom, Prénom et Email
2. Cliquer sur "Ajouter un rédacteur"
3. Confirmation par Snackbar

### Modifier un rédacteur
1. Cliquer sur l'icône ✏️ (edit)
2. Modifier les informations dans le dialogue
3. Cliquer sur "Enregistrer"

### Supprimer un rédacteur
1. Cliquer sur l'icône 🗑️ (delete)
2. Confirmer la suppression dans le dialogue
3. Le rédacteur est supprimé de la base

## 📊 Modèle de données

### Classe Redacteur
```dart
class Redacteur {
  int? id;
  String nom;
  String prenom;
  String email;
}
```

### Table SQLite
```sql
CREATE TABLE redacteurs(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nom TEXT NOT NULL,
  prenom TEXT NOT NULL,
  email TEXT NOT NULL
)
```

## 🚀 Lancement de l'application
```bash
flutter pub get
flutter run
```

## 💡 Bonus implémentés
- ✅ Compteur du nombre de rédacteurs en haut de la page
- ✅ Avatar avec initiale du prénom
- ✅ Design moderne et responsive
- ✅ Validation des champs
- ✅ Messages de confirmation pour toutes les actions
- ✅ État vide avec icône et message
- ✅ Navigation fluide depuis la page d'accueil Magazine

## 🎨 Palette de couleurs
- **Principal** : `#E91E63` (Rose/Magenta)
- **Texte foncé** : `#2C2C2C`
- **Texte gris** : `#666666`
- **Succès** : Vert
- **Erreur** : Rouge
- **Modification** : Bleu
