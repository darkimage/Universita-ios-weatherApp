//
//  DBManager.m
//  WeatherApp
//
//  Created by Luca Faggion on 22/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

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

-(NSArray*)getFavoriteCities{
    NSAssert(NO, @"Subclasses need to overwrite this method");
    return [[NSArray alloc]init];
}

-(void) addFavoriteCity:(NSNumber*)city_id{
    NSAssert(NO, @"Subclasses need to overwrite this method");
}

-(Boolean)deleteFavoriteCitybyId:(NSInteger)city_id{
    NSAssert(NO, @"Subclasses need to overwrite this method");
    return NO;
}

@end
