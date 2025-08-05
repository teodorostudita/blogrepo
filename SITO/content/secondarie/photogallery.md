---
title: "Photogallery - Studio Dentistico Polidori"
description: "Esplora la nostra photogallery per uno sguardo all'interno del nostro studio dentistico a Roma: dalla sala d'attesa alle sale operative."
markup: "html"
---

<main>
    <section class="page-hero photogallery-hero">
        <div class="page-hero-content">
            <h1>Photogallery</h1>
            <p>Uno sguardo all'interno del nostro studio.</p>
        </div>
    </section>
    <div class="page-container">
        <div class="gallery-grid">
            <div class="gallery-item"><img src="/Foto/Photogallery_01.jpeg" alt="Sala d'attesa dello studio dentistico" class="gallery-thumbnail"></div>
            <div class="gallery-item"><img src="/Foto/Photogallery_02.jpeg" alt="Reception dello studio" class="gallery-thumbnail"></div>
            <div class="gallery-item"><img src="/Foto/Photogallery_03.jpeg" alt="Sala operativa con poltrona dentistica" class="gallery-thumbnail"></div>
            <div class="gallery-item"><img src="/Foto/Photogallery_04.jpeg" alt="Strumentazione moderna per la sterilizzazione" class="gallery-thumbnail"></div>
            <div class="gallery-item"><img src="/Foto/Photogallery_05.jpeg" alt="Dettaglio della strumentazione" class="gallery-thumbnail"></div>
        </div>
    </div>
</main>

<div id="lightbox-modal" class="lightbox">
    <span class="lightbox-close">×</span>
    <img class="lightbox-content" id="lightbox-image">
    <div id="lightbox-caption"></div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const thumbnails = document.querySelectorAll('.gallery-thumbnail');
        const lightbox = document.getElementById('lightbox-modal');
        const lightboxImg = document.getElementById('lightbox-image');
        const lightboxCaption = document.getElementById('lightbox-caption');
        const closeBtn = document.querySelector('.lightbox-close');

        if (lightbox) {
            thumbnails.forEach(thumb => {
                thumb.addEventListener('click', function() {
                    lightbox.style.display = 'flex';
                    lightboxImg.src = this.src;
                    lightboxCaption.innerHTML = this.alt;
                });
            });

            const closeModalLightbox = () => {
                lightbox.style.display = 'none';
            };
            if(closeBtn) {
              closeBtn.addEventListener('click', closeModalLightbox);
            }
            lightbox.addEventListener('click', (e) => {
                if (e.target === lightbox) {
                    closeModalLightbox();
                }
            });
        }
    });
</script>