//
//  WeatherSearchDelegate.h
//  WeatherApp
//
//  Created by Luca Faggion on 30/12/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WeatherSearchDelegate <NSObject>
-(void) onSelectedCityFromSearch:(NSInteger)city_id;
@end

NS_ASSUME_NONNULL_END
