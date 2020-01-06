//
//  StateBoundDelegate.h
//  WeatherApp
//
//  Created by Luca Faggion on 06/01/2020.
//  Copyright © 2020 Luca Faggion. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol StateBoundDelegate <NSObject>
- (void) saveState;
- (void) restoreState;
@end

NS_ASSUME_NONNULL_END
