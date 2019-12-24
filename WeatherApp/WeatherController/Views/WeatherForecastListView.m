//
//  WeatherForecastListView.m
//  WeatherApp
//
//  Created by Luca Faggion on 24/12/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import "WeatherForecastListView.h"
#import "UIView+WeatherViewCategory.h"
#import "WeatherItemView.h"

@interface WeatherForecastListView()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIStackView *forecastList;
@property (strong, nonatomic) NSArray<WeatherItemView*>* itemList;
@end

@implementation WeatherForecastListView

-(void) initView{
    [self initViewFromNib:@"WeatherForecastListView"];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    WeatherItemView* items[8];
    for (int i=0; i<8; i++) {
        items[i] = [[WeatherItemView alloc] init];
        [self.forecastList addArrangedSubview:items[i]];
    }
    self.itemList = [NSArray arrayWithObjects:items count:8];
    [self.forecastList layoutIfNeeded];
    [self.heightAnchor constraintEqualToConstant:self.forecastList.frame.size.height].active = true;
//    [self.widthAnchor constraintEqualToConstant:self.forecastList.frame.size.width].active = true;
//    [self.contentView setFrame:self.forecastList.frame];
//    [self.contentView layoutIfNeeded];
//    NSLog(@"%@", NSStringFromCGRect(self.contentView.frame));
//    [self setFrame:self.forecastList.frame];
//    [self layoutIfNeeded];
//    NSLog(@"%@", NSStringFromCGRect(self.forecastList.frame));
}

-(void) updateView:(nonnull CityWeather*)weather{
    
}

@end
