//
//  AnimatedBackground.h
//  WeatherApp
//
//  Created by Luca Faggion on 30/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WeatherViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN
struct animBackgroundData {
    NSString* imagename;
    NSNumber* duration;
    CGPoint offset;
    UIColor*  backgroundColor;
    CGRect frame;
};

@interface AnimatedBackground : NSObject<WeatherViewDelegate>
@property struct animBackgroundData backgroundData;

-(instancetype) initWithStructData:(struct animBackgroundData)bgData addto:(UIView*)view;

@end

NS_ASSUME_NONNULL_END
