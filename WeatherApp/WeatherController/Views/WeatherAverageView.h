//
//  WeatherAverageView.h
//  WeatherApp
//
//  Created by Luca Faggion on 06/09/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherAverageView : UIView
@property (weak, nonatomic) IBOutlet UILabel* TodayLabel;
@property (weak, nonatomic) IBOutlet UILabel* AverageLabel;
@end

NS_ASSUME_NONNULL_END
