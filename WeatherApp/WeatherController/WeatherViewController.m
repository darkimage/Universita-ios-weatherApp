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
#import "WeatherAverageView.h"
#import "NSValue+AnimBackgroundData.h"

@interface WeatherViewController()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIStackView* stackView;
@property (strong, nonatomic) WeatherHeaderView* headerController;
@property (strong, nonatomic) WeatherAverageView* averageTempController;
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerController = [[WeatherHeaderView alloc] init];
    self.averageTempController = [[WeatherAverageView alloc]init];
    [self.stackView addArrangedSubview:self.headerController];
    [self.stackView addArrangedSubview:self.averageTempController];
    [self.stackView layoutIfNeeded];
    
    self.scrollView.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated{
    [self.delegate viewDidAppear:animated];
    [self.headerController showLoadingAnimation:20.0f];
}

-(void)viewDidLayoutSubviews{
//    [self.headerController showLoadingAnimation:20.0f];
//    CGRect rect1 = self.headerController.CityName.bounds;
}

- (void) scrollViewDidScroll:(UIScrollView *) scrollView
{
    [self.delegate scrollViewDidScroll:scrollView];
//    NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
}

- (void)populateView:(CityWeather *)weatherData {
    self.headerController.CityName.text = weatherData.name;
    self.headerController.Temperature.text = [weatherData.current.mainTemp stringValue];
    self.headerController.TemperatureDesc.text = weatherData.current.weatherDescription;
}

@end
