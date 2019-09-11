//
//  ViewController.h
//  WeatherApp
//
//  Created by Luca Faggion on 22/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherViewDelegate.h"
#import "CityWeather.h"

@interface WeatherViewController : UIViewController<UIScrollViewDelegate>
@property NSInteger pageIndex;
- (void) populateView:(CityWeather*)weatherData;
@end

