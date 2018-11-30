//
//  WeatherView.h
//  WeatherApp
//
//  Created by Luca Faggion on 30/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WeatherViewDelegate <NSObject>

- (void) scrollViewDidScroll:(UIScrollView *) scrollView;
- (void)viewDidAppear:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
