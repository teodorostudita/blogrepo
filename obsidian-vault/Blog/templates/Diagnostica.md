<%*
let output = "--- Funzioni Disponibili in Templater ---\n\n";

output += "## Funzioni in tp.system:\n";
if (tp.system) {
    output += Object.keys(tp.system).join("\n");
} else {
    output += "tp.system non esiste.\n";
}

output += "\n\n## Funzioni in tp.user:\n";
if (tp.user) {
    output += Object.keys(tp.user).join("\n");
} else {
    output += "tp.user non esiste.\n";
}

// Aggiungiamo altri possibili "contenitori" di funzioni
output += "\n\n## Funzioni in tp.sys:\n";
if (tp.sys) {
    output += Object.keys(tp.sys).join("\n");
} else {
    output += "tp.sys non esiste.\n";
}

// Scrive l'output nella nota corrente
const activeFile = tp.file.find_tfile(tp.file.path(true));
await app.vault.modify(activeFile, output);

new Notice("Diagnostica completata!", 5000);
_%>