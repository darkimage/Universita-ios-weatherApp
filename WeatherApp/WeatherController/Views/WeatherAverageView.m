//
//  WeatherAverageView.m
//  WeatherApp
//
//  Created by Luca Faggion on 06/09/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import "WeatherAverageView.h"
#import "UIView+WeatherViewCategory.h"

@interface WeatherAverageView()
@property (strong, nonatomic) IBOutlet UILabel *TemperatureLabel;
@property (strong, nonatomic) IBOutlet UILabel *TimeLabel;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@end

@implementation WeatherAverageView

-(void)initView{
    [self initViewFromNib:@"WeatherAverageView"];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self.heightAnchor constraintEqualToConstant:self.contentView.bounds.size.height].active = true;
}
-(void) updateView:(CityWeather *)weather{
    
}

@end
