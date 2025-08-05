#!/bin/bash

# --- CONFIGURAZIONE DEI PERCORSI ASSOLUTI ---
# Sostituisci i percorsi qui sotto con l'output che hai ottenuto dai comandi 'which'
PYTHON_PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin/python3"  # <-- METTI QUI IL TUO PERCORSO 'which python3'
GIT_PATH="/usr/bin/git"               # <-- METTI QUI IL TUO PERCORSO 'which git'

# --- SCRIPT DI PUBBLICAZIONE (non modificare da qui in poi) ---
cd "$(dirname "$0")"

LOG_FILE="publish_log.txt"
> "$LOG_FILE"

echo "🚀 Inizio processo di pubblicazione..." | tee -a "$LOG_FILE"
echo "--------------------------------------" | tee -a "$LOG_FILE"

# 1. Sincronizza i post (usando il percorso completo)
echo "🔄 Eseguo sync-blog.py con: $PYTHON_PATH" | tee -a "$LOG_FILE"
"$PYTHON_PATH" sync-blog.py >> "$LOG_FILE" 2>&1

# 2. Aggiunge i file a Git (usando il percorso completo)
echo "➕ Aggiungo i file a Git con: $GIT_PATH" | tee -a "$LOG_FILE"
"$GIT_PATH" add . >> "$LOG_FILE" 2>&1

# 3. Crea il commit
MSG="$1"
if [ -z "$1" ]; then
  MSG="Aggiornamento sito e blog - $(date +'%Y-%m-%d %H:%M:%S')"
fi
echo "📦 Creo il commit con messaggio: '$MSG'" | tee -a "$LOG_FILE"
"$GIT_PATH" commit -m "$MSG" >> "$LOG_FILE" 2>&1

# 4. Invia a GitHub
echo "📤 Eseguo il push su GitHub..." | tee -a "$LOG_FILE"
"$GIT_PATH" push >> "$LOG_FILE" 2>&1

echo "--------------------------------------" | tee -a "$LOG_FILE"
echo "✅ Pubblicazione completata!" | tee -a "$LOG_FILE"