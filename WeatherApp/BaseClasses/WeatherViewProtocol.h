//
//  WeatherBaseView.h
//  WeatherApp
//
//  Created by Luca Faggion on 15/09/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityWeather.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WeatherViewProtocol <NSObject>
-(void) updateView:(nonnull CityWeather*)weather;
-(void) initView;
@end

NS_ASSUME_NONNULL_END
