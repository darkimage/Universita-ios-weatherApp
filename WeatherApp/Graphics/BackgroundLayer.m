//
//  BGSlot.m
//  WeatherApp
//
//  Created by Luca Faggion on 30/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "BackgroundLayer.h"
#include "NSValue+AnimBackgroundData.h"

@implementation BackgroundLayer

- (instancetype)initWithData:(nonnull NSValue *)animData andSize:(CGRect)rect {
    self = [super init];
    if (self) {
        self.bgData = animData;
        self.image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[animData animDataValue].imagename]];
        self.image1.frame = [animData animDataValue].frame;
        self.image1.center = CGPointMake(rect.size.width/2,rect.size.height/2+[animData animDataValue].offset_y);
        self.image1Start = self.image1.center;
        self.image1.backgroundColor = [UIColor clearColor];
        self.image1.contentMode = UIViewContentModeScaleAspectFit;
        self.image1.alpha = [animData animDataValue].alpha;
        
        self.image2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[animData animDataValue].imagename]];
        self.image2.frame = [animData animDataValue].frame;
        self.image2.center = CGPointMake(rect.size.width/2-self.image2.bounds.size.width,rect.size.height/2+[animData animDataValue].offset_y);
        self.image2Start = self.image2.center;
        self.image2.backgroundColor = [UIColor clearColor];
        self.image2.contentMode = UIViewContentModeScaleAspectFit;
        self.image2.alpha = [animData animDataValue].alpha;
    }
    return self;
}

@end
