//
//  AnimatedBackground.h
//  WeatherApp
//
//  Created by Luca Faggion on 30/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AnimatedBackgroundDelegate.h"
#import "BackgroundLayer.h"
#import "NSValue+AnimBackgroundData.h"
#import "StateBoundDelegate.h"

NS_ASSUME_NONNULL_BEGIN
@interface AnimatedBackground : NSObject<AnimatedBackgroundDelegate,StateBoundDelegate>
@property (nonatomic,strong) NSNumber* parallaxMaxOffset;
@property (nonatomic,strong) NSNumber* parallaxMultiplier;

-(instancetype) initWithStructDataArray:(NSArray<NSValue*>*)bgDataArray withColor:(UIColor*)backgroundColor addTo:(nullable UIView*)view;

-(instancetype) initWithStructDataArray:(NSArray<NSValue*>*)bgDataArray withGradient:(CAGradientLayer*)gradient addTo:(nullable UIView *)view;

-(instancetype) initWithStructData:(NSValue*)bgData withColor:(UIColor*)backgroundColor addTo:(nullable UIView*)view;

-(instancetype) initWithStructData:(nullable NSValue*)bgData withGradient:(CAGradientLayer*)gradient addTo:(nullable UIView*)view;

-(void) addBackgroundToBack:(NSValue*)bgData;

-(void) addBackgroundToFront:(NSValue*)bgData;

-(void) applyToView:(nullable UIView*)view;

-(void) transitionTo:(AnimatedBackground*)newBackground;

-(void) animate;

-(CAGradientLayer*) getGradient;

-(NSArray<NSValue*>*) getLayerData;
@end

NS_ASSUME_NONNULL_END
