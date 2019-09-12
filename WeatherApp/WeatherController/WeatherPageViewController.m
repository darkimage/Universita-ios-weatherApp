//
//  WheaterPageViewController.m
//  WeatherApp
//
//  Created by Luca Faggion on 06/09/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import "WeatherPageViewController.h"
#import "WeatherViewController.h"
#import "AnimatedBackground.h"

@interface WeatherPageViewController ()
//PROPRIETA
@property (nonatomic,strong) UIPageViewController* pageController;
@property NSInteger currentIndex; //Index attuale settato solo dopo che la transizione e completa
@property NSInteger nextIndex;    //Index verso il quai si sta facendo una transizione
@property NSMutableArray<WeatherViewController*>* viewControllers;
@property WeatherViewController* currentController;
@property AnimatedBackground* backgroundAnimation;

//METODI
- (WeatherViewController*) viewAtIndex:(NSInteger)index;
- (WeatherViewController*) instantiateView:(NSInteger)index;
- (AnimatedBackground*) createAnimatedBackground;
- (void) updateViewAtIndex:(NSInteger)index;
- (NSInteger) getCount; //Ritorna il numero di schermate presenti
@end

@implementation WeatherPageViewController

//INITIALIZZAZIONE
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentIndex = 0;
    self.nextIndex = 0;
    self.viewControllers = [[NSMutableArray<WeatherViewController*> alloc] init];
    self.backgroundAnimation = [self createAnimatedBackground];
    for (int i = 0; i <= 3; i++){
        WeatherViewController* controller = [self instantiateView:i];
        controller.delegate = self.backgroundAnimation;
        [self.viewControllers addObject:controller];
    }
    
    //Init PageViewController dalla Storyboard
    self.pageController = [self.storyboard instantiateViewControllerWithIdentifier:@"WeatherPageViewController"];
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    
    NSArray* firstview = [[NSArray alloc]initWithObjects:[self viewAtIndex:0],nil];
    [self.pageController setViewControllers:firstview direction:UIPageViewControllerNavigationDirectionForward animated:true completion:nil];
    
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    [self.pageController didMoveToParentViewController:self];
}

//METODI DEI DELEGATI O DATASOURCE
//transizione in avanti
- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerBeforeViewController:(nonnull UIViewController *)viewController { 
    WeatherViewController* weatherView = (WeatherViewController*)viewController;
    NSInteger index = weatherView.pageIndex;
    if(index == 0 || index == NSNotFound){
        return nil;
    }
    index-=1;
    
    return [self viewAtIndex:index ];
}

//transizione all'indietro
- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerAfterViewController:(nonnull UIViewController *)viewController { 
    WeatherViewController* weatherView = (WeatherViewController*)viewController;
    NSInteger index = weatherView.pageIndex;
    if(index == NSNotFound){
        return nil;
    }
    index+=1;
    
    if(index == [self getCount]){
        return nil;
    }
    
    return [self viewAtIndex:index ];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if(completed){
        self.currentIndex = self.nextIndex;
        self.currentController = [self.viewControllers objectAtIndex:self.currentIndex];
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers NS_AVAILABLE_IOS(6_0){
    self.nextIndex = ((WeatherViewController*)pendingViewControllers.firstObject).pageIndex;
}

//METODI PRIVATI

- (void)updateViewAtIndex:(NSInteger)index {
    //update view
}

- (WeatherViewController *)viewAtIndex:(NSInteger)index {
    return [self.viewControllers objectAtIndex:index];
}

- (NSInteger)getCount {
    return self.viewControllers.count;
}

- (WeatherViewController *)instantiateView:(NSInteger)index {
    WeatherViewController* weatherViewController = (WeatherViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"WeatherViewController"];
    weatherViewController.pageIndex = index;
    return weatherViewController;
}

- (AnimatedBackground *)createAnimatedBackground {
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
    return bgAnim;
}

- (nonnull WeatherViewController *)getCurrentController { 
    return self.currentController;
}

- (nonnull NSArray<WeatherViewController *> *)getControllers { 
    return [[NSArray alloc] initWithArray:self.viewControllers];
}

@end
