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
        _bgData = animData;
        _rect = rect;
        _viewLayer = [[UIView alloc] init];
        _image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[_bgData animDataValue].imagename]];
        _image2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[_bgData animDataValue].imagename]];
        //[self.viewLayer addSubview:self.image1];
        //[self.viewLayer addSubview:self.image2];
        [self internalInit];
    }
    return self;
}

-(void) internalInit{
    _image1.frame = [_bgData animDataValue].frame;
    _image1.center = CGPointMake(_rect.size.width/2,_rect.size.height/2+[_bgData animDataValue].offset_y);
    _image1Start = _image1.center;
    _image1.backgroundColor = [UIColor clearColor];
    _image1.contentMode = [_bgData animDataValue].contentMode;
    _image1.alpha = [_bgData animDataValue].alpha;
    [_viewLayer addSubview:_image1];
    
    if(![_bgData animDataValue].singleImage){
        _image2.frame = [_bgData animDataValue].frame;
        if([_bgData animDataValue].stackWidth){
            _image2.center = CGPointMake(_rect.size.width/2-_image2.bounds.size.width,_rect.size.height/2+[_bgData animDataValue].offset_y);
        }else{
            _image2.center = CGPointMake(_rect.size.width/2,_rect.size.height/2+[_bgData animDataValue].offset_y-_image2.bounds.size.height);
        }
        _image2Start = _image2.center;
        _image2.backgroundColor = [UIColor clearColor];
        _image2.contentMode = [_bgData animDataValue].contentMode;
        _image2.alpha = [_bgData animDataValue].alpha;
        [_viewLayer addSubview:_image2];
    }
}

#pragma mark - StateBoundDelegate
-(void) restoreState{
    [self internalInit];
}

- (void)saveState{
    
}

@end
