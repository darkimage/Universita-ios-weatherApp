//
//  WeatherBackgroundPresets.m
//  WeatherApp
//
//  Created by Luca Faggion on 03/12/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "WeatherBackgroundPresets.h"

@interface WeatherBackgroundPresets ()
@property (nonatomic,strong) NSMutableDictionary* presets;
@end

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
        self.presets = [[NSMutableDictionary alloc] init];
        
        //CLEARSKY
        NSValue* clearsky_bg = [NSValue valueWithImage:@"cloud_blurred" withDuration:20.0f withOffset:-200.0f withSize:CGRectMake(0, 0, 1000, 500) andOpacity: 1.0f];
        NSValue* clearsky_bg1 = [NSValue valueWithImage:@"cloud_blurred" withDuration:50.0f withOffset:-150.0f withSize:CGRectMake(0, 0, 700, 350) andOpacity: 0.5f];
        NSValue* clearsky_bg2 = [NSValue valueWithImage:@"cloud_blurred" withDuration: 100.0f withOffset:-100.0f withSize:CGRectMake(0, 0, 500, 250) andOpacity: 0.3f];
        CAGradientLayer* clearsky_gradient = [CAGradientLayer layer];
        UIColor* clearsky_bottom = [UIColor colorWithRed:130.0/255.0 green:165.0/255.0 blue:188.0/255.0 alpha:1.0];
        UIColor* clearsky_top = [UIColor colorWithRed:37.0/255.0 green:98.0/255.0 blue:129.0/255.0 alpha:1.0];
        clearsky_gradient.colors = [NSArray arrayWithObjects:(id)clearsky_bottom.CGColor,(id)clearsky_top.CGColor, nil];
        NSArray<NSValue*>* clearsky_animData = [[NSArray<NSValue*> alloc] initWithObjects:clearsky_bg2,clearsky_bg1,clearsky_bg, nil];
        AnimatedBackground* clearsky_Anim = [[AnimatedBackground alloc] initWithStructDataArray:clearsky_animData withGradient:clearsky_gradient addTo:NULL];
        clearsky_Anim.parallaxMultiplier = [NSNumber numberWithFloat:2.0];
        [self.presets setValue:clearsky_Anim forKey:@"clear_sky"];
        
        //id objects =  {};
        //id keys = {@"clear_sky"};
        //NSDictionary* presets = [NSDictionary dictionaryWithObjects:objects forKeys:keys count:1];
    }
    return self;
}


-(void) setWeatherBackgroundPreset:(NSString*)name toView:(UIView*) view{
    AnimatedBackground* preset = self.presets[name];
    [preset applyToView:view];
}


-(AnimatedBackground*) getWeatherBackgroundPreset:(NSString*)name{
    return self.presets[name];
}

@end
