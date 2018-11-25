//
//  SQLManager.h
//  WeatherApp
//
//  Created by Luca Faggion on 22/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//
//  Descrizione:
//   questa classe ha il compito di gestire la implementazione e la comunicazione
//   con il database sql

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "DBManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQLManager : DBManager

//PROPRIETIES
@property (nonatomic, strong) NSMutableArray *arrColumnNames;
@property (nonatomic) int affectedRows;
@property (nonatomic) long long lastInsertedRowID;

//METHODS
-(instancetype) initWithDatabaseName:(NSString*) name; //initializza il database specificando un nome

@end

NS_ASSUME_NONNULL_END
