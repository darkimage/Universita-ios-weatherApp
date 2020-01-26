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
-(NSArray*)getAddedCities;
-(NSArray*)getFavoriteCities;
-(BOOL)getIsFavoriteCity:(NSNumber*)city_id;
-(NSArray*)getHistoryOfCity:(NSNumber*)city_id;

//ADD METHODS
-(BOOL)addCity:(NSNumber*)city_id;
-(BOOL)addHistoryEntryForCity:(NSArray*)city_weather withDescription:(NSString*)description andNamedIcon:(NSString*)icon;

//DELETE METHODS
-(BOOL)deleteFavoriteCitybyId:(NSNumber*)city_id;
-(BOOL)deleteAddedCitybyId:(NSNumber*)city_id;
-(BOOL)deleteHistoryEntryForCity:(NSNumber*)city_id ofTime:(NSDate*)time;

//UPDATE METHODS
-(BOOL)setFavoriteCity:(NSNumber*)city_id;
@end



NS_ASSUME_NONNULL_END
