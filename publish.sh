#!/bin/bash

echo "🚀 Inizio processo di pubblicazione..."

# 1. Sincronizza i post da Obsidian a Hugo
echo "🔄 Eseguo lo script di sincronizzazione del blog..."
python3 sync-blog.py

# 2. Aggiunge tutte le modifiche a Git
echo "➕ Aggiungo tutti i file modificati a Git (staging)..."
git add .

# 3. Crea il commit con un messaggio di default o personalizzato
# Se fornisci un messaggio allo script (es. ./publish.sh "Mio messaggio"), usa quello. Altrimenti, ne usa uno standard.
MSG="$1"
if [ -z "$1" ]; then
  MSG="Aggiornamento sito e blog - $(date +'%Y-%m-%d %H:%M:%S')"
fi
echo "📦 Creo il commit con messaggio: '$MSG'"
git commit -m "$MSG"

# 4. Invia le modifiche a GitHub (e quindi a Netlify)
echo "📤 Eseguo il push su GitHub..."
git push

echo "✅ Fatto! Il sito sarà online tra un paio di minuti."