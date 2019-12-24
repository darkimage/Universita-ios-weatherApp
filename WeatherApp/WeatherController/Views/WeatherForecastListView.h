//
//  WeatherForecastListView.h
//  WeatherApp
//
//  Created by Luca Faggion on 24/12/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherView.h"
#import "WeatherViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherForecastListView : WeatherView<WeatherViewProtocol>

@end

NS_ASSUME_NONNULL_END
