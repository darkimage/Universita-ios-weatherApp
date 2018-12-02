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

@interface WeatherViewController()
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ScrollView.delegate = self;
    struct animBackgroundData bg;
    bg.imagename=@"cloud_blurred";
    bg.frame = CGRectMake(0, 0, 1000, 500);
    bg.offset = [NSNumber numberWithFloat:-200];
    bg.duration = [NSNumber numberWithFloat:20.0f];
    
    struct animBackgroundData bg1;
    bg1.imagename=@"cloud_blurred";
    bg1.frame = CGRectMake(0, 0, 700, 350);
    bg1.offset = [NSNumber numberWithFloat:-150];
    bg1.duration = [NSNumber numberWithFloat:50.0f];
    
    struct animBackgroundData bg2;
    bg2.imagename=@"cloud_blurred";
    bg2.frame = CGRectMake(0, 0, 500, 250);
    bg2.offset = [NSNumber numberWithFloat:-100];
    bg2.duration = [NSNumber numberWithFloat:100.0f];
    //52    108    216
    AnimatedBackground* bgAnim =[[AnimatedBackground alloc] initWithStructData:bg withColor: [UIColor colorWithRed:0.203 green:0.423 blue:0.847 alpha:1.0] addTo:self.view];
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
