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
    Boolean stackWidth;
    Boolean allowScroll;
    UIViewContentMode contentMode;
    Boolean singleImage;
    animBlock animation;
};
typedef struct _animBackgroundData AnimBackgroundData;

@interface NSValue (AnimBackgroundData)

+(instancetype) valueWithAnimData:(AnimBackgroundData)data;
+(instancetype) valueWithDefaultAnimData;
+(instancetype) valueWithImage:(NSString*)imagename withDuration:(CGFloat)duration withOffset:(CGFloat)offset_y withSize:(CGRect)frame andOpacity:(CGFloat)alpha;
+(instancetype) valueWithImage:(NSString*)imagename withDuration:(CGFloat)duration withOffset:(CGFloat)offset_y withSize:(CGRect)frame withOpacity:(CGFloat)alpha withAnimation:(nullable animBlock) animation withStackWidth:(Boolean)stack withAllowScroll:(Boolean)allow andContentMode:(UIViewContentMode)contentMode;
+(instancetype) valueWithImage:(NSString*)imagename withDuration:(CGFloat)duration withOffset:(CGFloat)offset_y withSize:(CGRect)frame withOpacity:(CGFloat)alpha withAnimation:(nullable animBlock) animation andSingleImage:(Boolean)single;
-(AnimBackgroundData) animDataValue;

@end

NS_ASSUME_NONNULL_END
