//
//  SkeletonView.h
//  WeatherApp
//
//  Created by Luca Faggion on 02/01/2020.
//  Copyright © 2020 Luca Faggion. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SkeletonView : NSObject
-(void) addView:(UIView*)view;
-(void) addView:(UIView*)view withBorder:(CGFloat)border;
-(void) removeView:(UIView*)view;
-(void) displaySkeletons;
-(void) displaySkeletonsWithUpdate:(Boolean)update;
-(void) stopDisplaySkeletons;
@end

NS_ASSUME_NONNULL_END
