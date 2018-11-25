//
//  WeatherData.h
//  WeatherApp
//
//  Created by Luca Faggion on 23/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherData : NSObject

@property (nonatomic,strong) NSString* city_table;

+(id) sharedData;

-(void) getCityCurrentWeatherbyId:(NSNumber*)city_id withSelector:(SEL)selector ofObject:(id)object;
-(void) getCityForecastWeatherbyId:(NSNumber*)city_id withSelector:(SEL)selector ofObject:(id)object;

@end

NS_ASSUME_NONNULL_END
