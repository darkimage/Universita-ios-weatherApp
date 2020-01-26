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

+ (instancetype)valueWithImage:(nonnull NSString *)imagename withDuration:(CGFloat)duration withOffset:(CGFloat)offset_y withSize:(CGRect)frame andOpacity:(CGFloat)alpha {
    AnimBackgroundData data;
    data.imagename = imagename;
    data.duration = duration;
    data.offset_y = offset_y;
    data.frame = frame;
    data.stackWidth = YES;
    data.alpha = alpha;
    data.allowScroll = YES;
    data.singleImage = NO;
    data.contentMode = UIViewContentModeScaleAspectFit;
    data.animation = ^(UIImageView* im1,UIImageView* im2){
        im1.center = CGPointMake(im1.center.x + im1.frame.size.width, im1.center.y);
        im2.center = CGPointMake(im2.center.x + im2.frame.size.width, im2.center.y);
    };
    return [NSValue value:&data withObjCType:@encode(AnimBackgroundData)];
}

+ (instancetype)valueWithImage:(nonnull NSString *)imagename withDuration:(CGFloat)duration withOffset:(CGFloat)offset_y withSize:(CGRect)frame withOpacity:(CGFloat)alpha withAnimation:(nullable animBlock)animation withStackWidth:(Boolean)stack withAllowScroll:(Boolean)allow andContentMode:(UIViewContentMode)contentMode{
    AnimBackgroundData data;
    data.imagename = imagename;
    data.duration = duration;
    data.offset_y = offset_y;
    data.frame = frame;
    data.alpha = alpha;
    data.stackWidth = stack;
    data.allowScroll = allow;
    data.contentMode = contentMode;
    data.singleImage = NO;
    data.animation = [animation copy];
    return [NSValue value:&data withObjCType:@encode(AnimBackgroundData)];
}

+(instancetype) valueWithImage:(NSString*)imagename withDuration:(CGFloat)duration withOffset:(CGFloat)offset_y withSize:(CGRect)frame withOpacity:(CGFloat)alpha withAnimation:(nullable animBlock) animation andSingleImage:(Boolean)single{
    AnimBackgroundData data;
    data.imagename = imagename;
    data.duration = duration;
    data.offset_y = offset_y;
    data.frame = frame;
    data.alpha = alpha;
    data.stackWidth = YES;
    data.allowScroll = YES;
    data.contentMode = UIViewContentModeScaleAspectFit;
    data.singleImage = single;
    data.animation = [animation copy];
    return [NSValue value:&data withObjCType:@encode(AnimBackgroundData)];
}

+ (instancetype)valueWithDefaultAnimData {
AnimBackgroundData data;
    data.imagename = @"noimage";
    data.duration = 1.0f;
    data.offset_y = 0.0f;
    data.frame = CGRectMake(0.0f, 0.0f, 64.0f, 64.0f);
    data.alpha = 1.0f;
    data.stackWidth = YES;
    data.allowScroll = YES;
    data.singleImage = NO;
    data.contentMode = UIViewContentModeScaleAspectFit;
    data.animation = ^(UIImageView* im1,UIImageView* im2){};
    return [NSValue value:&data withObjCType:@encode(AnimBackgroundData)];
}

+ (instancetype)valueWithAnimData:(AnimBackgroundData)data {
    return [NSValue value:&data withObjCType:@encode(AnimBackgroundData)];
}

@end
