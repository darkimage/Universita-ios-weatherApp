//
//  WeatherAverageView.m
//  WeatherApp
//
//  Created by Luca Faggion on 06/09/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import "WeatherItemView.h"
#import "UIView+WeatherViewCategory.h"

@interface WeatherItemView()
@property (strong, nonatomic) IBOutlet UILabel *TemperatureLabel;
@property (strong, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (strong, nonatomic) IBOutlet UILabel *TimeLabel;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIStackView *stackView;
@property NSInteger index;
@property Boolean fromCurrent;
@end

@implementation WeatherItemView

-(id)init{
    self = [super init];
    if(self){
        self.index = 0;
        self.fromCurrent = false;
    }
    return self;
}

-(void)initView{
    [self initViewFromNib:@"WeatherItemView"];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint* height = [self.heightAnchor constraintEqualToConstant:self.contentView.bounds.size.height];
    height.active = YES;
    height.priority = UILayoutPriorityDefaultHigh;
}

-(void) updateView:(CityWeather *)weather{
    if(self.fromCurrent){
        self.TimeLabel.text = @"Today";
        self.weatherIcon.hidden = YES;
        self.TemperatureLabel.text = [NSString stringWithFormat:@"%@%@%@%@",
                                      [NSString stringWithFormat:@"%.01f", [weather.current.mainMin_Temp floatValue]] ,
                                      @"° | " ,
                                      [NSString stringWithFormat:@"%.01f", [weather.current.mainMax_Temp floatValue]],
                                      @"°"];

    }else{
        CurrentWeather* currWeather = weather.forecast.forecastWeather[self.index];
        //UPDATE DATE
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"E dd MMM"];
        NSDate* date = currWeather.date;
        self.TimeLabel.text = [formatter stringFromDate:date];
        //UPDATE MIN MAX TEMPERATURE
        self.TemperatureLabel.text = [NSString stringWithFormat:@"%@%@%@%@",
                                      [NSString stringWithFormat:@"%.01f", [currWeather.mainMin_Temp floatValue]] ,
                                      @"° | " ,
                                      [NSString stringWithFormat:@"%.01f", [currWeather.mainMax_Temp floatValue]],
                                      @"°"];
        //UPDATE ICON
        self.weatherIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_%@", currWeather.weatherIcon]];
    }
}

-(void)setTimeIndex:(NSInteger)index{
    self.index = index;
}

-(void)getFromCurrent:(Boolean)value{
    self.fromCurrent = value;
}

@end
