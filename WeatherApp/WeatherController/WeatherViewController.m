//
//  WeatherViewController.m
//  WeatherApp
//
//  Created by Luca Faggion on 22/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "WeatherViewController.h"
#import <RZViewActions/UIView+RZViewActions.h>
#import "AnimatedBackground.h"
#import "WeatherBackgroundPresets.h"
#import "WeatherHeaderView.h"
#import "WeatherItemView.h"
#import "WeatherForecastSlideView.h"
#import "WeatherForecastListView.h"
#import "NSValue+AnimBackgroundData.h"

@interface WeatherViewController()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIStackView* stackView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) NSMutableArray<WeatherView*>* controllers;
@property (strong, nonatomic) CityWeather* cityWeather;
@end

@implementation WeatherViewController

-(void) setCity:(NSInteger)cityID{
    self.cityWeather = [[CityWeather alloc] initWithCityID:[NSNumber numberWithInteger:cityID]];
    self.cityWeather.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.controllers = [[NSMutableArray alloc] init];
    [self.controllers addObject:[[WeatherHeaderView alloc] init]];
    WeatherItemView* todayAverage = [[WeatherItemView alloc] init];
    [todayAverage getFromCurrent:true];
    [self.controllers addObject:todayAverage];
    [self.controllers addObject:[[WeatherForecastSlideView alloc] init]];
    [self.controllers addObject:[[WeatherForecastListView alloc] init]];
    for (WeatherView* controller in self.controllers) {
        [self.stackView addArrangedSubview:controller];
    }
    [self.stackView layoutIfNeeded];
    
    self.scrollView.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated{
    [self.delegate viewDidAppear:animated];
    [self.scrollView setContentSize:self.stackView.frame.size];
}

- (void) scrollViewDidScroll:(UIScrollView *) scrollView{
    [self.delegate scrollViewDidScroll:scrollView];
}

- (void) onUpdatedWeatherData:(NSObject*)currentData{
    dispatch_async(dispatch_get_main_queue(), ^{
        for (WeatherView* controller in self.controllers) {
            [controller updateView:self.cityWeather];
        }
    });
}

- (void) onUpdateWeatherDataError:(NSString*)message{
    
}

@end
