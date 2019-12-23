//
//  WeatherAverageView.h
//  WeatherApp
//
//  Created by Luca Faggion on 06/09/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherAverageView : UIView<WeatherBaseView>
@property (weak, nonatomic) IBOutlet UILabel* TodayLabel;
@property (weak, nonatomic) IBOutlet UILabel* AverageLabel;
-(void) showLoadingAnimation:(CGFloat)delay;
-(void) hideLoadingAnimation:(CGFloat)delay;
-(void) updateView:(nonnull CityWeather*)weather;
@end

NS_ASSUME_NONNULL_END
