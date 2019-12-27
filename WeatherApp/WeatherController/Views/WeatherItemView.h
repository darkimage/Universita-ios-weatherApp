//
//  WeatherAverageView.h
//  WeatherApp
//
//  Created by Luca Faggion on 06/09/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherViewProtocol.h"
#import "WeatherView.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherItemView : WeatherView<WeatherViewProtocol>
-(void)setTimeIndex:(NSInteger)index;
-(void)getFromCurrent:(Boolean)value;
@end

NS_ASSUME_NONNULL_END
