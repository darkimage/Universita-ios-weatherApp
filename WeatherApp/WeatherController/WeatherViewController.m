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
#import "WeatherForecastSlideView.h"
#import "NSValue+AnimBackgroundData.h"

@interface WeatherViewController()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIStackView* stackView;
@property (strong, nonatomic) WeatherHeaderView* headerController;
@property (strong, nonatomic) WeatherAverageView* averageTempController;
@property (strong, nonatomic) WeatherForecastSlideView* slideController;
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerController = [[WeatherHeaderView alloc] init];
    self.averageTempController = [[WeatherAverageView alloc] init];
    self.slideController = [[WeatherForecastSlideView alloc] init];
    [self.stackView addArrangedSubview:self.headerController];
    [self.stackView addArrangedSubview:self.averageTempController];
    [self.stackView addArrangedSubview:self.slideController];
    [self.stackView layoutIfNeeded];
    
    self.scrollView.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated{
    [self.delegate viewDidAppear:animated];
    [self.slideController layoutIfNeeded];
}

- (void) scrollViewDidScroll:(UIScrollView *) scrollView{
    [self.delegate scrollViewDidScroll:scrollView];
//    NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
}

- (void)populateView:(CityWeather *)weatherData {
    [self.headerController updateView:weatherData];
}

@end
