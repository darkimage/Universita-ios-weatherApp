//
//  WeatherHeaderView.h
//  WeatherApp
//
//  Created by Luca Faggion on 02/12/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherViewProtocol.h"
#import "WeatherView.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherHeaderView : WeatherView<WeatherViewProtocol>
-(id) initWithSegueIdentifier:(NSString*)segueIdentifier ofController:(UIViewController*)controller;
@end

NS_ASSUME_NONNULL_END
