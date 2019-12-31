//
//  WeatherSearchController.h
//  WeatherApp
//
//  Created by Luca Faggion on 29/12/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherSearchDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherSearchController : UIViewController<UISearchResultsUpdating>
@property (weak, nonatomic) NSObject<WeatherSearchDelegate>* delegate;
@end

NS_ASSUME_NONNULL_END
