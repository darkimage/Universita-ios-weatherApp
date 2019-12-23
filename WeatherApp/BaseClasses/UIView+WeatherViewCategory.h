//
//  WeatherView+WeatherViewCategory.h
//  WeatherApp
//
//  Created by Luca Faggion on 23/12/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (WeatherViewCategory)
-(void) initViewFromNib: (NSString*) name;
@end

NS_ASSUME_NONNULL_END
