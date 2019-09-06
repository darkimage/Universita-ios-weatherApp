//
//  WheaterPageViewController.m
//  WeatherApp
//
//  Created by Luca Faggion on 06/09/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import "WeatherPageViewController.h"
#import "WeatherViewController.h"

@interface WeatherPageViewController ()
- (WeatherViewController*) wheatherViewAtIndex:(NSInteger)index;
@property NSInteger count;
@property (nonatomic,strong) UIPageViewController* pageController;
- (NSInteger) getCount;
@end

@implementation WeatherPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 3;

    // Create page view controller
    self.pageController = [self.storyboard instantiateViewControllerWithIdentifier:@"WeatherPageViewController"];
    self.pageController.dataSource = self;
    
    NSArray* firstview = [[NSArray alloc]initWithObjects:[self wheatherViewAtIndex:0],nil];
    [self.pageController setViewControllers:firstview direction:UIPageViewControllerNavigationDirectionForward animated:true completion:nil];
    
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    [self.pageController didMoveToParentViewController:self];
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerBeforeViewController:(nonnull UIViewController *)viewController { 
    WeatherViewController* weatherView = (WeatherViewController*)viewController;
    NSInteger index = weatherView.pageIndex;
    if(index == NSNotFound){
        return nil;
    }
    index = (index-1) % [self getCount];
    
    return [self wheatherViewAtIndex:index ];
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerAfterViewController:(nonnull UIViewController *)viewController { 
    WeatherViewController* weatherView = (WeatherViewController*)viewController;
    NSInteger index = weatherView.pageIndex;
    if(index == NSNotFound){
        return nil;
    }
    index = (index+1) % [self getCount];
    
    return [self wheatherViewAtIndex:index ];
}

- (WeatherViewController *)wheatherViewAtIndex:(NSInteger)index {
    WeatherViewController* weatherViewController = (WeatherViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"WeatherViewController"];
    weatherViewController.pageIndex = index;
    return weatherViewController;
}

- (NSInteger)getCount {
    return self.count;
}

@end
