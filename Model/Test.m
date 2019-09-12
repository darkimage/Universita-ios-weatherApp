//
//  Test.m
//  WeatherApp
//
//  Created by Luca Faggion on 24/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "Test.h"
#import "CurrentWeather.h"
#import "ForecastWeather.h"

@implementation Test

-(void) updateAfterGetCity:(NSData*)data{
    if(data != nil){
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        CurrentWeather* dw = [[CurrentWeather alloc]initWithDictionary:json];
    }else{
        NSLog(@"Data is nil");
    }
}

-(void) updateAfterGetCityforecast:(NSData*)data{
    if(data != nil){
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        ForecastWeather* dw = [[ForecastWeather alloc]initWithDictionary:json];
    }else{
        NSLog(@"Data is nil");
    }
}

@end
