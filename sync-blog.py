#!/usr/bin/env python3
import os
import shutil
import yaml
import re
from pathlib import Path
from datetime import datetime

# Configurazione - AGGIORNA QUESTI PERCORSI
OBSIDIAN_BLOG_DIR = "/Users/teodoro/Documents/ODONTOIATRIA/P-Med Smile/Sito e Blog/obsidian-vault/Blog"
HUGO_CONTENT_DIR = "/Users/teodoro/Documents/ODONTOIATRIA/P-Med Smile/Sito e Blog/SITO/content/blog"
OBSIDIAN_ATTACHMENTS = "/Users/teodoro/Documents/ODONTOIATRIA/P-Med Smile/Sito e Blog/obsidian-vault/Blog/attachments"

def process_markdown_file(file_path, output_dir):
    """Processa un file markdown e lo converte per Hugo come Page Bundle"""
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Estrai front matter
    if content.startswith('---'):
        parts = content.split('---', 2)
        if len(parts) >= 3:
            front_matter = yaml.safe_load(parts[1])
            body = parts[2].strip()
        else:
            front_matter = {}
            body = content
    else:
        front_matter = {}
        body = content
    
    # Skip se è draft
    if front_matter.get('draft', False):
        print(f"⏭️  Saltando {file_path.name} (draft)")
        return
    
    # Crea slug dal titolo o nome file
    title = front_matter.get('title', file_path.stem)
    slug = re.sub(r'[^\w\s-]', '', title).strip().lower()
    slug = re.sub(r'[\s_-]+', '-', slug)
    
    # Crea directory del post (Page Bundle)
    post_dir = output_dir / slug
    post_dir.mkdir(exist_ok=True)
    
    # Processa le immagini e copia nella cartella del post
    body, copied_images = process_images(body, file_path.parent, post_dir)
    
    # Se ci sono immagini, aggiorna il front matter per la cover
    if copied_images and not front_matter.get('cover', {}).get('image'):
        # Usa la prima immagine come cover se non specificata
        first_image = copied_images[0]
        if 'cover' not in front_matter:
            front_matter['cover'] = {}
        front_matter['cover']['image'] = first_image
        front_matter['cover']['relative'] = True
    
    # Scrivi il file index.md nella cartella del post
    output_file = post_dir / "index.md"
    with open(output_file, 'w', encoding='utf-8') as f:
        if front_matter:
            f.write('---\n')
            yaml.dump(front_matter, f, default_flow_style=False, allow_unicode=True)
            f.write('---\n\n')
        f.write(body)
    
    images_info = f" ({len(copied_images)} immagini)" if copied_images else ""
    print(f"✅ Page Bundle creato: {title} → {slug}/{images_info}")

def process_images(content, source_dir, target_dir):
    """Processa le immagini nel contenuto markdown e le copia nella cartella del post"""
    
    copied_images = []
    
    # Pattern per immagini Obsidian: ![[immagine.png]] o ![alt](immagine.png)
    patterns = [
        r'!\[\[([^\]]+)\]\]',  # ![[immagine.png]]
        r'!\[([^\]]*)\]\(([^)]+)\)'  # ![alt](immagine.png)
    ]
    
    def replace_image(match):
        nonlocal copied_images
        
        if len(match.groups()) == 1:
            # Pattern ![[immagine.png]]
            image_name = match.group(1)
            alt_text = ""
        else:
            # Pattern ![alt](immagine.png)
            alt_text = match.group(1)
            image_name = match.group(2)
        
        # Trova l'immagine
        image_path = find_image(image_name, source_dir)
        if image_path and image_path.exists():
            # Copia l'immagine nella directory del post (stesso nome)
            target_image = target_dir / image_path.name
            shutil.copy2(image_path, target_image)
            copied_images.append(image_path.name)
            
            # Ritorna il nuovo link Hugo (solo nome file, non percorso)
            return f'![{alt_text}]({image_path.name})'
        else:
            print(f"⚠️  Immagine non trovata: {image_name}")
            return match.group(0)
    
    # Applica le sostituzioni
    for pattern in patterns:
        content = re.sub(pattern, replace_image, content)
    
    return content, copied_images

def find_image(image_name, source_dir):
    """Trova un'immagine nella directory degli attachments"""
    
    # Cerca nella directory attachments
    attachments_dir = Path(OBSIDIAN_ATTACHMENTS)
    if attachments_dir.exists():
        image_path = attachments_dir / image_name
        if image_path.exists():
            return image_path
    
    # Cerca nella stessa directory del file
    image_path = source_dir / image_name
    if image_path.exists():
        return image_path
    
    return None

def sync_blog():
    """Sincronizza i post del blog da Obsidian a Hugo"""
    
    obsidian_dir = Path(OBSIDIAN_BLOG_DIR)
    hugo_dir = Path(HUGO_CONTENT_DIR)
    
    # Crea la directory Hugo se non esiste
    hugo_dir.mkdir(parents=True, exist_ok=True)
    
    # Pulisci la directory Hugo (opzionale)
    # shutil.rmtree(hugo_dir)
    # hugo_dir.mkdir(parents=True, exist_ok=True)
    
    print("🚀 Inizio sincronizzazione blog...")
    
    # Processa tutti i file .md nella directory Blog
    for md_file in obsidian_dir.glob("*.md"):
        if md_file.name.startswith('.') or 'template' in md_file.name.lower():
            continue
        
        try:
            process_markdown_file(md_file, hugo_dir)
        except Exception as e:
            print(f"❌ Errore processando {md_file.name}: {e}")
    
    print("✨ Sincronizzazione completata!")

if __name__ == "__main__":
    sync_blog()