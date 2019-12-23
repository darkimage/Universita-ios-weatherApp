//
//  WeatherForecastSlotView.h
//  WeatherApp
//
//  Created by Luca Faggion on 15/09/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherViewProtocol.h"
#import "WeatherView.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherForecastSlotView : WeatherView<WeatherViewProtocol>
//@property (strong, nonatomic) IBOutlet UILabel *TimeFromNowLabel;
//@property (strong, nonatomic) IBOutlet UILabel *TemperatureLabel;
//@property (strong, nonatomic) IBOutlet UILabel *PrecipitationLabel;
//@property (strong, nonatomic) IBOutlet UIImageView *WeatherIcon;
@end

NS_ASSUME_NONNULL_END
