# Logica richieste back e front e plugin

## Il front end GET o POST di front e back
### GET
- L'utente potrebbe chiedere di voler vedere il profilo; di conseguenza, farà un GET e, con il suo accesso autorizzato, chiederà al back-end di mostrare i suoi dati. Stessa cosa se va nel sito: anche senza accesso potrà vedere la tabella di classifica, quindi eseguirà un GET al back-end per vedere i dati.
- Quando vorrà chiedere accesso alla pagina e alle diverse pagine private per lui, o quando vorrà modificare il suo profilo, ad esempio cambiare il nome, dovrà avere un ID o IP bannabile.
- Utilizzo di parametri per il sortimento, tipo quando clicchi "Top 3 in classifica", "Top 5 in classifica", aggiornamenti in Typescript, ecc.
- Caching.
- Richiesta del token generato solo una volta.

### POST
- Il POST può inviare dati, ad esempio nuove foto da mettere sul profilo, foto profilo, wallpaper, ecc.
- Oppure, alla creazione dell'account, invierà all'utente i dati inseriti.
- Aggiornamento dei propri dati.
- O quando si crea un post o si messaggia.

### Backend gestisce i POST e i GET di front e back
- Appena riceve i GET, manderà messaggi di successo o di non fallimento.
- Aggiorna i dati quando, ad esempio, viene cambiato nome, immagine, ecc.
- Restituzione di risultati, ad esempio un messaggio in chat, errori o status.
- Richiesta del token ricevuto dall'utente.
- Con GET fornisce istantaneamente il tasto senza dover cercare i dati nel server, in questo modo riduce il carico sul server e accelera i tempi di risposta.

## Il backend GET e POST swag (SSR)
Esempio di SSR (Server Side Rendering):
- Gestisce il GET dal front end tramite il database, prendendo i dati e mostrandoli al front end.
Considerazione: di norma, il backend non invia richieste GET e POST. Sono più gestite dal front end che manda le richieste (fonte: documentazioni).
- Anche quando deve mostrare HTML o JSON all'utente, il back end riceve una richiesta GET dal front end che manderà HTML e JSON.
- Stessa cosa quando il front end chiede altre liste di utenti o post, ecc., come scritto sopra.
- Diversi POST vengono sempre dal front end per modificare la banca dati, ad esempio "nome utente", "i post", ecc.
- O eventuali restituzioni di richieste, ad esempio in caso di fallimento, ma vengono sempre da eventuali GET del front end. Il backend mostrerà il successo o fallimento, come il cambio di un nome o il non invio di un messaggio.
- Il server backend invierà POST quando, ad esempio, ci sono aggiornamenti o notifiche e cambiamenti di sistema per tutti gli utenti o solo per singoli. Potenzialmente, anche le notifiche possono essere un oggetto di POST da parte del backend, incluso l'invio di email.
- Oppure, per esempio, il backend deve mostrare i log delle chat; deve essere sempre aggiornato. La logica è: il front end scrive un messaggio, "un POST per il backend". Il backend gestisce il POST del front end, registra il messaggio, lo inserisce nella chat, forse in un database di chat. Il backend poi farà un POST al front end mostrandogli la chat aggiornata. Tutto questo, ovviamente, con gestione degli errori: se il front end manda un messaggio e non funziona, il backend dovrà avvisarlo.

## Altro esempio, ovvero POST e GET quando si parla di API: il backend fa richieste alle API
- Il backend fa un GET alle diverse API per ottenere altri dati o informazioni utili, ad esempio pagamenti PayPal.
- API per le immagini grafiche, collegamento con GitHub, collegamento con LinkedIn sono solo con il sito, visualizzazione LinkedIn, ecc., nel profilo utente.
- Il backend può fare potenzialmente richieste POST alle API dei dati ad altri server, ad esempio informazioni alla banca dati GitHub sui progressi, ecc.
- Potrebbe essere anche collegato a Gmail, GitHub, Git, LinkedIn o per gli accessi OAuth.
- Sincronizzazione di dati con altri server, tipo quelli di backup.

## Database banca dati di? Ovviamente, vedere come sono scritte. Esempio: creazione dell'account?
### Tabella Users che avrà:
- user_id
- email
- password_hash (sono password che utilizzano un certo livello di sicurezza)
- quando è stato creato l'account
- quando è stato aggiornato
- online
- se l'account è attivo
- se verificato con LinkedIn, Gmail o GitHub
- ruolo (se admin, giocatore vecchio, nuovo o uno tra i top player)
- numero di telefono

### Tabella tokens
- token_id (univoco identificatore)
- user_id (che collega il token all'utente corrispondente)
- token (valore del token, un token di sicurezza che potrebbe essere hashato)
- scadenza token
- creazione token
- tipo di token (accesso, ricarica o verifica)

### Tabella sulle preferenze di user
- preferenza tema
- preferenza immagine messa sulla foto profilo
- preferenza Linux distro
- GitHub
- combo usati molto spesso
- progetti completati
- git fatti (si può collegare con API, forse con GitHub)

### Tabella user logs
- click su post
- numero di post fatti
- post dell'utente
- azioni fatte
- giorno dell'azione
- tempo di online o utilizzo di nvim e tempo di permanenza sul sito
- messaggi inviati, ecc.

## Considerazioni di ciò che ho detto:
- Sicurezza: l'utilizzo di hash incrementa la sicurezza del nostro programma da front end a back end, o eventuali attacchi.
- Indici: ricerche più veloci con l'utilizzo di solo email, indice user, indici di creazioni nelle tabelle token.
- Rate limiting per attacchi brute-force.
- Autenticazione a 2FA con i numeri di telefono.
- Tracciatura di log sospetti, ecc.

## Perché token separati:
- Perché quando verrà generato un token, sarà collegato con user_id, che verificherà tutti i login. Verrà collegato subito dopo alla creazione di ID e sarà cambiabile in caso di necessità.
- Il token non sarà nell'utente perché potrebbe avere anche diversi token.

