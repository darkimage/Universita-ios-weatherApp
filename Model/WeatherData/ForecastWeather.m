//
//  forecastWeather.m
//  WeatherApp
//
//  Created by Luca Faggion on 24/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "ForecastWeather.h"

@implementation ForecastWeather

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        _forecastWeather = [[NSMutableArray alloc]init];
        for (int i = 0; i < [dict[@"list"] count]; i++) {
            [_forecastWeather addObject:[[CurrentWeather alloc]initWithDictionary:dict[@"list"][i]]];
        }
    }
    return self;
}

@end
