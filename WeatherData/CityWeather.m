//
//  City.m
//  WeatherApp
//
//  Created by Luca Faggion on 24/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "CityWeather.h"

@implementation CityWeather

-(instancetype)initWithDatabase:(DBManager *)Db fromId:(NSNumber*)city_id{
    self = [super init];
    if (self) {
        NSArray* arrCity = [Db getCitybyId:city_id];
        if([arrCity count] > 0){
            self.ID = city_id;
            self.name = arrCity[0];
            self.country = arrCity[1];
            self.lon = arrCity[2];
            self.lat = arrCity[3];
            self.forecast = [[forecastWeather alloc] init];
            self.current = [[currentWeather alloc]init];
        }else{
            return nil;
        }
    }
    return self;
}

@end
