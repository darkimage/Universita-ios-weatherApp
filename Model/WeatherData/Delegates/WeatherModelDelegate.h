//
//  WeatherModelDelegate.h
//  WeatherApp
//
//  Created by Luca Faggion on 11/09/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WeatherModelDelegate <NSObject>

- (void) onUpdatedWeatherData:(NSObject*)currentData;
- (void) onUpdateWeatherDataError:(NSString*)message;

@end

NS_ASSUME_NONNULL_END
