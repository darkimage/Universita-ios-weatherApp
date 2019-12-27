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

-(void) updateView:(CityWeather *)cityWeather{
    self.Temperature.text = [NSString stringWithFormat:@"%.00f",[cityWeather.current.mainTemp floatValue]];
    self.TemperatureDesc.text = cityWeather.current.weatherDescription;
    self.CityName.text = cityWeather.name;
    self.WeatherIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_%@", cityWeather.current.weatherIcon]];
}

@end
