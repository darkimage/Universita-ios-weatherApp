//
//  WeatherHeaderView.m
//  WeatherApp
//
//  Created by Luca Faggion on 02/12/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "WeatherHeaderView.h"
#import "WeatherAppModel.h"
#import <RZViewActions/UIView+RZViewActions.h>
#import "UIView+WeatherViewCategory.h"

@interface WeatherHeaderView()
@property (strong, nonatomic) IBOutlet UIView *content;
@property (weak, nonatomic) IBOutlet UILabel *Temperature;
@property (weak, nonatomic) IBOutlet UILabel *TemperatureDesc;
@property (weak, nonatomic) IBOutlet UILabel *TemperatureSymbol;
@property (weak, nonatomic) IBOutlet UIImageView *WeatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *CityName;
@end

@implementation WeatherHeaderView

- (void)initView {
    [self initViewFromNib:@"WeatherHeaderView"];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self.heightAnchor constraintEqualToConstant:self.content.bounds.size.height].active = true;
}

-(void) updateView:(CityWeather *)weather{
    
}

@end
