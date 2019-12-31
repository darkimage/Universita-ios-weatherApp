//
//  WeatherManageController.h
//  WeatherApp
//
//  Created by Luca Faggion on 29/12/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityWeather.h"
#import "WeatherManageDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherManageController : UITableViewController
@property (weak, nonatomic) NSObject<WeatherManageDelegate>* delegate;
@end

NS_ASSUME_NONNULL_END
