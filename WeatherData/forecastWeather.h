//
//  forecastWeather.h
//  WeatherApp
//
//  Created by Luca Faggion on 24/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "currentWeather.h"

NS_ASSUME_NONNULL_BEGIN

@interface forecastWeather : NSObject

@property (nonatomic,strong) NSMutableArray* forecastWeather;

-(instancetype) initWithDictionary:(NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END
