//
//  BGSlot.m
//  WeatherApp
//
//  Created by Luca Faggion on 30/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "BackgroundLayer.h"
#include "NSValue+AnimBackgroundData.h"
@interface BackgroundLayer()
@property (strong,nonatomic) NSValue* data;
@property CGRect rect;

-(void) internalInit;
@end

@implementation BackgroundLayer

- (instancetype)initWithData:(nonnull NSValue *)animData andSize:(CGRect)rect {
    self = [super init];
    if (self) {
        self.data = animData;
        self.rect = rect;
        [self internalInit];
    }
    return self;
}

-(void) internalInit{
    self.image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[self.data animDataValue].imagename]];
    self.image1.frame = [self.data animDataValue].frame;
    self.image1.center = CGPointMake(self.rect.size.width/2,self.rect.size.height/2+[self.data animDataValue].offset_y);
    self.image1Start = self.image1.center;
    self.image1.backgroundColor = [UIColor clearColor];
    self.image1.contentMode = UIViewContentModeScaleAspectFit;
    self.image1.alpha = [self.data animDataValue].alpha;
    
    self.image2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[self.data animDataValue].imagename]];
    self.image2.frame = [self.data animDataValue].frame;
    self.image2.center = CGPointMake(self.rect.size.width/2-self.image2.bounds.size.width,self.rect.size.height/2+[self.data animDataValue].offset_y);
    self.image2Start = self.image2.center;
    self.image2.backgroundColor = [UIColor clearColor];
    self.image2.contentMode = UIViewContentModeScaleAspectFit;
    self.image2.alpha = [self.data animDataValue].alpha;
}

-(void) restoreState{
    [self internalInit];
}

@end
