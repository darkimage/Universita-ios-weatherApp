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
@property NSInteger count;
@end

@implementation WeatherForecastListView

-(void) initView{
    [self initViewFromNib:@"WeatherForecastListView"];
    self.count = 5;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    WeatherItemView* items[self.count];
    for (int i=0; i<self.count; i++) {
        items[i] = [[WeatherItemView alloc] init];
        [self.forecastList addArrangedSubview:items[i]];
    }
    self.itemList = [NSArray arrayWithObjects:items count:self.count];
    [self.forecastList layoutIfNeeded];
    [self.heightAnchor constraintEqualToConstant:self.forecastList.frame.size.height].active = true;
}

- (NSDate *)addDays:(NSInteger)days toDate:(NSDate *)originalDate {
    NSDateComponents *components= [[NSDateComponents alloc] init];
    [components setDay:days];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar dateByAddingComponents:components toDate:originalDate options:0];
}

-(void) updateView:(nonnull CityWeather*)weather{
    NSDate* date = [NSDate date];
    for (int i = 0; i < self.count; i++) {
        NSDateComponents *currDate = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[self addDays:i toDate:date]];
        for (int j =0; j < weather.forecast.forecastWeather.count; j++) {
            CurrentWeather* currWeather = weather.forecast.forecastWeather[j];
            NSDateComponents *weatherDate = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:currWeather.date];
            if([currDate day] == [weatherDate day]){
                [self.itemList[i] setTimeIndex:j];
            }
        }
        [self.itemList[i] updateView:weather];
    }
}

@end
