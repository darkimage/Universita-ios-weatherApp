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

@property (nonatomic,strong) NSString *documentsDirectory;
@property (nonatomic,strong) NSString *databaseFilename;
@property (atomic,strong) NSMutableArray* resultArray;
@property (nonatomic,strong) NSString* city_table;
@property (nonatomic,strong) NSString* favorite_table;
@property (nonatomic,strong) NSString* history_table;

-(NSArray *)loadDataFromDB:(NSString *)query; //esegue una query di tipo not executable e ritorna i risultati
-(void)executeQuery:(NSString *)query; //esegue una query di tipo executable non ce ritorno di risultati perche sono accedibi tramite le proprieties (affectedRows,lastInsertedRowID)

-(void) copyDatabaseToDocuments; //Copia il database dal boundle alla cartella documents
-(void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable; // core metodo privato per l esecuzione delle query (compiled e non)

@end


//MAIN IMPLEMETATION
@implementation SQLManager

-(void)initProperties{
    _city_table = @"city_data";
    _favorite_table = @"added_city";
    _history_table = @"city_history";
}

-(instancetype)init{
    self = [super init];
    if (self) {
        //setta la path documenti nella proprieta -documentsDirectory
        _documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        
        _databaseFilename = @"WeatherDB.sql";
        //Copiamo il database nella cartella documenti se necessario (siccome il database risiede nell
        //App boundle non e cosigliato modificarlo)
        [self copyDatabaseToDocuments];
        [self initProperties];
    }
    return self;
}


-(instancetype) initWithDatabaseName:(NSString *)name{
    self = [super init];
    if (self) {
        _documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        _databaseFilename = name;
        [self copyDatabaseToDocuments];
        [self initProperties];
    }
    return self;
}

#pragma mark - PRIVATE METHODS

-(void) copyDatabaseToDocuments{
    NSString* destPath = [_documentsDirectory stringByAppendingPathComponent:_databaseFilename];
    //il database esiste gia? se no, lo copiamo
    BOOL fileexist =[[NSFileManager defaultManager] fileExistsAtPath:destPath];
    if(!fileexist){
        NSString* sourceStr = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:_databaseFilename];
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
        self.resultArray = [[NSMutableArray alloc] init];
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
        //carica i dati dal database in memoria
        BOOL prepareStatementResult = sqlite3_prepare_v2(sqlite3db, query, -1, &compiledStatement, NULL);
        if(prepareStatementResult == SQLITE_OK) {
            
            if (!queryExecutable){
                //in questo caso i dati devono essere caricati dal database
                NSMutableArray *arrDataRow; // array per i risultati per ogni riga
                while(sqlite3_step(compiledStatement) == SQLITE_ROW) { //loop ogni riga
                    arrDataRow = [[NSMutableArray alloc] init];
                    int totalColumns = sqlite3_column_count(compiledStatement); //numero di colonne
                    
                    for (int i=0; i<totalColumns; i++){ //loop per ogni colonna
                        sqlite3_value* column_value = sqlite3_column_value(compiledStatement, i); //data (puo essere di qualsiasi tipo)
                        int datatype = sqlite3_column_type(compiledStatement, i); //tipo della colonna
                        //char *dbDataAsChars = (char*)sqlite3_column_text(compiledStatement, i);
                        if (column_value != NULL) { //se ci sono dati gli aggiungiamo all' array
                            //in base al tipo della colonna
                            switch (datatype) {
                                case SQLITE_FLOAT:{
                                    [arrDataRow addObject:[NSString stringWithFormat:@"%f",sqlite3_value_double(column_value)]];
                                    break;
                                }
                                default:{
                                    char *dbDataAsChars = (char*)sqlite3_column_text(compiledStatement, i);
                                    [arrDataRow addObject:[NSString  stringWithUTF8String:dbDataAsChars]];
                                    break;
                                }
                            }
                        }
                        if (self.arrColumnNames.count != totalColumns) { //salva il nome della colonna
                            char* dbDataAsChars = (char *)sqlite3_column_name(compiledStatement, i);
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

#pragma mark - DBMANAGER OVERRIDES

-(NSArray*)loadDataFromDB:(NSString *)query{
    [self runQuery:[query UTF8String] isQueryExecutable:NO];
    return (NSArray*)self.resultArray; //nota il risultato viene castato in un tipo NON MODIFICABILE!!
}

-(void)executeQuery:(NSString *)query{
    [self runQuery:[query UTF8String] isQueryExecutable:YES];
}

-(NSArray*)getCitiesbyPartialName:(NSString *)partialname{
    NSString* query = [NSString stringWithFormat:@"select * from %@ where name like '%@%%'",self.city_table,partialname];
    return [self loadDataFromDB:query];
}


-(NSArray*)getCitiesbyPartialName:(NSString*)partialname ofCountry:(NSString*)country{
    NSString* query = [NSString stringWithFormat:@"select * from %@ where name like '%@%%' and country like'%@%%'",self.city_table,partialname,country];
    return [self loadDataFromDB:query];
}

-(NSArray*)getCitybyId:(NSNumber *)city_id{
    NSString *query = [NSString stringWithFormat:@"select * from %@ where id=%@",self.city_table,city_id];
    return [self loadDataFromDB:query][0];
}

-(NSArray*)getAddedCities{
    NSString *query = [NSString stringWithFormat:@"select id from %@",self.favorite_table];
    return [self loadDataFromDB:query];
}

-(NSArray*)getFavoriteCities{
    NSString *query = [NSString stringWithFormat:@"select id from %@ where favorite=1",self.favorite_table];
    return [self loadDataFromDB:query];
}

-(BOOL)getIsFavoriteCity:(NSNumber*)city_id{
    NSString *query = [NSString stringWithFormat:@"select favorite from %@ where id=%@",self.favorite_table,city_id];
    NSArray* result = [self loadDataFromDB:query][0];
    return [result[0] boolValue];
}

-(NSArray*)getHistoryOfCity:(NSNumber*)city_id{
    NSString *query = [NSString stringWithFormat:@"select * from %@ where id=%@ order by currTime desc",self.history_table,city_id];
    return [self loadDataFromDB:query];
}

-(BOOL) addCity:(NSNumber*)city_id{
    NSString *query = [NSString stringWithFormat:@"insert into %@ values(%@,FALSE)",self.favorite_table,city_id];
    [self executeQuery:query];
    if(self.affectedRows != 0){
        return YES;
    }
    return NO;
}

-(BOOL) setFavoriteCity:(NSNumber*)city_id{
    NSString *query = [NSString stringWithFormat:@"update %@ set favorite=TRUE WHERE id=%@",self.favorite_table,city_id];
    [self executeQuery:query];
    if(self.affectedRows != 0){
        return YES;
    }
    return NO;
}

- (BOOL)addHistoryEntryForCity:(NSArray*)city_weather withDescription:(NSString*)description andNamedIcon:(NSString*)icon {
    if(city_weather.count != 5){
        return NO;
    }
    NSDate* date = (NSDate*)(city_weather[1]);
    NSString *query = [NSString stringWithFormat:@"insert into %@ values('%@','%@','%@','%@','%@','%@','%@')",self.history_table, city_weather[0], [NSNumber numberWithDouble:date.timeIntervalSince1970], city_weather[2], city_weather[3], city_weather[4], description, icon];
    [self executeQuery:query];
    if(self.affectedRows != 0){
        return YES;
    }
    return NO;
}

-(BOOL)deleteFavoriteCitybyId:(NSNumber*)city_id{
    NSString *query = [NSString stringWithFormat:@"update %@ set favorite=FALSE WHERE id=%@",self.favorite_table,city_id];
    [self executeQuery:query];
    if(self.affectedRows != 0){
        return YES;
    }
    return NO;
}

-(BOOL)deleteAddedCitybyId:(NSNumber*)city_id{
    NSString *query = [NSString stringWithFormat:@"delete from %@ where id = %@",self.favorite_table,city_id];
    [self executeQuery:query];
    if(self.affectedRows != 0){
        return YES;
    }
    return NO;
}

-(BOOL)deleteHistoryEntryForCity:(NSNumber*)city_id ofTime:(NSDate*)time{
    NSString *query = [NSString stringWithFormat:@"delete from %@ where id = '%@' and currTime='%@'",self.history_table,city_id,[NSNumber numberWithDouble:time.timeIntervalSince1970]];
    [self executeQuery:query];
    if(self.affectedRows != 0){
        return YES;
    }
    return NO;
}

@end
