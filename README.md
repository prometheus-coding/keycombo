# keycombo NVIM plugin

---

### **LINK UTILI:**
- **Spiegazione Progetto:** (https://github.com/MindfulLearner/keycombo/blob/main/keycombo-specification.md)
- **Keycombo Spiegazione Logica Frontend Backend Plugin LOGIC:** (https://www.figma.com/board/YVIINLHGLZdlFlwzhvX9lF/keycombo-logica?node-id=0-1&t=SjNAGJUTUMNpozuA-1)
- **Spiegazione GET POST Frontend Backend e DATABASE:** (https://github.com/MindfulLearner/keycombo/blob/main/logica-richieste.md)
- **Keycombo Frontend UIX:** (https://www.figma.com/design/0TVrIo7hwvXkJc1WcZe0SO/Untitled?t=JVKbxEZ6fgLnyCZS-1)


---

### **Backend**
**Task per il backend:**

**Livello Base:**
1. **Creare la tabella `Users` nel database:**
   - **Descrizione:** Creare una tabella chiamata `Users` con i seguenti campi:
     - `user_id` (tipo: UUID, chiave primaria)
     - `email` (tipo: VARCHAR, unico)
     - `password_hash` (tipo: VARCHAR, hash della password)
     - `created_at` (tipo: TIMESTAMP, valore di default `CURRENT_TIMESTAMP`)
     - `updated_at` (tipo: TIMESTAMP, aggiornato automaticamente all'update)
     - `is_online` (tipo: BOOLEAN, valore di default `FALSE`)
     - `is_active` (tipo: BOOLEAN, valore di default `TRUE`)
     - `role` (tipo: ENUM, valori possibili: 'admin', 'user', 'guest')
     - `phone_number` (tipo: VARCHAR, opzionale)
   - **Output atteso:** Script SQL per la creazione della tabella e conferma della creazione nel database.

2. **Creare la tabella `tokens` nel database:**
   - **Descrizione:** Creare una tabella chiamata `tokens` con i seguenti campi:
     - `token_id` (tipo: UUID, chiave primaria)
     - `user_id` (tipo: UUID, chiave esterna che riferisce a `Users.user_id`)
     - `token` (tipo: VARCHAR, il token generato)
     - `expiration_date` (tipo: TIMESTAMP, data di scadenza del token)
     - `created_at` (tipo: TIMESTAMP, valore di default `CURRENT_TIMESTAMP`)
     - `token_type` (tipo: ENUM, valori possibili: 'access', 'refresh')
     - `linux_distro` (tipo: VARCHAR, opzionale)
   - **Output atteso:** Script SQL per la creazione della tabella e conferma della creazione nel database.

3. **Implementare un endpoint POST per la registrazione degli utenti:**
   - **Descrizione:** Creare un endpoint `/api/register` che accetta una richiesta POST con i seguenti parametri:
     - `email`, `password`, `phone_number` (opzionale).
   - **Azioni:** Validare i dati in ingresso, hash della password, inserimento dei dati nel database.
   - **Output atteso:** Endpoint funzionante, test API con Postman o simili, e documentazione per l'uso.

4. **Implementare l'autenticazione degli utenti:**
   - **Descrizione:** Creare un sistema di autenticazione che permetta agli utenti di loggarsi tramite email e password. Generare un token JWT al momento del login.
   - **Azioni:** Verifica email/password, generazione del token, salvataggio del token nel database `tokens`.
   - **Output atteso:** Endpoint `/api/login` funzionante, test API con Postman, e documentazione per l'uso.

**Livello Intermedio:**
5. **Gestire il POST dei dati inviati dal plugin:**
   - **Descrizione:** Creare un endpoint `/api/trackusage` per ricevere dati JSON dal plugin. Questi dati devono essere salvati e associati all'utente che ha inviato la richiesta.
   - **Azioni:** Analisi dei dati in ingresso, aggiornamento del database, gestione degli errori.
   - **Output atteso:** Endpoint funzionante con test API, e documentazione.

6. **Implementare il GET per la verifica del token:**
   - **Descrizione:** Creare un endpoint `/api/verifytoken` che accetta richieste GET per verificare la validità di un token.
   - **Azioni:** Validazione del token ricevuto, controllo della scadenza, risposta con status 200 se valido.
   - **Output atteso:** Endpoint funzionante con test API, e documentazione.

7. **Implementare il GET per richiedere aggiornamenti dal server:**
   - **Descrizione:** Creare un endpoint `/api/getupdates` che fornisce al plugin aggiornamenti e informazioni rilevanti.
   - **Azioni:** Configurare la logica per il recupero degli aggiornamenti, gestione delle risposte.
   - **Output atteso:** Endpoint funzionante con test API, e documentazione.

8. **Gestire l'invio di alert per attività sospette:**
   - **Descrizione:** Implementare un endpoint `/api/reportalert` che riceve segnalazioni di attività sospette e le memorizza per analisi future.
   - **Azioni:** Gestione delle richieste POST con dati JSON, salvataggio nel database, notifiche agli amministratori.
   - **Output atteso:** Endpoint funzionante con test API, e documentazione.

**Livello Avanzato:**
9. **Implementare la sincronizzazione con altri server:**
   - **Descrizione:** Configurare la sincronizzazione automatica dei dati tra il server principale e uno o più server di backup.
   - **Azioni:** Configurare cron job, script di sincronizzazione, gestione errori di rete.
   - **Output atteso:** Script di sincronizzazione funzionanti, test, e documentazione.

10. **Gestire le notifiche e aggiornamenti di sistema:**
    - **Descrizione:** Implementare un sistema di notifiche push per gli utenti registrati. Configurare endpoint POST per inviare notifiche.
    - **Azioni:** Configurare una coda di notifiche, gestire la logica di invio, testare con utenti.
    - **Output atteso:** Notifiche funzionanti, test, e documentazione.

11. **Integrare API esterne:**
    - **Descrizione:** Implementare l'integrazione con API esterne come GitHub, LinkedIn, PayPal per aggiungere funzionalità avanzate al sistema.
    - **Azioni:** Configurare le chiamate API, gestione token API, gestione errori.
    - **Output atteso:** API integrate, test, e documentazione.

12. **Implementare il Server-Side Rendering (SSR):**
    - **Descrizione:** Configurare il backend per gestire il rendering di pagine HTML e JSON in risposta alle richieste GET.
    - **Azioni:** Configurare SSR, ottimizzare per SEO, gestire cache.
    - **Output atteso:** SSR funzionante, test con diverse richieste, e documentazione.

---

### **Frontend**
**Task per il Frontend:**

**Livello Base:**
1. **Implementare la pagina di registrazione utenti:**
   - **Descrizione:** Creare un form per la registrazione degli utenti con i seguenti campi: email, password, conferma password e numero di telefono (opzionale).
   - **Azioni:** Validazione dei campi lato client, invio dei dati tramite una richiesta POST all'endpoint `/api/register`.
   - **Output atteso:** Pagina di registrazione funzionante con gestione errori e successo, documentazione per l'uso.

2. **Implementare la pagina di login:**
   - **Descrizione:** Creare un’interfaccia per l’autenticazione degli utenti con campi email e password.
   - **Azioni:** Validazione dei campi lato client, invio dei dati tramite una richiesta POST all'endpoint `/api/login`, gestione della sessione utente.
   - **Output atteso:** Pagina di login funzionante con gestione degli stati (autenticato/non autenticato), documentazione per l'uso.

3. **Creare la pagina di visualizzazione del profilo utente:**
   - **Descrizione:** Mostrare i dati dell'utente loggato (es. email, numero di telefono, ruolo) e permettere modifiche base come cambio password.
   - **Azioni:** Recupero dati dal backend tramite GET, implementazione del form per le modifiche, gestione errori e successi.
   - **Output atteso:** Pagina del profilo funzionante, test e documentazione.

4. **Implementare l’interfaccia per la visualizzazione della classifica:**
   - **Descrizione:** Creare una pagina accessibile anche senza login che mostra la classifica degli utenti.
   - **Azioni:** Recupero dati tramite GET, visualizzazione in una tabella o lista ordinata, gestione di filtri o ordinamenti se necessario.


   - **Output atteso:** Pagina della classifica funzionante, test e documentazione.

**Livello Intermedio:**
5. **Gestire le preferenze utente:**
   - **Descrizione:** Creare un'interfaccia che permetta all'utente di modificare le sue preferenze come tema, immagine del profilo, e notifiche.
   - **Azioni:** Recupero delle preferenze attuali tramite GET, aggiornamento delle preferenze tramite POST, feedback all'utente.
   - **Output atteso:** Gestione delle preferenze funzionante, test e documentazione.

6. **Implementare la dashboard per la gestione delle azioni utente:**
   - **Descrizione:** Creare una dashboard che visualizzi cronologia post, attività recenti, e statistiche personali.
   - **Azioni:** Recupero dei dati tramite API, visualizzazione in una interfaccia organizzata, possibilità di filtrare o ordinare le informazioni.
   - **Output atteso:** Dashboard funzionante, test e documentazione.

7. **Configurare il frontend per utilizzare il caching:**
   - **Descrizione:** Migliorare la velocità di caricamento utilizzando caching lato client per le risorse statiche e dati frequentemente richiesti.
   - **Azioni:** Implementazione di caching tramite service workers o librerie specifiche, gestione del refresh dei dati.
   - **Output atteso:** Caching funzionante, test delle prestazioni e documentazione.

8. **Gestire le notifiche di errore e di successo:**
   - **Descrizione:** Implementare un sistema di notifiche per informare l'utente di errori (es. login fallito) o successi (es. aggiornamento profilo riuscito).
   - **Azioni:** Configurazione di notifiche toast o modali, gestione dei messaggi di feedback, visualizzazione coerente in tutto il sito.
   - **Output atteso:** Notifiche funzionanti, test e documentazione.

**Livello Avanzato:**
9. **Implementare l’autenticazione a due fattori (2FA):**
   - **Descrizione:** Creare un'interfaccia che consenta agli utenti di attivare e configurare l'autenticazione a due fattori, inserendo un codice ricevuto via SMS o app.
   - **Azioni:** Generazione e invio del codice tramite API, verifica del codice inserito dall'utente, gestione dell'attivazione/disattivazione della 2FA.
   - **Output atteso:** 2FA funzionante, test e documentazione.

10. **Integrare le API esterne:**
    - **Descrizione:** Visualizzare dati da API esterne come GitHub, LinkedIn, ecc., nel profilo utente.
    - **Azioni:** Configurare richieste API, visualizzare i dati nel profilo utente, gestire errori e aggiornamenti.
    - **Output atteso:** Integrazione API funzionante, test e documentazione.

11. **Implementare il Server-Side Rendering (SSR):**
    - **Descrizione:** Configurare il frontend per ricevere e visualizzare pagine renderizzate dal server per migliorare il SEO e la velocità di caricamento iniziale.
    - **Azioni:** Configurazione SSR con il framework utilizzato (es. Next.js), gestione della cache, ottimizzazione del rendering.
    - **Output atteso:** SSR funzionante, test delle performance, e documentazione.

12. **Gestire le notifiche in tempo reale:**
    - **Descrizione:** Integrare un sistema per ricevere notifiche live dal backend tramite WebSocket o altre tecnologie di comunicazione in tempo reale.
    - **Azioni:** Configurazione del canale WebSocket, gestione delle notifiche in tempo reale, aggiornamento dinamico dell'interfaccia.
    - **Output atteso:** Notifiche in tempo reale funzionanti, test e documentazione.

---

### **Plugin** (Implementazione in Lua)
**Task per il Plugin:**

**Livello Base:**

1. **Creare la struttura base del plugin:**
   - **Descrizione:** Configurare la struttura del plugin in Lua che permetta l'invio di parametri JSON tramite POST al backend su `/api/trackusage`.
   - **Azioni:** Implementare la gestione dei POST per attività specifiche come invio dati relativi a completamento di progetti, commit, e numero di click effettuati.
   - **Output atteso:** Plugin funzionante per l'invio di dati al backend, test con Neovim, e documentazione.

2. **Interfaccia e funzionalità base:**
   - **Descrizione:** Implementare un'interfaccia piacevole in Neovim utilizzando Lua, con un design user-friendly. Aggiungere la possibilità di configurare suoni personalizzati o preimpostati in risposta a determinati eventi (es. combo o completamento task).
   - **Azioni:** Configurare l'interfaccia in Lua, gestire le configurazioni sonore, testare diverse combinazioni.
   - **Output atteso:** Interfaccia e configurazioni sonore funzionanti, test e documentazione.

**Livello Intermedio:**

3. **Gestire la connessione con il backend tramite GET:**
   - **Descrizione:** Implementare richieste GET per verificare il token e ottenere aggiornamenti dal server.
   - **Azioni:** Configurare le richieste GET in Lua, gestione delle risposte e degli errori, aggiornamento dell'interfaccia.
   - **Output atteso:** GET funzionante con test su Neovim, e documentazione.

4. **Implementare il monitoraggio e la gestione dei click:**
   - **Descrizione:** Configurare un timer in Lua che parte dopo un certo numero di click per determinare l'inizio e la fine di una sessione di scrittura. Implementare un sistema per evitare l'uso di autoclicker controllando il ritmo e il senso dei click.
   - **Azioni:** Implementare il timer, configurare i controlli sui click, gestione dei casi di abuso.
   - **Output atteso:** Monitoraggio click funzionante, test e documentazione.

5. **Monitoraggio del tempo di programmazione:**
   - **Descrizione:** Registrare e inviare al backend il totale delle ore passate a programmare in Neovim. Implementare un sistema per determinare automaticamente quando l'utente smette di scrivere e far partire un timer che interrompa il monitoraggio se l'attività si ferma per troppo tempo.
   - **Azioni:** Configurare il monitoraggio del tempo, gestione del timer, invio dati al backend.
   - **Output atteso:** Monitoraggio del tempo funzionante, test e documentazione.

6. **Controllo di file e sicurezza:**
   - **Descrizione:** Implementare controlli sui file gestiti dal plugin per assicurarsi che non vengano manipolati in modo malevolo. Validare e sanificare i dati JSON prima di inviarli al backend per evitare compromissioni.
   - **Azioni:** Implementare controlli di sicurezza sui file, sanificazione dati JSON, gestione degli errori.
   - **Output atteso:** Controlli di sicurezza funzionanti, test e documentazione.

7. **Considerare la compilazione in LuaC:**
   - **Descrizione:** Valutare la compilazione del plugin in LuaC (bytecode) per migliorare le prestazioni e la sicurezza. Configurare il processo di compilazione per generare i file LuaC necessari.
   - **Azioni:** Configurare l'ambiente di compilazione, generare file LuaC, testare le prestazioni e la sicurezza.
   - **Output atteso:** Plugin compilato in LuaC, test delle performance, e documentazione.

**Livello Avanzato:**

8. **Gestire la configurazione del plugin via GET dal backend:**
   - **Descrizione:** Ricevere configurazioni e informazioni dall’utente tramite GET dal backend, come la personalizzazione di combo e suoni. Implementare la visualizzazione e la gestione in tempo reale delle notifiche e degli alert inviati dal backend.
   - **Azioni:** Configurare il recupero delle configurazioni tramite GET, gestione delle notifiche in tempo reale, aggiornamento dinamico dell'interfaccia.
   - **Output atteso:** Configurazione e notifiche funzionanti, test su Neovim, e documentazione.

9. **Distribuzione del plugin tramite Packer:**
   - **Descrizione:** Strutturare il plugin per essere installato e gestito tramite Packer (il plugin manager per Neovim). Documentare le istruzioni per l'installazione del plugin tramite Packer, includendo le dipendenze e le configurazioni necessarie.
   - **Azioni:** Configurare il file `packer.lua`, scrivere la documentazione per l'installazione, testare l'installazione e la gestione del plugin.
   - **Output atteso:** Plugin distribuibile tramite Packer, test e documentazione.

10. **Distribuzione del plugin su GitHub:**
    - **Descrizione:** Organizzare il repository su GitHub in modo da rendere semplice l'accesso e l'utilizzo del plugin. Creare un README dettagliato con istruzioni su come scaricare, installare e configurare il plugin. Considerare l'uso di GitHub Actions per automatizzare la compilazione e la distribuzione del plugin.
    - **Azioni:** Configurare il repository, scrivere il README, configurare GitHub Actions per la CI/CD.
    - **Output atteso:**

 Plugin disponibile su GitHub, test della CI/CD, e documentazione.

11. **Ideazione e implementazione di nuove funzionalità:**
    - **Descrizione:** Pensare e proporre ulteriori idee per migliorare l'esperienza d'uso del plugin, come nuove metriche di performance, opzioni di personalizzazione, o ulteriori integrazioni con altre funzionalità di Neovim.
    - **Azioni:** Brainstorming con il team, pianificazione delle nuove funzionalità, implementazione e test.
    - **Output atteso:** Nuove funzionalità ideate e implementate, test e documentazione.

---
