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

@interface WeatherViewController()
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ScrollView.delegate = self;
    
    struct animBackgroundData bg = AnimBackgroundDataMake(@"cloud_blurred", 20.0f, -200.0f, CGRectMake(0, 0, 1000, 500), 1.0f);
    struct animBackgroundData bg1 = AnimBackgroundDataMake(@"cloud_blurred", 50.0f, -150.0f,  CGRectMake(0, 0, 700, 350), 0.5f);
    struct animBackgroundData bg2 = AnimBackgroundDataMake(@"cloud_blurred", 100.0f, -100.0f, CGRectMake(0, 0, 500, 250), 0.3f);
    CAGradientLayer* gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    UIColor* bottom = [UIColor colorWithRed:130.0/255.0 green:165.0/255.0 blue:188.0/255.0 alpha:1.0];
    UIColor* top = [UIColor colorWithRed:37.0/255.0 green:98.0/255.0 blue:129.0/255.0 alpha:1.0];
    gradient.colors = [NSArray arrayWithObjects:(id)bottom.CGColor,(id)top.CGColor, nil];
    //52    108    216
    AnimatedBackground* bgAnim =[[AnimatedBackground alloc] initWithStructData:bg withGradient:gradient addTo:self.view];
    bgAnim.parallaxMultiplier = [NSNumber numberWithFloat:2.0];
    [bgAnim addBackgroundToBack:bg1];
    [bgAnim addBackgroundToBack:bg2];
    
    self.delegate = bgAnim;
}

-(void)viewDidAppear:(BOOL)animated{
    [self.delegate viewDidAppear:animated];
}

- (void) scrollViewDidScroll:(UIScrollView *) scrollView
{
    [self.delegate scrollViewDidScroll:scrollView];
    NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
}


@end
