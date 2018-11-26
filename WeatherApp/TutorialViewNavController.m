//
//  TutorialViewController.m
//  WeatherApp
//
//  Created by Luca Faggion on 26/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "TutorialViewNavController.h"
#import "TutorialViewController.h"

@interface TutorialViewNavController()
@property (nonatomic,strong) NSArray* colors;
@property (nonatomic,strong) UIPageViewController* pageController;
-(TutorialViewController*) pageTutorialAtIndex:(NSInteger)index;
@end

@implementation TutorialViewNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.colors = [[NSArray alloc] initWithObjects:UIColor.blueColor,UIColor.brownColor,UIColor.redColor, nil];
    self.pageController = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialPageViewController"];
    self.pageController.dataSource = self;

    NSArray* firstview = [[NSArray alloc]initWithObjects:[self pageTutorialAtIndex:0],nil];
    [self.pageController setViewControllers:firstview direction:UIPageViewControllerNavigationDirectionForward animated:true completion:nil];
    
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    [self.pageController didMoveToParentViewController:self];
    
}
- (IBAction)skipToApp:(id)sender {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WeatherViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}

-(TutorialViewController*) pageTutorialAtIndex:(NSInteger)index{
    TutorialViewController* tutview = (TutorialViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"TutorialViewController"];
    tutview.color = self.colors[index];
    tutview.pageIndex = index;
    return tutview;
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)PageViewController viewControllerAfterViewController:(nonnull UIViewController *)viewController{
    
    TutorialViewController* tutview = (TutorialViewController*)viewController;
    NSInteger index = tutview.pageIndex;
    if(index == NSNotFound){
        return nil;
    }
    index+=1;
    
    if(index == [self.colors count])
    {
        return nil;
    }
    
    return [self pageTutorialAtIndex:index ];
}
//
- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerBeforeViewController:(nonnull UIViewController *)viewController {
    
    TutorialViewController* tutview = (TutorialViewController*)viewController;
    NSInteger index = tutview.pageIndex;
    if(index == 0 || index == NSNotFound){
        return nil;
    }
    index-=1;
    return [self pageTutorialAtIndex:index ];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController // The number of items reflected in the page indicator.
{
    return [self.colors count];
}
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController // The selected item reflected in the page indicator.
{
    return 0;
}

@end
