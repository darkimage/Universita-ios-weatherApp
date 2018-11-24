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

-(NSArray*) getCitybyPartialName:(NSString*)partialname;

@end

NS_ASSUME_NONNULL_END
