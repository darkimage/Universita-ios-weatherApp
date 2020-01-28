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
#import "WeatherHistoryController.h"

@interface WeatherViewController()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIStackView* stackView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) NSMutableArray<WeatherView*>* controllers;
@property (strong, nonatomic) CityWeather* cityWeather;
@property BOOL updateIsFromUser;

-(void) performUpdateFromUser;
-(void) notifyOnStartUpdate;
@end

@implementation WeatherViewController

#pragma mark - Controller Life Cycles
- (void)viewDidLoad {
    [super viewDidLoad];
    self.updateIsFromUser = false;
    //INIT THE MAIN VIEW
    self.controllers = [[NSMutableArray alloc] init];
    [self.controllers addObject:[[WeatherHeaderView alloc] initWithSegueIdentifier:@"goToHistory" ofController:self]];
    [self.controllers addObject:[[WeatherItemView alloc] initWithGetFromCurrent:true]];
    [self.controllers addObject:[[WeatherForecastSlideView alloc] init]];
    [self.controllers addObject:[[WeatherForecastListView alloc] init]];
    for (WeatherView* controller in self.controllers) {
        [self.stackView addArrangedSubview:controller];
    }
    [self notifyOnStartUpdate];
    [self.stackView layoutIfNeeded];
    
    self.scrollView.delegate = self;
    
    //ADD PULL TO REFRESH
    self.scrollView.refreshControl = [[UIRefreshControl alloc] init];
    [self.scrollView.refreshControl addTarget:self action:@selector(performUpdateFromUser) forControlEvents:UIControlEventValueChanged];
    if(self.cityWeather.hasData){
        [self onUpdatedWeatherData:[[NSObject alloc] init]];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [self.scrollView setContentSize:self.stackView.frame.size];
    if(self.cityWeather.hasData){
        [[[WeatherAppModel sharedModel] getCurrentAnimatedBackground] transitionTo:[[[WeatherAppModel sharedModel] getWeatherBackgroundPreset] setWeatherBackgroundPreset:self.cityWeather.current.weatherId toView:NULL]];
    }
}

#pragma mark - UIScrollViewDelegate
- (void) scrollViewDidScroll:(UIScrollView *) scrollView{
    [self.delegate onScrollViewDidScroll:scrollView];
}


#pragma mark - WeatherModelDelegate
- (void) onUpdatedWeatherData:(NSObject*)currentData{
    dispatch_async(dispatch_get_main_queue(), ^{
        CurrentWeather* current = self.cityWeather.current;
        if([[[WeatherAppModel sharedModel] getDatabase] getIsFavoriteCity:self.cityWeather.ID] && self.updateIsFromUser){
            self.updateIsFromUser = NO;
            [[[WeatherAppModel sharedModel] getDatabase]
                 addHistoryEntryForCity:@[self.cityWeather.ID, [NSDate date], current.mainTemp, current.mainMin_Temp, current.mainMax_Temp]
                 withDescription:current.weatherDescription
                 andNamedIcon:[NSString stringWithFormat:@"icon_%@" ,current.weatherIcon]];
        }
        for (WeatherView* controller in self.controllers) {
            [controller updateView:self.cityWeather];
        }
        if(self.view.window != nil){
            [[[WeatherAppModel sharedModel] getCurrentAnimatedBackground] transitionTo:[[[WeatherAppModel sharedModel] getWeatherBackgroundPreset] setWeatherBackgroundPreset:self.cityWeather.current.weatherId toView:NULL]];
        }
        [self.scrollView.refreshControl endRefreshing];
    });
}

- (void) onUpdateWeatherDataError:(NSString*)message{
    
}

#pragma mark - Private Methods
-(void) notifyOnStartUpdate{
    for (WeatherView* controller in self.controllers) {
        [controller onStartUpdate];
    }
}

-(void) performUpdateFromUser{
    self.updateIsFromUser = YES;
    [self notifyOnStartUpdate];
    [self.cityWeather performUpdate];
}

#pragma mark - Public Methods
-(void) performUpdate{
    [self notifyOnStartUpdate];
    [self.cityWeather performUpdate];
}

-(CityWeather*) getWeatherData{
    return self.cityWeather;
}


-(void) setCity:(NSInteger)cityID{
    [self notifyOnStartUpdate];
    self.cityWeather = [[CityWeather alloc] initWithCityID:[NSNumber numberWithInteger:cityID]];
    self.cityWeather.delegate = self;
}

#pragma mark - Navigation
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"goToHistory"]){
        WeatherHistoryController* controller = (WeatherHistoryController*)[segue destinationViewController];
        controller.data = self.cityWeather;
    }
}

@end
