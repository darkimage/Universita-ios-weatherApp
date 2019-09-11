//
//  ViewController.m
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
#import "NSValue+AnimBackGroundData.h"

@interface WeatherViewController()
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (strong, nonatomic) NSObject<WeatherViewDelegate>* delegate;
@property (weak, nonatomic) IBOutlet UIStackView* stackView;
@property (strong, nonatomic) WeatherHeaderView* header;
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    
    self.header = [[WeatherHeaderView alloc] init];
    [self.stackView addArrangedSubview:self.header];
    [self.stackView addArrangedSubview:[[WeatherAverageView alloc]init]];
    [self.stackView layoutIfNeeded];
    
    [super viewDidLoad];
    self.ScrollView.delegate = self;
    
    NSValue* bg = [NSValue valueWithImage:@"cloud_blurred" withDuration:20.0f withOffset:-200.0f withSize:CGRectMake(0, 0, 1000, 500) andOpacity: 1.0f];
    
    NSValue* bg1 = [NSValue valueWithImage:@"cloud_blurred" withDuration:50.0f withOffset:-150.0f withSize:CGRectMake(0, 0, 700, 350) andOpacity: 0.5f];
    
    NSValue* bg2 = [NSValue valueWithImage:@"cloud_blurred" withDuration: 100.0f withOffset:-100.0f withSize:CGRectMake(0, 0, 500, 250) andOpacity: 0.3f];

    CAGradientLayer* gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    UIColor* bottom = [UIColor colorWithRed:130.0/255.0 green:165.0/255.0 blue:188.0/255.0 alpha:1.0];
    UIColor* top = [UIColor colorWithRed:37.0/255.0 green:98.0/255.0 blue:129.0/255.0 alpha:1.0];
    gradient.colors = [NSArray arrayWithObjects:(id)bottom.CGColor,(id)top.CGColor, nil];
    //52    108    216
    NSArray<NSValue*>* animDataArray = [[NSArray<NSValue*> alloc] initWithObjects:bg2,bg1,bg, nil];
    AnimatedBackground* bgAnim = [[AnimatedBackground alloc] initWithStructDataArray:animDataArray withGradient:gradient addTo:self.view];
    bgAnim.parallaxMultiplier = [NSNumber numberWithFloat:2.0];
    self.delegate = bgAnim;
    [self.view bringSubviewToFront:self.stackView];
}

-(void)viewDidAppear:(BOOL)animated{
    [self.delegate viewDidAppear:animated];
}

- (void) scrollViewDidScroll:(UIScrollView *) scrollView
{
    [self.delegate scrollViewDidScroll:scrollView];
    NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
}

- (void)populateView:(CityWeather *)weatherData {
    self.header.CityName.text = weatherData.name;
    self.header.Temperature.text = [weatherData.current.mainTemp stringValue];
    self.header.TemperatureDesc.text = weatherData.current.weatherDescription;
}

@end
