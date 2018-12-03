//
//  BGSlot.h
//  WeatherApp
//
//  Created by Luca Faggion on 30/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


struct animBackgroundData {
    NSString* imagename;
    CGFloat duration;
    CGFloat offset_y;
    CGRect frame;
    CGFloat alpha;
};

struct animBackgroundData DefaultAnimBackgroundData(void);
struct animBackgroundData AnimBackgroundDataMake(NSString* imagename,CGFloat duration,CGFloat offset_y,CGRect frame,CGFloat alpha);

NS_ASSUME_NONNULL_BEGIN
@interface BGSlot : NSObject
@property struct animBackgroundData bgData;
@property (nonatomic,strong)UIImageView* image1;
@property (nonatomic,strong)UIImageView* image2;
@property CGPoint image1Start;
@property CGPoint image2Start;
@end

NS_ASSUME_NONNULL_END
