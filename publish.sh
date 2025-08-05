#!/bin/bash

# --- Passaggio Chiave: Naviga nella cartella dello script ---
# Questo assicura che tutti i comandi (git, python) vengano eseguiti dal posto giusto.
cd "$(dirname "$0")"

# Definisce un file di log per registrare tutto
LOG_FILE="publish_log.txt"

# Pulisce il log precedente all'inizio di ogni esecuzione
> "$LOG_FILE"

echo "🚀 Inizio processo di pubblicazione..." | tee -a "$LOG_FILE"
echo "--------------------------------------" | tee -a "$LOG_FILE"

# 1. Sincronizza i post
echo "🔄 Eseguo sync-blog.py..." | tee -a "$LOG_FILE"
python3 sync-blog.py >> "$LOG_FILE" 2>&1

# 2. Aggiunge i file a Git
echo "➕ Aggiungo i file a Git..." | tee -a "$LOG_FILE"
git add . >> "$LOG_FILE" 2>&1

# 3. Crea il commit
MSG="$1"
if [ -z "$1" ]; then
  MSG="Aggiornamento sito e blog - $(date +'%Y-%m-%d %H:%M:%S')"
fi
echo "📦 Creo il commit con messaggio: '$MSG'" | tee -a "$LOG_FILE"
git commit -m "$MSG" >> "$LOG_FILE" 2>&1

# 4. Invia a GitHub
echo "📤 Eseguo il push su GitHub..." | tee -a "$LOG_FILE"
git push >> "$LOG_FILE" 2>&1

echo "--------------------------------------" | tee -a "$LOG_FILE"
echo "✅ Pubblicazione completata! Controlla il file publish_log.txt per i dettagli." | tee -a "$LOG_FILE"