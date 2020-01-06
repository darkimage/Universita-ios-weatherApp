//
//  WeatherHistoryCell.h
//  WeatherApp
//
//  Created by Luca Faggion on 04/01/2020.
//  Copyright © 2020 Luca Faggion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherHistoryEntry.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherHistoryCell : UITableViewCell
-(void) setCellData:(WeatherHistoryEntry*)entry;
@end

NS_ASSUME_NONNULL_END
