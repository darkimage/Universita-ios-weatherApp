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
#import "WeatherAppModel.h"
#import "WeatherManageController.h"

@interface WeatherPageViewController ()
//PROPRIETA
@property (nonatomic,strong) UIPageViewController* pageController;
@property (strong, nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (strong,nonatomic) NSMutableArray<WeatherViewController*>* viewControllers;
@property (strong,nonatomic) WeatherViewController* currentController;
@property (strong,nonatomic) AnimatedBackground* backgroundAnimation;
@property (strong,nonatomic) NSMutableArray* favoriteCities;
@property NSInteger currentIndex; //Index attuale settato solo dopo che la transizione e completa
@property NSInteger nextIndex;    //Index verso il quai si sta facendo una transizione

//METODI PRIVATI
- (WeatherViewController*) viewAtIndex:(NSInteger)index;
- (WeatherViewController*) instantiateView:(NSInteger)index withData:(NSMutableArray*)cities;
- (void) updateViewAtIndex:(NSInteger)index;
- (NSInteger) getCount; //Ritorna il numero di schermate presenti
- (void) goToManage;
@end

@implementation WeatherPageViewController

#pragma mark - Controller Life Cycles
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentIndex = 0;
    self.nextIndex = 0;
    self.viewControllers = [[NSMutableArray<WeatherViewController*> alloc] init];

    
    //RETRIVE FAVORITE CITIES
    self.favoriteCities = [[NSMutableArray alloc] initWithArray:[[[WeatherAppModel sharedModel] getDatabase] getAddedCities] copyItems:YES];
    //Set navController Background and init View Controllers
    UINavigationController *navController = (UINavigationController*)[[(AppDelegate*)[[UIApplication sharedApplication]delegate] window] rootViewController];
    self.backgroundAnimation = [[[WeatherAppModel sharedModel] getWeatherBackgroundPreset] setWeatherBackgroundPreset:@"clear_sky" toView:navController.view];
    for (int i = 0; i < self.favoriteCities.count; i++){
        WeatherViewController* controller = [self instantiateView:i withData:self.favoriteCities];
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
    
    //Set Right Button Bar image
    UIBarButtonItem *manageButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(goToManage)];
    [manageButton setTintColor:[UIColor whiteColor]];
    self.navigationBar.rightBarButtonItem = manageButton;
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSArray* firstview = [[NSArray alloc]initWithObjects:[self viewAtIndex:self.currentIndex],nil];
    [self.pageController setViewControllers:firstview direction:UIPageViewControllerNavigationDirectionForward animated:true completion:nil];
}

#pragma mark - UIPageViewController Interface
/*
 * UIPageViewControllerDataSource, UIPageViewControllerDelegate Interface
 */
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
    WeatherViewController* controller = (WeatherViewController*)pendingViewControllers.firstObject;
    self.nextIndex = controller.pageIndex;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(6_0){
    return self.viewControllers.count;
} // The number of items reflected in the page indicator.
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(6_0){
    return self.currentIndex;
} // The selected item reflected in the page indicator.

#pragma mark - WeatherManageDelegate Protocol
/*
 * Weather Manage Protocol Interface
 */
-(void) onDeleteCityAtIndex:(NSInteger)index{
    [self.favoriteCities removeObjectAtIndex:index];
    [self.viewControllers removeObjectAtIndex:index];
    self.currentIndex = 0;
    self.nextIndex = 0;
    for (int i = 0 ; i < self.viewControllers.count; i++) {
        self.viewControllers[i].pageIndex = i;
    }
}

-(void) onAddCity:(CityWeather*)data{
    self.currentIndex = 0;
    self.nextIndex = 0;
    self.favoriteCities = [[NSMutableArray alloc] initWithArray:[[[WeatherAppModel sharedModel] getDatabase] getAddedCities] copyItems:YES];
    WeatherViewController* controller = [self instantiateView:(self.favoriteCities.count-1) withData:self.favoriteCities];
    controller.delegate = self.backgroundAnimation;
    [self.viewControllers addObject:controller];
}

-(NSArray*) getCities{
    return (NSArray*)self.favoriteCities;
}

-(NSArray<CityWeather*>*) getCitiesWeather{
    NSMutableArray<CityWeather*>* citiesWeather = [[NSMutableArray alloc] init];
    for (int i =0; i<self.viewControllers.count; i++) {
        [citiesWeather addObject:[self.viewControllers[i] getWeatherData]];
    }
    return (NSArray<CityWeather*>*)citiesWeather;
}

#pragma mark - Private Methods
/*
 * METODI PRIVATI
 */

- (void)updateViewAtIndex:(NSInteger)index {
    //update view
}

- (WeatherViewController *)viewAtIndex:(NSInteger)index {
    WeatherViewController* controller = [self.viewControllers objectAtIndex:index];
//    [controller performUpdate];
    return controller;
}

- (NSInteger)getCount {
    return self.viewControllers.count;
}

-(void) goToManage{
    [self performSegueWithIdentifier:@"goToManage" sender:self];
}

- (WeatherViewController *)instantiateView:(NSInteger)index withData:(NSMutableArray*)cities {
    WeatherViewController* weatherViewController = (WeatherViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"WeatherViewController"];
    weatherViewController.pageIndex = index;
    NSString* cityValue = cities[index][0];
    [weatherViewController setCity:[cityValue integerValue]];
    return weatherViewController;
}

#pragma mark - Public Methods
/*
 * METODI PUBBLICI
 */
- (nonnull WeatherViewController *)getCurrentController {
    return self.currentController;
}

- (nonnull NSArray<WeatherViewController *> *)getControllers {
    return (NSArray*)self.viewControllers;
}


/*
 * METODI per la Navigatione
 */
#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"goToManage"]){
        WeatherManageController* manageController = (WeatherManageController*)[segue destinationViewController];
        manageController.delegate = self;
    }
}

@end
