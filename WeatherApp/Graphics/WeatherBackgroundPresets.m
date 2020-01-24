//
//  WeatherBackgroundPresets.m
//  WeatherApp
//
//  Created by Luca Faggion on 03/12/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "WeatherBackgroundPresets.h"
#import "NSValue+AnimBackgroundData.h"
#include <stdlib.h>

@interface WeatherBackgroundPresets ()
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
    return self;
}


-(AnimatedBackground*) setWeatherBackgroundPreset:(NSNumber*)weather_id toView:(nullable UIView*) view{
    animBlock fallingAnim = ^(UIImageView* im1,UIImageView* im2){
        im1.center = CGPointMake(im1.center.x, im1.center.y + im1.frame.size.height);
        im2.center = CGPointMake(im2.center.x, im2.center.y + im2.frame.size.height);
    };
    if([weather_id integerValue] >= 200 && [weather_id integerValue] < 300){
        NSValue* thunder_cloud_bg = [NSValue valueWithImage:@"cloud_blurred_dark" withDuration:30.0f withOffset:-200.0f withSize:CGRectMake(0, 0, 1000, 500) andOpacity: 1.0f];
        NSValue* thunder_cloud_bg1 = [NSValue valueWithImage:@"cloud_blurred_dark" withDuration:50.0f withOffset:-150.0f withSize:CGRectMake(0, 0, 700, 350) andOpacity: 0.5f];
        NSValue* thunder_lighting_bg1 = [NSValue valueWithImage:@"lighting_01" withDuration:2.f withOffset:-50.0f withSize:CGRectMake(0, 0, 700, 350) withOpacity: 0.8f withAnimation:^(UIImageView* im1,UIImageView* im2){
            im1.alpha = 0.0f;
        } withStackWidth:YES withAllowScroll:NO andContentMode:UIViewContentModeScaleAspectFit];
        NSValue* thunder_lighting_bg2 = [NSValue valueWithImage:@"lighting_02" withDuration:3.f withOffset:-150.0f withSize:CGRectMake(0, 0, 700, 350) withOpacity: 0.5f withAnimation:^(UIImageView* im1,UIImageView* im2){
            im1.alpha = 0.0f;
        } withStackWidth:YES withAllowScroll:NO andContentMode:UIViewContentModeScaleAspectFit];
        NSArray<NSValue*>* thunder_animData = [[NSArray<NSValue*> alloc] initWithObjects:thunder_cloud_bg1,thunder_lighting_bg1, thunder_cloud_bg,thunder_lighting_bg2, nil];
        CAGradientLayer* thunder_gradient = [CAGradientLayer layer];
        UIColor* thunder_bottom = [UIColor colorWithRed:73.0/255.0 green:73.0/255.0 blue:73.0/255.0 alpha:1.0];
        UIColor* thunder_top = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
        thunder_gradient.colors = [NSArray arrayWithObjects:(id)thunder_top.CGColor,(id)thunder_bottom.CGColor, nil];
        AnimatedBackground* thunder_Anim = [[AnimatedBackground alloc] initWithStructDataArray:thunder_animData withGradient:thunder_gradient addTo:view];
        thunder_Anim.parallaxMultiplier = [NSNumber numberWithFloat:6.f];
        return thunder_Anim;
    }else if([weather_id integerValue] >= 300 && [weather_id integerValue] < 600){
        //RAIN
        NSValue* rain_bg = [NSValue valueWithImage:@"cloud_blurred_dark" withDuration:30.0f withOffset:-200.0f withSize:CGRectMake(0, 0, 1000, 500) andOpacity: 1.0f];
        NSValue* rain_bg1 = [NSValue valueWithImage:@"cloud_blurred_dark" withDuration:50.0f withOffset:-150.0f withSize:CGRectMake(0, 0, 700, 350) andOpacity: 0.5f];
        NSValue* rain_bg2 = [NSValue valueWithImage:@"cloud_blurred_dark" withDuration:75.0f withOffset:-100.0f withSize:CGRectMake(0, 0, 500, 250) andOpacity: 0.3f];
        NSValue* rain_droplets_static = [NSValue valueWithImage:@"rain_droplets" withDuration:0.0f withOffset:0.0f withSize:[UIScreen mainScreen].bounds withOpacity: 1.0f withAnimation:NULL withStackWidth:YES withAllowScroll:NO andContentMode:UIViewContentModeScaleToFill];
        NSValue* rain_droplets_bg = [NSValue valueWithImage:@"rain" withDuration:4.0f withOffset:0.0f withSize:[UIScreen mainScreen].bounds withOpacity: 1.0f withAnimation:fallingAnim withStackWidth:NO withAllowScroll:NO andContentMode:UIViewContentModeScaleToFill];
        CAGradientLayer* rain_gradient = [CAGradientLayer layer];
        UIColor* rain_bottom = [UIColor colorWithRed:74.0/255.0 green:93.0/255.0 blue:109.0/255.0 alpha:1.0];
        UIColor* rain_top = [UIColor colorWithRed:92.0/255.0 green:118.0/255.0 blue:133.0/255.0 alpha:1.0];
        rain_gradient.colors = [NSArray arrayWithObjects:(id)rain_bottom.CGColor,(id)rain_top.CGColor, nil];
        NSArray<NSValue*>* rain_animData = [[NSArray<NSValue*> alloc] initWithObjects:rain_droplets_static,rain_droplets_bg,rain_bg2,rain_bg1,rain_bg, nil];
        AnimatedBackground* rain_Anim = [[AnimatedBackground alloc] initWithStructDataArray:rain_animData withGradient:rain_gradient addTo:view];
        rain_Anim.parallaxMultiplier = [NSNumber numberWithFloat:2.0];
        return rain_Anim;
    }else if([weather_id integerValue] >= 600 && [weather_id integerValue] < 700){
        CAGradientLayer* snow_gradient = [CAGradientLayer layer];
        NSValue* snow_bg = [NSValue valueWithImage:@"cloud_blurred" withDuration:35.0f withOffset:-200.0f withSize:CGRectMake(0, 0, 1000, 500) andOpacity: 0.3f];
        NSValue* snow_bg1 = [NSValue valueWithImage:@"cloud_blurred" withDuration:50.0f withOffset:-150.0f withSize:CGRectMake(0, 0, 700, 350) andOpacity: 0.5f];
        NSValue* snow_droplets_bg = [NSValue valueWithImage:@"snow" withDuration:30.0f withOffset:0.0f withSize:[UIScreen mainScreen].bounds withOpacity: 1.0f withAnimation:fallingAnim withStackWidth:NO withAllowScroll:NO andContentMode:UIViewContentModeScaleToFill];
        UIColor* snow_bottom = [UIColor colorWithRed:95.0/255.0 green:105.0/255.0 blue:105.0/255.0 alpha:1.0];
        UIColor* snow_top = [UIColor colorWithRed:172.0/255.0 green:183.0/255.0 blue:194.0/255.0 alpha:1.0];
        snow_gradient.colors = [NSArray arrayWithObjects:(id)snow_top.CGColor,(id)snow_bottom.CGColor, nil];
        NSArray<NSValue*>* snow_animData = [[NSArray<NSValue*> alloc] initWithObjects:snow_droplets_bg,snow_bg1,snow_bg, nil];
        AnimatedBackground* snow_Anim = [[AnimatedBackground alloc] initWithStructDataArray:snow_animData withGradient:snow_gradient addTo:view];
        snow_Anim.parallaxMultiplier = [NSNumber numberWithFloat:2.0];
        return snow_Anim;
    }else if([weather_id integerValue] >= 700 && [weather_id integerValue] < 800){
        //MIST
        CAGradientLayer* mist_gradient = [CAGradientLayer layer];
        NSValue* mist_bg = [NSValue valueWithImage:@"cloud_blurred" withDuration:30.0f withOffset:100.0f withSize:CGRectMake(0, 0, 2000, 1000) andOpacity: 0.3f];
        UIColor* mist_bottom = [UIColor colorWithRed:100.0/255.0 green:105.0/255.0 blue:105.0/255.0 alpha:1.0];
        UIColor* mist_top = [UIColor colorWithRed:190.0/255.0 green:194.0/255.0 blue:194.0/255.0 alpha:1.0];
        mist_gradient.colors = [NSArray arrayWithObjects:(id)mist_top.CGColor,(id)mist_bottom.CGColor, nil];
        AnimatedBackground* mist_Anim = [[AnimatedBackground alloc] initWithStructData:mist_bg withGradient:mist_gradient addTo:view];
        mist_Anim.parallaxMultiplier = [NSNumber numberWithFloat:2.0];
        return mist_Anim;
    }else{
        //default CLEARSKY
        NSValue* clearsky_bg = [NSValue valueWithImage:@"cloud_blurred" withDuration:30.0f withOffset:-200.0f withSize:CGRectMake(0, 0, 1000, 500) andOpacity: 1.0f];
        NSValue* clearsky_bg1 = [NSValue valueWithImage:@"cloud_blurred" withDuration:50.0f withOffset:-150.0f withSize:CGRectMake(0, 0, 700, 350) andOpacity: 0.5f];
        NSValue* clearsky_bg2 = [NSValue valueWithImage:@"cloud_blurred" withDuration:75.0f withOffset:-100.0f withSize:CGRectMake(0, 0, 500, 250) andOpacity: 0.3f];
        CAGradientLayer* clearsky_gradient = [CAGradientLayer layer];
        UIColor* clearsky_bottom = [UIColor colorWithRed:130.0/255.0 green:165.0/255.0 blue:188.0/255.0 alpha:1.0];
        UIColor* clearsky_top = [UIColor colorWithRed:37.0/255.0 green:98.0/255.0 blue:129.0/255.0 alpha:1.0];
        clearsky_gradient.colors = [NSArray arrayWithObjects:(id)clearsky_bottom.CGColor,(id)clearsky_top.CGColor, nil];
        NSArray<NSValue*>* clearsky_animData = [[NSArray<NSValue*> alloc] initWithObjects:clearsky_bg2,clearsky_bg1,clearsky_bg, nil];
        AnimatedBackground* clearsky_Anim = [[AnimatedBackground alloc] initWithStructDataArray:clearsky_animData withGradient:clearsky_gradient addTo:view];
        clearsky_Anim.parallaxMultiplier = [NSNumber numberWithFloat:2.0];
        return clearsky_Anim;
    }
    return NULL;
}

@end
