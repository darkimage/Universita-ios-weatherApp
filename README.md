## Progetto IOS Weather App [![relazione](https://img.shields.io/badge/relazione-disponibile%20in%20pdf-brightgreen)](https://github.com/darkimage/Universita-ios-weatherApp/raw/master/Documents/relazione_ios.pdf)

Progetto realizzato con [XCode](https://en.wikipedia.org/wiki/Xcode) e Objective-C.

l'applicazione consente di visualizzare all'utente le previsioni meteo per le citta da lui inserite. Ogni citta a la propria history, nella quale sono visualizzate le passate condizioni meteo. Ogni citta puo essere marcata come favorita e essere esportata su un file [CSV](https://it.wikipedia.org/wiki/Comma-separated_values) per poi essere ricaricate nell'applicazione.

Strutturata per utilizzare tutte le tecniche di sviluppo mobile quali:

 - Utilizzo del pattern di programmazione **MVC (Model-View-Controller)**
 - Utilizzo delle API [OpenWeatherMap](OpenWeatherMap) per i dati relativi al meteo.
 - Utilizzo di [Skeleton View](https://uxdesign.cc/what-you-should-know-about-skeleton-screens-a820c45a571a).
	 > Consento di mostrare all'utente una interfaccia provvisoria mentre vengono recuperati i dati che saranno poi mostrati quando disponibili risultando cosi in una esperienza piu gradevo per l'utente senza continui loading screens.
	 
- Utilizzo di richieste Http asincrone.

Traccia Progetto
---------------------
#### Main Technologies 

 - Storage Options
	 - Database (SQLite, CoreData)
	 - File with JSON Format 
 - HTTP Client (Native library or external library) 
 - Open Data Weather provider (JSON Preferred) 
#### Requirement/Functionalities 
 - The user can search a City and view Weather Information
 - Weather information should be retrieved on-demand through an HTTP Call (not on 
the main Thread)
 - The user can save a City as Favourite
 - When the user retrieve the Weather info for a Favourite City the data must be stored 
and showed in a dedicated History View  
#### Extra Features 

 - Export and Import Favourite Cities as CSV File

 Pattern MVC
----------------
Il pattern di programmazione MVC e' utilizzato per la realizzione di interfacce grafiche da presentare all'utente.
la sigla MVC sta per Model View Controller ovvero la sudivisione del codice in differenti componenti ognuno con la propria funzione:

<p align="center">
  <img width="241" height="220" src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/MVC-Process.png/220px-MVC-Process.png">
  <p align="right" size="16px"><sub>Wikipedia - public domain</sub></p>
</p>

 - **Model**: fornisce l'accesso ai dati dell'applicazione (Storage, solitamente un database relazionale/non relazionale o anche semplici file)
 - **View**: visualizza i dati contenuti nel model, le view sono struttare in modo da essere indipendenti dai dati che devono visualizzare rendendo cosi possibile riutilizzarle efficentemente. Si occupano anche dell'interazione con l'utente finale.
 - **Controller**: Il controller realizza la gestione dell'input dell'utente e insieme al Model crea la parte del codice chiamata [Business logic](https://it.wikipedia.org/wiki/Business_logic).

Struttura 
-----------------
Tutte le query per il ricevimento dati sono fatte utilizzando il networking in modo **asincrono** cosi da garantire una user experience il più fluida possibile anche grazie all’uso di **Skeleton View** che consentono di all’utente di avere transizioni fluide durante il caricamento dei dati. 

L’app e stata anche strutturata in modo da risultare modulare utilizzando il pattern **Facade** per astrarre le varie implementazioni dei vari componenti chiave dell’app quali il database, la comunicazione con le API (Networking), e la gestione delle view in background, la classe **WeatherAppModel  (Singleton class)** provvede a questo scopo ed è utilizzata nell’itera app. 

Per una efficiente gestione della memoria è stato utilizzato il sistema **ARC (Automatic Reference Counting)** 

<p align="center">
  <img width="783" height="453" src="https://raw.githubusercontent.com/darkimage/Universita-ios-weatherApp/master/Documents/iOS_Facade.jpg">
</p>

Networking
-------------------
La tipologia di app la rende pesantemente basata sull’utilizzo di API esterne con richiesta tramite **HTTP (HyperText Trasfer Protocol)** per il recupero dei dati metereologici. 

Nell’app la classeresponsabile di gestire queste richieste e restituire i dati è la classe **WeatherData** e protocollo **WeatherModelDelegate** per la gestione asincrona degli eventi per la UI. 

```objective-c

-(void) getCityCurrentWeatherbyId:(NSNumber*)city_id withSelector:(SEL)selector ofObject:(id)object;{ 
    [[[NSURLSession sharedSession] dataTaskWithRequest:[self setUpRequestAPI:@"weather?id=%@",city_id] 
            completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) { 
                [self callCallback:selector ofObject:object withData:data]; 
            }] resume]; 
} 
```
Per questa classe (a solo scopo di sperimentazione) sono stato usati i callback tramite selectors,callback tramite l’utilizzo dei blocks sono stati utilizzati nella classe **AnimatedBackground** e la categoria che la classe utilizza come input di dati **NSValue+AnimBackgroundData**, qui e mostrata la funzione helper che invoca il 
selector. 

```objective-c

-(void) callCallback:(SEL)selector ofObject:(id)object withData:(NSData *)data{ 
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[object methodSignatureForSelector:selector]]; 
    [inv setSelector:selector]; 
    [inv setTarget:object]; 
    [inv setArgument:&data atIndex:2]; //gli argomenti 0 e 1 sono rispettivamente self e _cmd, settati automaticamente da NSInvocation 
    [inv invoke]; 
} 
```

Aggiornamento asincrono interfaccia utente
------------------------------------

Ogni **WeatherViewController** detiene un riferimento alla classe **CityWeather** che viene utilizzata per ricevere gli aggiornamenti sia iniziati dall’utente sia quelli stabiliti dall’applicazione. 

Ogni **WeatherViewController** si registra come *delegate* della propria classe **CityWeather** in questo modo tramite l’implementazione del protocollo **WeatherModelDelegate** e possibile conosce quanto si e iniziato l’aggiornamento dei dati durante inizio dell’aggiornamento i corrente visualizzato **WeatherViewController** informa tutte le proprie views che un aggiornamento e stato iniziato e che quindi i dati che stanno attualmente mostrati sono probabilmente non attuali per creare una transizione non distruttiva e far capire all’utente che un aggiornamento sta venendo eseguito vengono mostrati al posto delle view le ***SkeletalView*** come mostrato nell’immagine qui accanto, ogni view gestisce le proprie skeletal views, che vengono tolte quando i dati sono nuovamente disponibili. 

La stessa cosa viene impiegata nella gestione della **WeatherBackgroundView** in questo caso la classe **AnimatedBackground** conensete di eseguire transizioni da un preset all’atro in modo non distruttivo. 

Alla fine dell’aggiornamento la classe **WeatherViewController** e nuovamente notificata che i dati sono disponibili oppure che e stato rilevato qualche errore e di conseguenza la classe informa tutte le sue views di aggiornarsi oppure di ritornare a una versione in memoria dei dai in caso di errore. 

<p align="center">
  <img width="280" height="550" src="https://raw.githubusercontent.com/darkimage/Universita-ios-weatherApp/master/Documents/ios_skeletal.png">
</p>
