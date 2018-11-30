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
@property (weak, nonatomic) IBOutlet UIImageView *WeatherImage2;
@property (weak, nonatomic) IBOutlet UIImageView *WeatherImage;
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ScrollView.delegate = self;
    struct animBackgroundData bg;
    bg.imagename=@"cloud_blurred";
    bg.backgroundColor = [UIColor colorWithRed:0.13 green:0.38 blue:0.54 alpha:1.0];
    bg.frame = CGRectMake(0, 0, 1500, 800);
    bg.offset = CGPointMake(0, -200);
    bg.duration = [NSNumber numberWithFloat:120.0f];
    
    self.delegate = [[AnimatedBackground alloc] initWithStructData:bg addto:self.view];
}

-(void)viewDidAppear:(BOOL)animated{
    [self.delegate viewDidAppear:animated];
}

- (void) scrollViewDidScroll:(UIScrollView *) scrollView
{
    [self.delegate scrollViewDidScroll:scrollView];
    //NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
}


@end
