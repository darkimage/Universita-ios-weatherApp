//
//  WeatherHistoryController.h
//  WeatherApp
//
//  Created by Luca Faggion on 04/01/2020.
//  Copyright © 2020 Luca Faggion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityWeather.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherHistoryController : UITableViewController
@property (weak,nonatomic) CityWeather* data;
@end

NS_ASSUME_NONNULL_END
