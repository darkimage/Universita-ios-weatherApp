//
//  SQLManager.m
//  WeatherApp
//
//  Created by Luca Faggion on 22/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "SQLManager.h"


//PRIVATE CLASS SECTION
//metodi e proprieta private della classe
@interface SQLManager()

@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFilename;
@property (nonatomic,strong) NSMutableArray* resultArray;

-(void) copyDatabaseToDocuments; //Copia il database dal boundle alla cartella documents
-(void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable; // core metodo privato per l esecuzione delle query (compiled e non)

@end


//MAIN IMPLEMETATION
@implementation SQLManager

-(instancetype) initWithDatabaseName:(NSString *)name{
    self = [super init];
    if (self) {
        //setta la path documenti nella proprieta -documentsDirectory
        self.documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        
        self.databaseFilename = name;
        //Copiamo il database nella cartella documenti se necessario (siccome il database risiede nell
        //App boundle non e cosigliato modificarlo)
        [self copyDatabaseToDocuments];
    }
    return self;
}

-(void) copyDatabaseToDocuments{
    NSString* destPath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    //il database esiste gia? se no, lo copiamo
    BOOL fileexist =[[NSFileManager defaultManager] fileExistsAtPath:destPath];
    if(!fileexist){
        NSString* sourceStr = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:self.databaseFilename];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourceStr toPath:destPath error:&error];
        
        //mostriamo eventuali errori
        if(error!= nil){
            //implement error message to user
            NSLog(@"%@", [error localizedDescription]);
        }
        
    }
}

-(void) runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable{
    sqlite3* sqlite3db;
    
    //inizializiamo le proprieta, e cancelliamo la memoria nel caso qualcosia sia ancora referenziato
    NSString *databasePath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    if(self.resultArray != nil){
        [self.resultArray removeAllObjects];
        self.resultArray = nil;
    }
    self.resultArray = [[NSMutableArray alloc]init];
    
    if(self.arrColumnNames != nil){
        [self.arrColumnNames removeAllObjects];
        self.arrColumnNames = nil;
    }
    self.arrColumnNames = [[NSMutableArray alloc] init];
    
    
    //apriamo il dabase
    BOOL openDatabaseRes = sqlite3_open_v2([databasePath UTF8String], &sqlite3db, SQLITE_OPEN_READWRITE, "unix");
    if(openDatabaseRes == SQLITE_OK){
        sqlite3_stmt *compiledStatement;
        //carica i dati dal database in memeoria
        BOOL prepareStatementResult = sqlite3_prepare_v2(sqlite3db, query, -1, &compiledStatement, NULL);
        if(prepareStatementResult == SQLITE_OK) {
            
            if (!queryExecutable){
                //in questo caso i dati devono essere caricati dal database
                NSMutableArray *arrDataRow; // array per i risultati per ogni riga
                while(sqlite3_step(compiledStatement) == SQLITE_ROW) { //loop ogni riga
                    arrDataRow = [[NSMutableArray alloc] init];
                    int totalColumns = sqlite3_column_count(compiledStatement); //numero di colonne
                    
                    for (int i=0; i<totalColumns; i++){ //loop per ogni colonna
                        char *dbDataAsChars = (char *)sqlite3_column_text(compiledStatement, i); //fetch data
                        if (dbDataAsChars != NULL) { //se ci sono dati gli aggiungiamo all' array
                            [arrDataRow addObject:[NSString  stringWithUTF8String:dbDataAsChars]];
                        }
                        if (self.arrColumnNames.count != totalColumns) { //salva il nome della colonna
                            dbDataAsChars = (char *)sqlite3_column_name(compiledStatement, i);
                            [self.arrColumnNames addObject:[NSString stringWithUTF8String:dbDataAsChars]];
                        }
                    }
                    if (arrDataRow.count > 0) { // storiamo i risultati (se ce ne sono)
                        [self.resultArray addObject:arrDataRow];
                    }
                }
            }
            else{
                //caso per una query exeguibile (insert,update, create....)
                if (sqlite3_step(compiledStatement) == SQLITE_DONE) {
                    // salva le rige che sono state influenzate
                    self.affectedRows = sqlite3_changes(sqlite3db);
                    
                    // salva id dell' ultima riga inserita
                    self.lastInsertedRowID = sqlite3_last_insert_rowid(sqlite3db);
                }
                else {
                    //implement error message to user
                    NSLog(@"DB Error: %s", sqlite3_errmsg(sqlite3db));
                }
            }
            sqlite3_finalize(compiledStatement); //rilasciamo lo statement
        }else{
            //implement error message to user
            NSLog(@"Statement Preparation error:%s", sqlite3_errmsg(sqlite3db));
        }
        sqlite3_close(sqlite3db); //chiudiamo il database
    }else{
        //implement error message to user
        NSLog(@"Cannot open Database error:%s", sqlite3_errmsg(sqlite3db));
    }
    
}

-(NSArray*)loadDataFromDB:(NSString *)query{
    
    [self runQuery:[query UTF8String] isQueryExecutable:NO];
    return (NSArray *)self.resultArray; //nota il risultato viene castato in un tipo NON MODIFICABILE!!
}

-(void)executeQuery:(NSString *)query{
    [self runQuery:[query UTF8String] isQueryExecutable:YES];
}

@end