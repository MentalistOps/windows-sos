# Windows SOS - Manuale Salvavita Interattivo
# Creato per aiutare gli utenti a risolvere errori comuni di Windows 11

function Show-Menu {
    Clear-Host
    Write-Host "===============================" -ForegroundColor Cyan
    Write-Host "   WINDOWS SOS - SALVAVITA     " -ForegroundColor Yellow
    Write-Host "===============================" -ForegroundColor Cyan
    Write-Host "1. Schermata Blu (BSOD)"
    Write-Host "2. Nessuna Connessione Internet"
    Write-Host "3. Windows Update Bloccato"
    Write-Host "4. Nessun Suono"
    Write-Host "5. Accesso Bloccato (PIN)"
    Write-Host "0. Esci"
    Write-Host ""
}

function BSOD-Fix {
    Write-Host "`n[BSOD] Diagnostica in corso..." -ForegroundColor Cyan
    Write-Host "Eseguo controllo file di sistema..."
    sfc /scannow
    Write-Host "Controllo disco..."
    chkdsk /f /r
    Write-Host "`nSuggerimenti:"
    Write-Host "- Riavvia in modalità provvisoria"
    Write-Host "- Controlla la RAM con 'mdsched.exe'"
    Write-Host "- Disinstalla driver recenti"
}

function Network-Fix {
    Write-Host "`n[Rete] Diagnostica in corso..." -ForegroundColor Cyan
    Write-Host "Reset DNS e Winsock..."
    ipconfig /flushdns
    netsh winsock reset
    Write-Host "`nSuggerimenti:"
    Write-Host "- Riavvia modem e PC"
    Write-Host "- Usa DNS 8.8.8.8"
    Write-Host "- Reinstalla driver di rete"
}

function Update-Fix {
    Write-Host "`n[Windows Update] Diagnostica in corso..." -ForegroundColor Cyan
    Write-Host "Arresto servizi di aggiornamento..."
    net stop wuauserv
    net stop bits
    Write-Host "Pulizia cache..."
    Remove-Item "$env:SystemRoot\SoftwareDistribution\*" -Recurse -Force
    net start wuauserv
    net start bits
    Write-Host "`nSuggerimenti:"
    Write-Host "- Usa lo strumento di risoluzione problemi"
    Write-Host "- Aggiorna manualmente con Media Creation Tool"
}

function Audio-Fix {
    Write-Host "`n[Audio] Diagnostica in corso..." -ForegroundColor Cyan
    Write-Host "Verifica servizi audio..."
    Start-Process services.msc
    Write-Host "`nSuggerimenti:"
    Write-Host "- Controlla dispositivo audio predefinito"
    Write-Host "- Reinstalla driver audio"
}

function PIN-Fix {
    Write-Host "`n[Accesso] Diagnostica in corso..." -ForegroundColor Cyan
    Write-Host "Verifica stato sincronizzazione..."
    dsregcmd /status
    Write-Host "`nSuggerimenti:"
    Write-Host "- Accedi con password Microsoft"
    Write-Host "- Reimposta PIN da 'Opzioni di accesso'"
    Write-Host "- Verifica TPM con 'tpm.msc'"
}

do {
    Show-Menu
    $choice = Read-Host "Scegli un'opzione"
    switch ($choice) {
        "1" { BSOD-Fix }
        "2" { Network-Fix }
        "3" { Update-Fix }
        "4" { Audio-Fix }
        "5" { PIN-Fix }
        "0" { Write-Host "Uscita..." -ForegroundColor Red }
        default { Write-Host "Scelta non valida. Riprova." -ForegroundColor DarkRed }
    }
    if ($choice -ne "0") {
        Write-Host "`nPremi INVIO per tornare al menu..."
        Read-Host
    }
} while ($choice -ne "0")


📦 Come usarlo

1. Apri Blocco Note
2. Incolla lo script
3. Salva come `WindowsSOS.ps1`
4. Esegui con PowerShell come amministratore
