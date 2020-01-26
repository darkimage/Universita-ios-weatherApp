//
//  WeatherView.m
//  WeatherApp
//
//  Created by Luca Faggion on 23/12/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import "WeatherView.h"

@implementation WeatherView

-(instancetype) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initView];
    }
    return self;
}

-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}


-(void) updateView:(nonnull CityWeather*)weather{}

-(void) initView{}

@end
