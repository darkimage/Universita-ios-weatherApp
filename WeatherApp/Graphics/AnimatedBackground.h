//
//  AnimatedBackground.h
//  WeatherApp
//
//  Created by Luca Faggion on 30/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WeatherViewDelegate.h"
#import "BackgroundLayer.h"

NS_ASSUME_NONNULL_BEGIN
@interface AnimatedBackground : NSObject<WeatherViewDelegate>
@property (nonatomic,strong) NSNumber* parallaxMaxOffset;
@property (nonatomic,strong) NSNumber* parallaxMultiplier;

-(instancetype) initWithStructDataArray:(NSArray<NSValue*>*)bgDataArray withColor:(UIColor*)backgroundColor addTo:(UIView*)view;

-(instancetype)initWithStructDataArray:(NSArray<NSValue*>*)bgDataArray withGradient:(CAGradientLayer*)gradient addTo:(nonnull UIView *)view;

-(instancetype) initWithStructData:(NSValue*)bgData withColor:(UIColor*)backgroundColor addTo:(UIView*)view;

-(instancetype) initWithStructData:(NSValue*)bgData withGradient:(CAGradientLayer*)gradient addTo:(UIView*)view;

-(void) addBackgroundToBack:(NSValue*)bgData;

-(void) addBackgroundToFront:(NSValue*)bgData;

-(void) addBackground:(NSValue*)bgData atPosition:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
