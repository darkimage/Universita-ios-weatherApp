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

//"VIRTUAL" METHODS (CRUD INTERFACE)
//GET METHODS
-(NSArray*)getCitiesbyPartialName:(NSString*)partialname;
-(NSArray*)getCitiesbyPartialName:(NSString*)partialname ofCountry:(NSString*)country;
-(NSArray*)getCitybyId:(NSNumber*)city_id;
-(NSArray*)getFavoriteCities;

//ADD METHODS
-(void)addFavoriteCity:(NSNumber*)city_id;

//DELETE METHODS
-(Boolean)deleteFavoriteCitybyId:(NSInteger)city_id;
@end

NS_ASSUME_NONNULL_END
