<%*
try {
    const commitMessage = await tp.system.prompt("Messaggio del commit (lascia vuoto per default):");
    
    const scriptPath = "/Users/teodoro/Documents/ODONTOIATRIA/P-Med Smile/Sito e Blog/publish.sh";
    
    const command = `"${scriptPath}" "${commitMessage}"`;

    new Notice("🚀 Avvio pubblicazione sito...", 5000);

    // --- LA CORREZIONE È IN QUESTA RIGA ---
    const executionResult = await tp.sys.execute(command);

    if (executionResult) {
        console.log("Output dello script di pubblicazione:", executionResult);
    }

    new Notice("✅ Pubblicazione completata! Il sito sarà live a breve.", 10000);

} catch (error) {
    new Notice(`❌ Errore durante la pubblicazione: ${error.message}`, 15000);
    console.error("Dettagli dell'errore:", error);
}
_%>