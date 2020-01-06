//
//  WeatherView.h
//  WeatherApp
//
//  Created by Luca Faggion on 30/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AnimatedBackgroundDelegate <NSObject>

- (void) onScrollViewDidScroll:(UIScrollView *) scrollView;

@end

NS_ASSUME_NONNULL_END
