//
//  WeatherForecastSlotView.m
//  WeatherApp
//
//  Created by Luca Faggion on 15/09/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import "WeatherForecastSlotView.h"
#import "UIView+WeatherViewCategory.h"

@interface WeatherForecastSlotView()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *TimeFromNowLabel;
@property (strong, nonatomic) IBOutlet UILabel *TemperatureLabel;
@property (strong, nonatomic) IBOutlet UILabel *PrecipitationLabel;
@property (strong, nonatomic) IBOutlet UIImageView *WeatherIcon;
@end

@implementation WeatherForecastSlotView

-(void)initView{
    [self initViewFromNib:@"WeatherForecastSlotView"];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self.heightAnchor constraintEqualToConstant:self.contentView.bounds.size.height].active = true;
    [self.widthAnchor constraintEqualToConstant:self.contentView.bounds.size.width].active = true;
}

-(void) updateView:(CityWeather *)weather{
    
}

@end
