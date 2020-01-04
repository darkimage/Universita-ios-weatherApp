//
//  WeatherSearchResultController.h
//  WeatherApp
//
//  Created by Luca Faggion on 30/12/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherSearchDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherSearchResultController : UITableViewController
@property (strong, nonatomic) NSObject<WeatherSearchDelegate>* delegate;
@property (strong, atomic) NSMutableArray* data;
@end

NS_ASSUME_NONNULL_END
