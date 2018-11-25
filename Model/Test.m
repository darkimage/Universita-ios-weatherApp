//
//  Test.m
//  WeatherApp
//
//  Created by Luca Faggion on 24/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "Test.h"
#import "currentWeather.h"
#import "forecastWeather.h"

@implementation Test

-(void) updateAfterGetCity:(NSData*)data{
    if(data != nil){
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        currentWeather* dw = [[currentWeather alloc]initWithDictionary:json];
    }else{
        NSLog(@"Data is nil");
    }
}

-(void) updateAfterGetCityforecast:(NSData*)data{
    if(data != nil){
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        forecastWeather* dw = [[forecastWeather alloc]initWithDictionary:json];
    }else{
        NSLog(@"Data is nil");
    }
}

@end
