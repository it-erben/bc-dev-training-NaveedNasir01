#!/bin/bash
set -euo pipefail

if [ $# -ne 2 ]; then
  echo "Usage: ./setup.sh <participant-number> <your-name>"
  echo "Example: ./setup.sh 3 \"Max Mustermann\""
  exit 1
fi

NUMBER=$1
NAME=$2

if ! [[ "$NUMBER" =~ ^[0-9]+$ ]] || [ "$NUMBER" -lt 1 ] || [ "$NUMBER" -gt 20 ]; then
  echo "Error: Participant number must be between 1 and 20"
  exit 1
fi

# Calculate ID range: participant 1 = 50100-50149, participant 2 = 50150-50199, etc.
ID_FROM=$((50050 + NUMBER * 50))
ID_TO=$((ID_FROM + 49))
TABLE_ID=$ID_FROM
PAGE_ID=$ID_FROM
PERMISSIONSET_ID=$ID_FROM

# Generate deterministic GUID from participant number
GUID=$(printf "00000000-0000-0000-0000-%012d" "$NUMBER")

APP_NAME="Training App $NAME"

echo "Setting up for participant #$NUMBER ($NAME)"
echo "  App ID:    $GUID"
echo "  ID Range:  $ID_FROM - $ID_TO"
echo "  App Name:  $APP_NAME"
echo ""

# Update app.json
sed -i.bak "s/\"id\": \".*\"/\"id\": \"$GUID\"/" app/app.json
sed -i.bak "s/\"name\": \".*\"/\"name\": \"$APP_NAME\"/" app/app.json
sed -i.bak "s/\"publisher\": \".*\"/\"publisher\": \"$NAME\"/" app/app.json
sed -i.bak "s/\"from\": [0-9]*/\"from\": $ID_FROM/" app/app.json
sed -i.bak "s/\"to\": [0-9]*/\"to\": $ID_TO/" app/app.json

# Update AL files with new object IDs
sed -i.bak "s/table 50100/table $TABLE_ID/" app/TrainingItem.Table.al
sed -i.bak "s/page 50100/page $PAGE_ID/" app/TrainingItems.Page.al
sed -i.bak "s/permissionset 50100/permissionset $PERMISSIONSET_ID/" app/TrainingPermissions.PermissionSet.al

# Update launch.json startup object
sed -i.bak "s/\"startupObjectId\": 50100/\"startupObjectId\": $PAGE_ID/" app/.vscode/launch.json

# Enable deployment (disabled in template to prevent conflicts)
sed -i.bak 's/"environments": \[\]/"environments": ["training-sandbox"]/' .AL-Go/settings.json
sed -i.bak 's/"continuousDeployment": false/"continuousDeployment": true/' .AL-Go/settings.json

# Clean up backup files
find . -name "*.bak" -delete

echo "Done! Now run:"
echo "  git add -A"
echo "  git commit -m \"chore: setup for $NAME (participant #$NUMBER)\""
echo "  git push"
