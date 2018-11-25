//
//  City.h
//  WeatherApp
//
//  Created by Luca Faggion on 24/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"
#import "forecastWeather.h"
#import "currentWeather.h"

NS_ASSUME_NONNULL_BEGIN

@interface CityWeather : NSObject

@property (nonatomic,strong)NSNumber * ID;
@property (nonatomic,strong)NSString* name;
@property (nonatomic,strong)NSString* country;
@property (nonatomic,strong)NSNumber * lon;
@property (nonatomic,strong)NSNumber * lat;
@property (nonatomic,strong)currentWeather* current;
@property (nonatomic,strong)forecastWeather* forecast;

-(instancetype) initWithDatabase:(DBManager*)Db fromId:(NSNumber*)city_id;

@end

NS_ASSUME_NONNULL_END
