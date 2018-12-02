//
//  WeatherHeaderView.h
//  WeatherApp
//
//  Created by Luca Faggion on 02/12/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *Temperature;
@property (weak, nonatomic) IBOutlet UILabel *TemperatureDesc;
@property (weak, nonatomic) IBOutlet UILabel *TemperatureSymbol;
@property (weak, nonatomic) IBOutlet UIImageView *WeatherIcon;

@end

NS_ASSUME_NONNULL_END
