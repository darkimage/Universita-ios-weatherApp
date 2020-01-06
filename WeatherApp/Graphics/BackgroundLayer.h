//
//  BGSlot.h
//  WeatherApp
//
//  Created by Luca Faggion on 30/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "StateBoundDelegate.h"

NS_ASSUME_NONNULL_BEGIN
@interface BackgroundLayer : NSObject<StateBoundDelegate>
@property NSValue* bgData;
@property (nonatomic,strong) UIImageView* image1;
@property (nonatomic,strong) UIImageView* image2;
@property (nonatomic,strong) UIView* viewLayer;
@property CGPoint image1Start;
@property CGPoint image2Start;


-(instancetype) initWithData:(NSValue*)animData andSize:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
