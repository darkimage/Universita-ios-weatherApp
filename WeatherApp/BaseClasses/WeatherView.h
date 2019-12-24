//
//  WeatherView.h
//  WeatherApp
//
//  Created by Luca Faggion on 23/12/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherView : UIView<WeatherViewProtocol>
-(id) initWithCoder:(NSCoder *)aDecoder;
-(id) initWithFrame:(CGRect)frame;
-(void) updateView:(nonnull CityWeather*)weather;
@end

NS_ASSUME_NONNULL_END
