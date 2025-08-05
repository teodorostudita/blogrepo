#!/bin/bash

# --- CONFIGURAZIONE DEI PERCORSI ASSOLUTI ---
# Sostituisci i percorsi qui sotto con l'output che hai ottenuto dai comandi 'which'
PYTHON_PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin/python3"  # <-- METTI QUI IL TUO PERCORSO 'which python3'
GIT_PATH="/usr/bin/git"               # <-- METTI QUI IL TUO PERCORSO 'which git'

# --- CONFIGURAZIONE ARUBA ---
FTP_HOST="ftp.polidorionline.it"          
FTP_USER="17983806@aruba.it"
FTP_PASS="Malcolm.77"
REMOTE_PATH="/"

# --- SCRIPT DI PUBBLICAZIONE (non modificare da qui in poi) ---
cd "$(dirname "$0")"

LOG_FILE="publish_log.txt"
> "$LOG_FILE"

echo "🚀 Inizio processo di pubblicazione..." | tee -a "$LOG_FILE"
echo "--------------------------------------" | tee -a "$LOG_FILE"

# 1. Sincronizza i post (usando il percorso completo)
echo "🔄 Eseguo sync-blog.py con: $PYTHON_PATH" | tee -a "$LOG_FILE"
"$PYTHON_PATH" sync-blog.py >> "$LOG_FILE" 2>&1

# 2. Compila il sito Hugo
echo "🏗️  Compilo il sito Hugo..." | tee -a "$LOG_FILE"
cd SITO
hugo >> "../$LOG_FILE" 2>&1
cd ..

# 3. Aggiunge i file a Git (usando il percorso completo)
echo "➕ Aggiungo i file a Git con: $GIT_PATH" | tee -a "$LOG_FILE"
"$GIT_PATH" add . >> "$LOG_FILE" 2>&1

# 4. Crea il commit
MSG="$1"
if [ -z "$1" ]; then
  MSG="Aggiornamento sito e blog - $(date +'%Y-%m-%d %H:%M:%S')"
fi
echo "📦 Creo il commit con messaggio: '$MSG'" | tee -a "$LOG_FILE"
"$GIT_PATH" commit -m "$MSG" >> "$LOG_FILE" 2>&1

# 5. Invia a GitHub
echo "📤 Eseguo il push su GitHub..." | tee -a "$LOG_FILE"
"$GIT_PATH" push >> "$LOG_FILE" 2>&1

# 6. Deploy su Aruba via FTP
echo "🌐 Deploy su Aruba..." | tee -a "$LOG_FILE"
cd SITO/public

# Verifica che lftp sia installato
if ! command -v lftp &> /dev/null; then
    echo "❌ lftp non installato. Installa con: brew install lftp" | tee -a "../../$LOG_FILE"
    exit 1
fi

# Upload via FTP
lftp -c "
  set ftp:ssl-allow no
  set ftp:ssl-force no
  set ssl:verify-certificate no
  open -u $FTP_USER,$FTP_PASS ftp://$FTP_HOST
  mirror -R --delete --verbose --exclude-glob .git* --exclude-glob .DS_Store ./ $REMOTE_PATH
  quit
" >> "../../$LOG_FILE" 2>&1

if [ $? -eq 0 ]; then
    echo "✅ Deploy su Aruba completato!" | tee -a "../../$LOG_FILE"
else
    echo "❌ Errore durante il deploy su Aruba" | tee -a "../../$LOG_FILE"
fi

cd ../..

echo "--------------------------------------" | tee -a "$LOG_FILE"
echo "✅ Pubblicazione completata!" | tee -a "$LOG_FILE"

# Mostra le ultime righe del log
echo ""
echo "📋 Ultimi messaggi:"
tail -10 "$LOG_FILE"