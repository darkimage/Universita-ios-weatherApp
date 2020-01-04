//
//  WeatherResultCell.h
//  WeatherApp
//
//  Created by Luca Faggion on 02/01/2020.
//  Copyright © 2020 Luca Faggion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityWeather.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherResultCell : UITableViewCell
- (void) setCellData:(CityWeather*)weather;
- (NSInteger) getCityID;
@end

NS_ASSUME_NONNULL_END
