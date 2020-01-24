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
@property CGRect rect;
-(void) internalInit;
@end

@implementation BackgroundLayer

- (instancetype)initWithData:(nonnull NSValue *)animData andSize:(CGRect)rect {
    self = [super init];
    if (self) {
        self.bgData = animData;
        self.rect = rect;
        self.viewLayer = [[UIView alloc] init];
        self.image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[self.bgData animDataValue].imagename]];
        self.image2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[self.bgData animDataValue].imagename]];
        //[self.viewLayer addSubview:self.image1];
        //[self.viewLayer addSubview:self.image2];
        [self internalInit];
    }
    return self;
}

-(void) internalInit{
    self.image1.frame = [self.bgData animDataValue].frame;
    self.image1.center = CGPointMake(self.rect.size.width/2,self.rect.size.height/2+[self.bgData animDataValue].offset_y);
    self.image1Start = self.image1.center;
    self.image1.backgroundColor = [UIColor clearColor];
    self.image1.contentMode = [self.bgData animDataValue].contentMode;
    self.image1.alpha = [self.bgData animDataValue].alpha;
    [self.viewLayer addSubview:self.image1];
    
    if(![self.bgData animDataValue].singleImage){
        self.image2.frame = [self.bgData animDataValue].frame;
        if([self.bgData animDataValue].stackWidth){
            self.image2.center = CGPointMake(self.rect.size.width/2-self.image2.bounds.size.width,self.rect.size.height/2+[self.bgData animDataValue].offset_y);
        }else{
            self.image2.center = CGPointMake(self.rect.size.width/2,self.rect.size.height/2+[self.bgData animDataValue].offset_y-self.image2.bounds.size.height);
        }
        self.image2Start = self.image2.center;
        self.image2.backgroundColor = [UIColor clearColor];
        self.image2.contentMode = [self.bgData animDataValue].contentMode;
        self.image2.alpha = [self.bgData animDataValue].alpha;
        [self.viewLayer addSubview:self.image2];
    }
}

#pragma mark - StateBoundDelegate
-(void) restoreState{
    [self internalInit];
}

- (void)saveState{
    
}

@end
