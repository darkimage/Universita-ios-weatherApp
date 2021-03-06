//
//  City.m
//  WeatherApp
//
//  Created by Luca Faggion on 24/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "CityWeather.h"
#import "WeatherAppModel.h"

@interface CityWeather()
@property BOOL currentUpdated;
@property BOOL forecastUpdated;

-(void) internalInitWithCityID:(NSNumber*)city_id withUpdate:(Boolean)update;
-(void) onCurrentData:(NSData*)data;
-(void) onForecastData:(NSData*)data;
-(void) afterUpdate;
@end

@implementation CityWeather

-(instancetype)initWithCityID:(NSNumber*)city_id{
    self = [super init];
    if (self) {
        [self internalInitWithCityID:city_id withUpdate:true];
    }
    return self;
}

-(instancetype)initWithCityID:(NSNumber*)city_id update:(Boolean)update{
    self = [super init];
    if (self) {
        [self internalInitWithCityID:city_id withUpdate:update];
    }
    return self;
}

-(void) internalInitWithCityID:(NSNumber*)city_id withUpdate:(Boolean)update{
    _currentUpdated = NO;
    _forecastUpdated = NO;
    NSArray* arrCity = [[[WeatherAppModel sharedModel] getDatabase] getCitybyId:city_id];
    if([arrCity count] > 0){
        _ID = arrCity[0];
        _name = arrCity[1];
        _country = arrCity[2];
        _lon = arrCity[3];
        _lat = arrCity[4];
        if(update){
            [self performUpdate];
        }
    }else{
        [self.delegate onUpdateWeatherDataError:@"The selected city doesn't exist in the database"];
        NSLog(@"The city doesn't exist");
    }
}

- (void)performUpdate {
    WeatherData* weatherData = [[WeatherAppModel sharedModel] getWeatherData];
    [weatherData getCityCurrentWeatherbyId:self.ID withSelector:@selector(onCurrentData:) ofObject:self];
    [weatherData getCityForecastWeatherbyId:self.ID withSelector:@selector(onForecastData:) ofObject:self];
}

- (void)onCurrentData:(NSData *)data {
    if(data != nil){
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        self.current = [[CurrentWeather alloc]initWithDictionary:json];
        self.currentUpdated = YES;
        [self afterUpdate];
    }else{
        self.currentUpdated = NO;
        [self.delegate onUpdateWeatherDataError:@"Cannot update current weather"];
        NSLog(@"Current Data is nil");
    }
}

- (void)onForecastData:(NSData *)data {
    if(data != nil){
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        self.forecast = [[ForecastWeather alloc]initWithDictionary:json];
        self.forecastUpdated = YES;
        [self afterUpdate];
    }else{
        self.forecastUpdated = NO;
        [self.delegate onUpdateWeatherDataError:@"Cannot update forecast weather"];
        NSLog(@"ForecastData is nil");
    }
}

- (void)afterUpdate {
    if(self.currentUpdated && self.forecastUpdated){
        self.last_updated = [NSDate date];
        [self.delegate onUpdatedWeatherData:self];
        self.currentUpdated = NO;
        self.forecastUpdated = NO;
        self.hasData = YES;
    }
}

@end
