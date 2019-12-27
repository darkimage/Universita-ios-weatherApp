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
-(NSURLRequest*) setUpRequestAPI:(NSString *)formatString, ...;
-(void) callCallback:(SEL)selector ofObject:(id)object withData:(NSData *)data;
@end

@implementation WeatherData

-(id) init{
    if(self =[super init]){
        self.api_key = @"fb6025022345275ec6dc7e5905b5afc9";
        self.api_url = @"http://api.openweathermap.org/data/2.5/";
    }
    return self;
}

-(NSURLRequest*) setUpRequestAPI:(NSString *)formatString, ...{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];

    va_list args;
    va_start(args, formatString);
    NSMutableString* url = [[NSMutableString alloc] initWithString:self.api_url];
    NSString* url_str = [[NSString alloc] initWithFormat:formatString arguments:args];
    NSString* api_str = [NSString stringWithFormat:@"&APPID=%@",self.api_key];
    [url appendString:url_str];
    [url appendString:@"&units=metric"];
    [url appendString:api_str];
    va_end(args);
    
    [request setURL:[NSURL URLWithString:url]];
    
    return (NSURLRequest*)request;
}

-(void) callCallback:(SEL)selector ofObject:(id)object withData:(NSData *)data{
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[object methodSignatureForSelector:selector]];
    [inv setSelector:selector];
    [inv setTarget:object];
    [inv setArgument:&data atIndex:2]; //gli argomenti 0 e 1 sono rispettivamente self e _cmd, settati automaticamente da NSInvocation
    [inv invoke];
}

-(void) getCityCurrentWeatherbyId:(NSNumber*)city_id withSelector:(SEL)selector ofObject:(id)object;{
    [[[NSURLSession sharedSession] dataTaskWithRequest:[self setUpRequestAPI:@"weather?id=%@",city_id]
            completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                [self callCallback:selector ofObject:object withData:data];
            }] resume];
}

-(void) getCityForecastWeatherbyId:(NSNumber*)city_id withSelector:(SEL)selector ofObject:(id)object;{
    [[[NSURLSession sharedSession] dataTaskWithRequest:[self setUpRequestAPI:@"forecast?id=%@",city_id]
             completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                 [self callCallback:selector ofObject:object withData:data];
             }] resume];
}

@end
