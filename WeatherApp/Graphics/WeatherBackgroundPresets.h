//
//  WeatherBackgroundPresets.h
//  WeatherApp
//
//  Created by Luca Faggion on 03/12/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnimatedBackground.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherBackgroundPresets : NSObject
+(instancetype) sharedPresets;
-(void) setWeatherBackgroundPreset:(NSString*)name toView:(UIView*) view;
-(AnimatedBackground*) getWeatherBackgroundPreset:(NSString*)name;
@end

NS_ASSUME_NONNULL_END
