/* =================================================================
   GESTORE LOGICA COOKIE
   ================================================================= */

document.addEventListener('DOMContentLoaded', () => {

    const getCookie = (name) => {
        const value = `; ${document.cookie}`;
        const parts = value.split(`; ${name}=`);
        if (parts.length === 2) return parts.pop().split(';').shift();
    };

    const setCookie = (name, value, days) => {
        let expires = "";
        if (days) {
            const date = new Date();
            date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
            expires = "; expires=" + date.toUTCString();
        }
        document.cookie = name + "=" + (value || "") + expires + "; path=/";
    };

    const cookieBanner = document.getElementById('cookieBanner');
    const cookieModal = document.getElementById('cookieModal');
    
    // Controlla se il cookie di consenso esiste già
    if (!getCookie('pmed_cookie_consent')) {
        setTimeout(() => {
            cookieBanner.classList.add('show');
        }, 1000);
    }
    
    const consent = (value) => {
        const settings = {
            necessary: true,
            analytics: value,
            marketing: value,
            preferences: value,
            timestamp: new Date().toISOString()
        };
        setCookie('pmed_cookie_consent', JSON.stringify(settings), 365);
        cookieBanner.classList.remove('show');
        cookieModal.classList.remove('show');
    };

    // Pulsanti del Banner
    document.getElementById('acceptAllCookies').addEventListener('click', () => consent(true));
    document.getElementById('rejectAllCookies').addEventListener('click', () => consent(false));
    document.getElementById('openCookieSettings').addEventListener('click', () => {
        cookieModal.classList.add('show');
        loadPreferencesIntoModal();
    });

    // Pulsanti della Modale
    document.querySelector('.modal-close').addEventListener('click', () => cookieModal.classList.remove('show'));
    document.getElementById('savePreferences').addEventListener('click', () => {
        const preferences = {
            necessary: true,
            analytics: document.getElementById('analytics').checked,
            marketing: document.getElementById('marketing').checked,
            preferences: document.getElementById('preferences').checked,
            timestamp: new Date().toISOString()
        };
        setCookie('pmed_cookie_consent', JSON.stringify(preferences), 365);
        cookieModal.classList.remove('show');
        cookieBanner.classList.remove('show');
    });

    // Gestione toggle switches
    const toggles = document.querySelectorAll('.toggle-switch:not(:has([disabled]))');
    toggles.forEach(toggle => {
        toggle.addEventListener('click', () => {
            const checkbox = toggle.querySelector('input[type="checkbox"]');
            checkbox.checked = !checkbox.checked;
            toggle.classList.toggle('active', checkbox.checked);
        });
    });

    const loadPreferencesIntoModal = () => {
        const cookieData = getCookie('pmed_cookie_consent');
        const settings = cookieData ? JSON.parse(cookieData) : { analytics: false, marketing: false, preferences: false };
        
        Object.keys(settings).forEach(key => {
            const checkbox = document.getElementById(key);
            if (checkbox) {
                checkbox.checked = settings[key];
                const toggle = document.getElementById(key + 'Toggle');
                if(toggle) toggle.classList.toggle('active', settings[key]);
            }
        });
    };
    
    // Chiudi la modale cliccando fuori
    cookieModal.addEventListener('click', (e) => {
        if (e.target === cookieModal) {
            cookieModal.classList.remove('show');
        }
    });
});