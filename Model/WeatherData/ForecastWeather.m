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
        self.forecastWeather = [[NSMutableArray alloc]init];
        for (int i = 0; i < [dict[@"list"] count]; i++) {
            [self.forecastWeather addObject:[[CurrentWeather alloc]initWithDictionary:dict[@"list"][i]]];
        }
    }
    return self;
}

@end
