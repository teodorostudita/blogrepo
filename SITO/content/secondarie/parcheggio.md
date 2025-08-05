---
title: "Dove Parcheggiare - Studio Dentistico Polidori"
description: "Trova parcheggio gratuito con facilità di fronte al nostro studio a Roma Nord (Isola Farnese). Consulta la mappa e le foto per arrivare al tuo appuntamento senza stress."
markup: "html"
---

<main>
    <section class="page-hero parcheggio-hero">
        <div class="page-hero-content">
            <h1>Parcheggio Facile e Gratuito</h1>
            <p>Arriva al tuo appuntamento senza stress.</p>
        </div>
    </section>

    <div class="page-container">

        <section class="page-section">
            <div class="section-content">
                <h2>La Mappa dei Parcheggi</h2>
                <p>Lo studio si trova a Isola Farnese, una zona di Roma dove è ancora possibile trovare parcheggio pubblico e gratuito con facilità, proprio di fronte all'ingresso. Consulta la mappa per orientarti.</p>
                <div class="map-container">
                    <iframe 
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2965.207850989396!2d12.39294931544978!3d42.00030097921258!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x132f607d53ffffff%3A0x7a8d0bde3f3f3f3f!2sVia%20Riccardo%20Morbelli%2C%2026%2C%2000123%20Roma%20RM!5e0!3m2!1sit!2sit!4v1664444444444!5m2!1sit!2sit" 
                        width="100%" 
                        height="450" 
                        style="border:0;" 
                        allowfullscreen="" 
                        loading="lazy">
                    </iframe>
                </div>
            </div>
        </section>
        
        <section class="page-section alternate-bg">
            <div class="section-content">
                <h2>I Nostri Parcheggi (Foto)</h2>
                <p>Qui puoi vedere alcune foto delle aree di parcheggio disponibili nelle immediate vicinanze dello studio.</p>
                <div class="gallery-grid">
                    <div class="gallery-item">
                        <img src="/Foto/Parcheggio_01.jpg" alt="Vista del parcheggio di fronte allo studio" class="gallery-thumbnail">
                    </div>
                    <div class="gallery-item">
                        <img src="/Foto/Parcheggio_02.jpg" alt="Altra angolazione del parcheggio" class="gallery-thumbnail">
                    </div>
                    <div class="gallery-item">
                        <img src="/Foto/Parcheggio_03.jpg" alt="Parcheggio laterale" class="gallery-thumbnail">
                    </div>
                </div>
            </div>
        </section>
    </div>
</main>

<div id="lightbox-modal" class="lightbox">
    <span class="lightbox-close">&times;</span>
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