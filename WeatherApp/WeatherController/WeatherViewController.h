//
//  WeatherViewController.h
//  WeatherApp
//
//  Created by Luca Faggion on 22/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimatedBackgroundDelegate.h"
#import "WeatherModelDelegate.h"
#import "CityWeather.h"
#import "AnimatedBackground.h"

@interface WeatherViewController : UIViewController<UIScrollViewDelegate,WeatherModelDelegate>

@property NSInteger pageIndex;
@property (strong, nonatomic) NSObject<AnimatedBackgroundDelegate>* delegate;

-(void) setCity:(NSInteger)cityID;
-(void) performUpdate;
-(CityWeather*) getWeatherData;

@end

