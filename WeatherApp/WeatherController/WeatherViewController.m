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
#import "WeatherAppModel.h"

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
    
    //INIT THE MAIN VIEW
    self.controllers = [[NSMutableArray alloc] init];
    [self.controllers addObject:[[WeatherHeaderView alloc] initWithSegueIdentifier:@"goToHistory" ofController:self]];
    [self.controllers addObject:[[WeatherItemView alloc] initWithGetFromCurrent:true]];
    [self.controllers addObject:[[WeatherForecastSlideView alloc] init]];
    [self.controllers addObject:[[WeatherForecastListView alloc] init]];
    for (WeatherView* controller in self.controllers) {
        [self.stackView addArrangedSubview:controller];
    }
    [self.stackView layoutIfNeeded];
    
    self.scrollView.delegate = self;
    
    //ADD PULL TO REFRESH
    self.scrollView.refreshControl = [[UIRefreshControl alloc] init];
    [self.scrollView.refreshControl addTarget:self action:@selector(performUpdate) forControlEvents:UIControlEventValueChanged];
    if(self.cityWeather.hasData){
        [self onUpdatedWeatherData:[[NSObject alloc] init]];
    }
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
        [self.scrollView.refreshControl endRefreshing];
    });
}

- (void) onUpdateWeatherDataError:(NSString*)message{
    
}

-(void) performUpdate{
    [self.cityWeather performUpdate];
}

@end
