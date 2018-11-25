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
@property (nonatomic,strong) NSString *api_url;
-(NSData*) dataFromAPI:(NSString*)formatString,...;
-(void) callCallback:(SEL)selector ofObject:(id)object withData:(NSData *)data;
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
        self.api_url = @"http://api.openweathermap.org/data/2.5/";
    }
    return self;
}

-(NSData*) dataFromAPI:(NSString *)formatString, ...{
    va_list args;
    va_start(args, formatString);
    NSMutableString* url_string = [[NSMutableString alloc] initWithString:self.api_url];
    NSString* url_str = [[NSString alloc] initWithFormat:formatString arguments:args];
    NSString* api_str = [NSString stringWithFormat:@"&APPID=%@",self.api_key];
    [url_string appendString:url_str];
    [url_string appendString:api_str];
    va_end(args);
    NSData* data =[NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    return data;
}

-(void) callCallback:(SEL)selector ofObject:(id)object withData:(NSData *)data{
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[object methodSignatureForSelector:selector]];
    [inv setSelector:selector];
    [inv setTarget:object];
    [inv setArgument:&data atIndex:2]; //arguments 0 and 1 are self and _cmd respectively, automatically set by NSInvocation
    [inv invoke];
}

-(void) getCityCurrentWeatherbyId:(NSNumber*)city_id withSelector:(SEL)selector ofObject:(id)object;{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * data = [self dataFromAPI:@"weather?id=%@",city_id];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self callCallback:selector ofObject:object withData:data];
        });
    });
}

-(void) getCityForecastWeatherbyId:(NSNumber*)city_id withSelector:(SEL)selector ofObject:(id)object;{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * data = [self dataFromAPI:@"forecast?id=%@",city_id];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self callCallback:selector ofObject:object withData:data];
        });
    });
}


@end
