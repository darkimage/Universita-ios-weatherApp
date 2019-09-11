//
//  NSValue+AnimBackgroundData.m
//  WeatherApp
//
//  Created by Luca Faggion on 11/09/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import "NSValue+AnimBackgroundData.h"

@implementation NSValue (AnimBackgroundData)

- (AnimBackgroundData)animDataValue {
    AnimBackgroundData data;
    [self getValue:&data];
    return data;
}

+ (nonnull id)valueWithImage:(nonnull NSString *)imagename withDuration:(CGFloat)duration withOffset:(CGFloat)offset_y withSize:(CGRect)frame andOpacity:(CGFloat)alpha { 
    AnimBackgroundData data;
    data.imagename = imagename;
    data.duration = duration;
    data.offset_y = offset_y;
    data.frame = frame;
    data.alpha = alpha;
    return [NSValue value:&data withObjCType:@encode(AnimBackgroundData)];
}

+ (nonnull id)valueWithDefaultAnimData { 
AnimBackgroundData data;
    data.imagename = @"noimage";
    data.duration = 1.0f;
    data.offset_y = 0.0f;
    data.frame = CGRectMake(0.0f, 0.0f, 64.0f, 64.0f);
    data.alpha = 1.0f;
    return [NSValue value:&data withObjCType:@encode(AnimBackgroundData)];
}

+ (nonnull id)valueWithAnimData:(AnimBackgroundData)data {
    return [NSValue value:&data withObjCType:@encode(AnimBackgroundData)];
}

@end
