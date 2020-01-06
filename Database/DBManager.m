//
//  DBManager.m
//  WeatherApp
//
//  Created by Luca Faggion on 22/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

#pragma mark - GET
-(NSArray*) getCitiesbyPartialName:(NSString *)partialname{
     NSAssert(NO, @"Subclasses need to overwrite this method");
    return [[NSArray alloc]init];
}

-(NSArray*)getCitiesbyPartialName:(NSString*)partialname ofCountry:(NSString*)country{
    NSAssert(NO, @"Subclasses need to overwrite this method");
    return [[NSArray alloc]init];
}

-(NSArray*)getCitybyId:(NSNumber*)city_id{
     NSAssert(NO, @"Subclasses need to overwrite this method");
    return [[NSArray alloc]init];
}

-(NSArray*)getAddedCities{
    NSAssert(NO, @"Subclasses need to overwrite this method");
    return [[NSArray alloc]init];
}

-(NSArray*)getFavoriteCities{
    NSAssert(NO, @"Subclasses need to overwrite this method");
    return [[NSArray alloc]init];
}

-(BOOL)getIsFavoriteCity:(NSNumber*)city_id{
    NSAssert(NO, @"Subclasses need to overwrite this method");
    return NO;
}

- (nonnull NSArray *)getHistoryOfCity:(nonnull NSNumber *)city_id {
    NSAssert(NO, @"Subclasses need to overwrite this method");
    return [[NSArray alloc]init];
}

#pragma mark - ADD UPDATE

-(BOOL) addFavoriteCity:(NSNumber*)city_id{
    NSAssert(NO, @"Subclasses need to overwrite this method");
    return NO;
}

-(BOOL)addHistoryEntryForCity:(NSArray*)city_weather withDescription:(NSString*)description andNamedIcon:(NSString*)icon {
    NSAssert(NO, @"Subclasses need to overwrite this method");
    return NO;
}


#pragma mark - DELETE
-(BOOL)deleteFavoriteCitybyId:(NSNumber*)city_id{
    NSAssert(NO, @"Subclasses need to overwrite this method");
    return NO;
}

-(BOOL)deleteAddedCitybyId:(NSNumber*)city_id{
    NSAssert(NO, @"Subclasses need to overwrite this method");
    return NO;
}

-(BOOL)deleteHistoryEntryForCity:(NSNumber*)city_id{
    NSAssert(NO, @"Subclasses need to overwrite this method");
    return NO;
}

@end
