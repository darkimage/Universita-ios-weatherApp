//
//  WeatherData.m
//  WeatherApp
//
//  Created by Luca Faggion on 23/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "WeatherData.h"

@interface WeatherData()
@property (nonatomic,strong) NSString* api_key; //private api key for openweathermap.org
@property (nonatomic,strong) SQLManager* sqlMng;
@end

@implementation WeatherData

//Singleton Pattern
+(id) sharedData{
    static WeatherData* sharedweatherData;
    @synchronized (self) {
        if(sharedweatherData == nil){
            sharedweatherData = [[self alloc]init];
        }
        return sharedweatherData;
    }
}

-(id) init{
    if(self =[super init]){
        self.api_key = @"fb6025022345275ec6dc7e5905b5afc9";
        self.sqlMng = [[SQLManager alloc]init];
        self.city_table = @"city_data";
    }
    return self;
}

-(NSArray*)getCitybyPartialName:(NSString *)partialname{
    NSString* query = [NSString stringWithFormat:@"select * from %@ where name like '%@%%'",self.city_table,partialname];
    return [self.sqlMng loadDataFromDB:query];
}

@end
