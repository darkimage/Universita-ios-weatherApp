//
//  WeatherManageDelegate.h
//  WeatherApp
//
//  Created by Luca Faggion on 30/12/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityWeather.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WeatherManageDelegate <NSObject>

-(void) onDeleteCityAtIndex:(NSInteger)index;
-(void) onAddCity:(CityWeather*)datal;
-(NSArray*) getCities;
-(NSArray<CityWeather*>*) getCitiesWeather;
@end

NS_ASSUME_NONNULL_END
