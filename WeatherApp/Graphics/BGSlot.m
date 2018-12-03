//
//  BGSlot.m
//  WeatherApp
//
//  Created by Luca Faggion on 30/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "BGSlot.h"

struct animBackgroundData DefaultAnimBackgroundData(void){
    struct animBackgroundData data;
    data.imagename = @"noimage";
    data.duration = 1.0f;
    data.offset_y = 0.0f;
    data.frame = CGRectMake(0.0f, 0.0f, 64.0f, 64.0f);
    data.alpha = 1.0f;
    return data;
}

struct animBackgroundData AnimBackgroundDataMake(NSString* imagename,CGFloat duration,CGFloat offset_y,CGRect frame,CGFloat alpha){
    struct animBackgroundData data;
    data.imagename = imagename;
    data.duration = duration;
    data.offset_y = offset_y;
    data.frame = frame;
    data.alpha = alpha;
    return data;
}

@implementation BGSlot

@end
