# BC Dev Training

Trainings-Repository fuer den Git/GitHub Actions Kurs mit Business Central.

## Erste Schritte

### 1. Repo aus Template erstellen

Klicke oben auf **"Use this template"** → **"Create a new repository"** und erstelle dein eigenes Repo in der `it-erben` Organisation.

### 2. Repo klonen

```bash
git clone https://github.com/it-erben/<dein-repo-name>.git
cd <dein-repo-name>
```

### 3. App personalisieren

Dein Trainer teilt dir eine **Teilnehmernummer** zu. Fuehre dann das Setup-Script aus:

```bash
./setup.sh <nummer> "Dein Name"
# Beispiel:
./setup.sh 3 "Max Mustermann"
```

Das Script konfiguriert automatisch:
- Eindeutige App-ID
- Eigenen ID-Bereich (damit keine Konflikte mit anderen Teilnehmern entstehen)
- Deinen Namen als Publisher

### 4. Aenderungen committen und pushen

```bash
git add -A
git commit -m "chore: App personalisieren"
git push
```

### 5. CI/CD Pipeline beobachten

Gehe zu **Actions** in deinem GitHub-Repo und beobachte, wie die Pipeline deine App baut und in die Sandbox deployt.

## Projektstruktur

```
app/
  app.json                        <- App-Manifest (ID, Name, Version)
  TrainingItem.Table.al            <- Einfache Tabelle
  TrainingItems.Page.al            <- Listenseite fuer die Tabelle
  TrainingPermissions.PermissionSet.al <- Berechtigungen
  .vscode/launch.json              <- VS Code Konfiguration
.AL-Go/
  settings.json                    <- AL-Go Konfiguration (Land, Deployment-Ziel)
.github/workflows/                 <- CI/CD Pipelines (von AL-Go generiert)
setup.sh                           <- Setup-Script fuer Teilnehmer
```

## Hinweise

- Alle Teilnehmer deployen in dieselbe BC-Sandbox
- Das Setup-Script stellt sicher, dass jeder Teilnehmer eindeutige IDs hat
- Die Pipelines werden automatisch bei Push und Pull Request ausgeloest
