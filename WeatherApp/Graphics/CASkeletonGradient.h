//
//  CASkeletonGradient.h
//  WeatherApp
//
//  Created by Luca Faggion on 02/01/2020.
//  Copyright © 2020 Luca Faggion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^SkeletonCallback)(void);
@interface CASkeletonGradient : CAGradientLayer<CAAnimationDelegate>
- (void) setUpLayer;
- (void) animateSkeleton;
- (void) stopSkeleton;
- (void) stopSkeletonAnimated:(SkeletonCallback)completion;
@end

NS_ASSUME_NONNULL_END
