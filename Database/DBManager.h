//
//  DBManager.h
//  WeatherApp
//
//  Created by Luca Faggion on 22/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//
//  Descrizione:
//  questa classe "virtuale" serve per descrivere una interfaccia per differenti Database access types

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBManager : NSObject

//PROPRIETIES
@property (nonatomic, strong) NSMutableArray *arrColumnNames;
@property (nonatomic) int affectedRows;
@property (nonatomic) long long lastInsertedRowID;

//"VIRTUAL" METHODS
-(NSArray *)loadDataFromDB:(NSString *)query; //esegue una query di tipo not executable e ritorna i risultati
-(void)executeQuery:(NSString *)query; //esegue una query di tipo executable non ce ritorno di risultati perche sono accedibi tramite le proprieties (affectedRows,lastInsertedRowID)

@end

NS_ASSUME_NONNULL_END
