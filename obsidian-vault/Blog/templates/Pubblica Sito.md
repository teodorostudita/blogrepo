<%* // Chiede all'utente un messaggio per il commit const commitMessage = await tp.system.prompt("Messaggio del commit (lascia vuoto per default):"); 

// ATTENZIONE: USA IL PERCORSO COMPLETO E ASSOLUTO DEL TUO SCRIPT! const scriptPath = "/Users/teodoro/Documents/ODONTOIATRIA/P-Med Smile/Sito e Blog/publish.sh"; 

// Costruisce il comando completo const command = `"${scriptPath}" "${commitMessage}"`; 

// Mostra una notifica di avvio new Notice("🚀 Avvio pubblicazione sito...", 5000); 

// Esegue il comando await tp.user.exec(command); 

// Mostra una notifica di completamento new Notice("✅ Pubblicazione completata! Il sito sarà live a breve.", 10000); _%>