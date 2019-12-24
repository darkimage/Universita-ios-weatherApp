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
@property (strong, nonatomic) WeatherHeaderView* headerController;
@property (strong, nonatomic) WeatherItemView* averageTempController;
@property (strong, nonatomic) WeatherForecastSlideView* slideController;
@property (strong, nonatomic) WeatherForecastListView* listController;
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerController = [[WeatherHeaderView alloc] init];
    self.averageTempController = [[WeatherItemView alloc] init];
    self.slideController = [[WeatherForecastSlideView alloc] init];
    self.listController = [[WeatherForecastListView alloc] init];
    WeatherHeaderView* test = [[WeatherHeaderView alloc] init];
    [self.stackView addArrangedSubview:self.headerController];
    [self.stackView addArrangedSubview:self.averageTempController];
    [self.stackView addArrangedSubview:self.slideController];
    [self.stackView addArrangedSubview:self.listController];
    [self.stackView addArrangedSubview:test];
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

- (void)populateView:(CityWeather *)weatherData {
    [self.headerController updateView:weatherData];
}

@end
