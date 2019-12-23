//
//  WeatherView+WeatherViewCategory.m
//  WeatherApp
//
//  Created by Luca Faggion on 23/12/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import "UIView+WeatherViewCategory.h"

@implementation UIView (WeatherViewCategory)

-(void) initViewFromNib: (NSString*) name{
    NSArray* views = [[NSBundle mainBundle] loadNibNamed:name owner:self options:nil];
    [self addSubview:[views firstObject]];
}

@end
