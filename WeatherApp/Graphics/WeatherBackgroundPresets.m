//
//  WeatherBackgroundPresets.m
//  WeatherApp
//
//  Created by Luca Faggion on 03/12/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "WeatherBackgroundPresets.h"

@implementation WeatherBackgroundPresets

//Singleton Pattern
+(instancetype) sharedPresets{
    static WeatherBackgroundPresets* sharedPrs = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPrs = [[self alloc]init];
    });
    return sharedPrs;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //PRESETS
        //CLEARSKY
//        struct animBackgroundData bg = AnimBackgroundDataMake(@"cloud_blurred", 20.0f, -200.0f, CGRectMake(0, 0, 1000, 500), 1.0f);
//        struct animBackgroundData bg1 = AnimBackgroundDataMake(@"cloud_blurred", 50.0f, -150.0f,  CGRectMake(0, 0, 700, 350), 0.5f);
//        struct animBackgroundData bg2 = AnimBackgroundDataMake(@"cloud_blurred", 100.0f, -100.0f, CGRectMake(0, 0, 500, 250), 0.3f);
        
        //id objects =  {};
        //id keys = {@"clear_sky"};
        //NSDictionary* presets = [NSDictionary dictionaryWithObjects:objects forKeys:keys count:1];
    }
    return self;
}


-(AnimatedBackground*) setWeatherBackgroundPreset:(NSString*)name toView:(UIView*) view{
    return [AnimatedBackground alloc];
}


@end
