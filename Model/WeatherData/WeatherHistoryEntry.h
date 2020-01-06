//
//  WeatherHistoryEntry.h
//  WeatherApp
//
//  Created by Luca Faggion on 04/01/2020.
//  Copyright © 2020 Luca Faggion. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherHistoryEntry : NSObject
@property (strong, nonatomic) NSNumber* ID;
@property (strong, nonatomic) NSDate* time;
@property (strong, nonatomic) NSNumber* temperature;
@property (strong, nonatomic) NSNumber* minTemperature;
@property (strong, nonatomic) NSNumber* maxTemperature;
@property (strong, nonatomic) NSString* weatherDescription;
@property (strong, nonatomic) NSString* icon;

-(id) initFromData:(NSArray*)historyEntry;
@end

NS_ASSUME_NONNULL_END
