//
//  WeatherManageCell.h
//  WeatherApp
//
//  Created by Luca Faggion on 30/12/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityWeather.h"
NS_ASSUME_NONNULL_BEGIN

@interface WeatherManageCell : UITableViewCell
-(void) initCellWithData:(CityWeather*)data;
@end

NS_ASSUME_NONNULL_END
