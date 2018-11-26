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

//"VIRTUAL" METHODS

-(NSArray*)getCitiesbyPartialName:(NSString *)partialname;
-(NSArray*)getCitybyId:(NSNumber*)city_id;
-(NSArray*)getFavoriteCities;
-(void)addFavoriteCity:(NSNumber*)city_id;

@end

NS_ASSUME_NONNULL_END
