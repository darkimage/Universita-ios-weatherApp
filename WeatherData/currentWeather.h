//
//  cityWeather.h
//  WeatherApp
//
//  Created by Luca Faggion on 24/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface currentWeather : NSObject

@property (nonatomic,strong) NSString* weatherMain;
@property (nonatomic,strong) NSString* weatherDescription;
@property (nonatomic,strong) NSString* weatherIcon;
@property (nonatomic,strong) NSNumber* mainTemp;
@property (nonatomic,strong) NSNumber* mainPressure;
@property (nonatomic,strong) NSNumber* mainHumidity;
@property (nonatomic,strong) NSNumber* mainMin_Temp;
@property (nonatomic,strong) NSNumber* mainMax_Temp;
@property (nonatomic,strong) NSNumber* mainSea_Level;
@property (nonatomic,strong) NSNumber* mainGround_Level;
@property (nonatomic,strong) NSNumber* windSpeed;
@property (nonatomic,strong) NSNumber* windDeg;
@property (nonatomic,strong) NSNumber* cloudiness;
@property (nonatomic,strong) NSNumber* rainVol_1h;
@property (nonatomic,strong) NSNumber* rainVol_3h;
@property (nonatomic,strong) NSNumber* snowVol_1h;
@property (nonatomic,strong) NSNumber* snowVol_3h;
@property (nonatomic,strong) NSDate* date;

-(instancetype) initWithDictionary:(NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END
