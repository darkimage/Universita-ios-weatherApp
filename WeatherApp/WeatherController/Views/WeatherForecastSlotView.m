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
@property NSInteger index;
@end

@implementation WeatherForecastSlotView

-(instancetype)init{
    self = [super init];
    if(self){
        _index = 0;
    }
    return self;
}

-(instancetype)initWithTimeIndex:(NSInteger)index{
    self = [self init];
    if(self){
        _index = index;
    }
    return self;
}

-(void)initView{
    [self initViewFromNib:@"WeatherForecastSlotView"];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self.heightAnchor constraintEqualToConstant:self.contentView.bounds.size.height].active = true;
    [self.widthAnchor constraintEqualToConstant:self.contentView.bounds.size.width].active = true;
}

-(void)setTimeIndex:(NSInteger)index{
    self.index = index;
}

-(void) updateView:(CityWeather *)weather{
    CurrentWeather* currWeather = weather.forecast.forecastWeather[self.index];
    if(self.index == 0){
        self.TimeFromNowLabel.text = @"Now";
    }else{
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        NSDate* date = currWeather.date;
        self.TimeFromNowLabel.text = [formatter stringFromDate:date];
    }
    self.PrecipitationLabel.text = [NSString stringWithFormat:@"%.00f%%",[currWeather.mainHumidity floatValue]];
    self.TemperatureLabel.text = [NSString stringWithFormat:@"%.00f°",[currWeather.mainTemp floatValue]];
    self.WeatherIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_%@", currWeather.weatherIcon]];
}

@end
