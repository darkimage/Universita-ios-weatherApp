//
//  NSValue+AnimBackgroundData.h
//  WeatherApp
//
//  Created by Luca Faggion on 11/09/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^animBlock) (UIImageView*,UIImageView*);
struct _animBackgroundData {
    NSString* imagename;
    CGFloat duration;
    CGFloat offset_y;
    CGRect frame;
    CGFloat alpha;
    animBlock animation;
};
typedef struct _animBackgroundData AnimBackgroundData;

@interface NSValue (AnimBackgroundData)

+(id) valueWithAnimData:(AnimBackgroundData)data;
+(id) valueWithDefaultAnimData;
+(id) valueWithImage:(NSString*)imagename withDuration:(CGFloat)duration withOffset:(CGFloat)offset_y withSize:(CGRect)frame andOpacity:(CGFloat)alpha;
+(id) valueWithImage:(NSString*)imagename withDuration:(CGFloat)duration withOffset:(CGFloat)offset_y withSize:(CGRect)frame withOpacity:(CGFloat)alpha andAnimation:(animBlock) animation;
-(AnimBackgroundData) animDataValue;

@end

NS_ASSUME_NONNULL_END
