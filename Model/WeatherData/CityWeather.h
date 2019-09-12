//
//  City.h
//  WeatherApp
//
//  Created by Luca Faggion on 24/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"
#import "ForecastWeather.h"
#import "CurrentWeather.h"
#import "WeatherModelDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface CityWeather : NSObject

@property (nonatomic,strong)NSNumber * ID;
@property (nonatomic,strong)NSString* name;
@property (nonatomic,strong)NSString* country;
@property (nonatomic,strong)NSNumber* lon;
@property (nonatomic,strong)NSNumber* lat;
@property (nonatomic,strong)NSDate* last_updated;
@property (nonatomic,strong)CurrentWeather* current;
@property (nonatomic,strong)ForecastWeather* forecast;
@property NSObject<WeatherModelDelegate>* delegate;

-(instancetype) initWithCityID:(NSNumber*)city_id;

-(void) performUpdate;

@end

NS_ASSUME_NONNULL_END
