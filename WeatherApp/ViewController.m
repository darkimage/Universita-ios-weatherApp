//
//  ViewController.m
//  WeatherApp
//
//  Created by Luca Faggion on 22/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ScrollView.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) scrollViewDidScroll:(UIScrollView *) scrollView
{
    NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
}


@end
