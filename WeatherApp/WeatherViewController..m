//
//  ViewController.m
//  WeatherApp
//
//  Created by Luca Faggion on 22/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "WeatherViewController.h"
#import <RZViewActions/UIView+RZViewActions.h>

@interface WeatherViewController()
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *WeatherImage2;
@property (weak, nonatomic) IBOutlet UIImageView *WeatherImage;
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ScrollView.delegate = self;
    self.view.backgroundColor = [UIColor colorWithRed:0.13 green:0.38 blue:0.54 alpha:1.0];
    self.WeatherImage.image = [UIImage imageNamed:@"cloud_blurred"];
    self.WeatherImage.frame = CGRectMake(0, 0, 4300, 2000);
    self.WeatherImage.center = CGPointMake(self.view.bounds.size.width/2,self.view.bounds.size.height/2);
    self.WeatherImage2.image = [UIImage imageNamed:@"cloud_blurred"];
    self.WeatherImage2.frame = CGRectMake(0, 0, 4300, 2000);
    self.WeatherImage2.center = CGPointMake(self.view.bounds.size.width/2-self.WeatherImage2.bounds.size.width,self.view.bounds.size.height/2);

    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    RZViewAction* movecloud = [RZViewAction action:^{
        self.WeatherImage.center = CGPointMake(self.WeatherImage.bounds.size.width+self.view.bounds.size.width/2, self.WeatherImage.center.y);
    } withOptions:UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveLinear duration:200.0f];
    
    RZViewAction* movecloud2 = [RZViewAction action:^{
        self.WeatherImage2.center = CGPointMake(self.view.bounds.size.width/2, self.WeatherImage2.center.y);
    } withOptions:UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveLinear duration:200.0f];
    
    RZViewAction *group = [RZViewAction group:@[movecloud, movecloud2]];
    [UIView rz_runAction:group];
    
//    [UIView animateWithDuration:5.0f
//                    delay:0.0f
//                    options: UIViewAnimationOptionRepeat | UIViewAnimationOptionBeginFromCurrentState
//                     animations:^{self.WeatherImage.center = CGPointMake(self.WeatherImage.bounds.size.width+self.view.bounds.size.width/2, self.WeatherImage.center.y);}
//                    completion:nil];
}

- (void) scrollViewDidScroll:(UIScrollView *) scrollView
{
    self.WeatherImage.center = CGPointMake(self.WeatherImage.center.x,-scrollView.contentOffset.y+self.view.bounds.size.height/2);
    self.WeatherImage2.center = CGPointMake(self.WeatherImage2.center.x,-scrollView.contentOffset.y+self.view.bounds.size.height/2);
    NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
}


@end
