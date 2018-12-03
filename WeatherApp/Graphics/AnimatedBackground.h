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
#import "BGSlot.h"

NS_ASSUME_NONNULL_BEGIN
@interface AnimatedBackground : NSObject<WeatherViewDelegate>
@property (nonatomic,strong) NSNumber* parallaxMaxOffset;
@property (nonatomic,strong) NSNumber* parallaxMultiplier;

-(instancetype) initWithStructData:(struct animBackgroundData)bgData withColor:(UIColor*)backgroundColor addTo:(UIView*)view;


-(instancetype) initWithStructData:(struct animBackgroundData)bgData withGradient:(CAGradientLayer*)gradient addTo:(UIView*)view;

-(instancetype) initWithPreset:(NSString*)name addTo:(UIView*)view;

-(void) addBackgroundToBack:(struct  animBackgroundData) bgData;

-(void) addBackgroundToFront:(struct  animBackgroundData) bgData;

-(void) addBackground:(struct  animBackgroundData) bgData atPosition:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
