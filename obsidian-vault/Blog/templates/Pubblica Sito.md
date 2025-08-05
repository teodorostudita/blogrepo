<%*
try {
    const commitMessage = await tp.system.prompt("Messaggio del commit (lascia vuoto per default):");
    
    const scriptPath = "/Users/teodoro/Documents/ODONTOIATRIA/P-Med Smile/Sito e Blog/publish.sh";
    
    const command = `"${scriptPath}" "${commitMessage}"`;

    new Notice("🚀 Avvio pubblicazione sito...", 5000);

    const executionResult = await tp.user.exec(command);

    // Per il debug, scrive l'output dello script nella console
    if (executionResult) {
        console.log("Output dello script di pubblicazione:", executionResult);
    }

    new Notice("✅ Pubblicazione completata! Il sito sarà live a breve.", 10000);

} catch (error) {
    // Se si verifica un errore, lo cattura e lo mostra in una notifica
    new Notice(`❌ Errore durante la pubblicazione: ${error.message}`, 15000);
    console.error("Dettagli dell'errore:", error);
}
_%>