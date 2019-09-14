//
//  WeatherHeaderView.m
//  WeatherApp
//
//  Created by Luca Faggion on 02/12/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "WeatherHeaderView.h"
#import "WeatherAppModel.h"
#import <RZViewActions/UIView+RZViewActions.h>

@interface WeatherHeaderView()
@property (strong, nonatomic) IBOutlet UIView *content;
-(void) internalInit;
-(CAShapeLayer*) createPlaceholderRectLayer:(CGRect)size;
-(CAShapeLayer*) createPlaceholderCircleLayer:(CGRect)size;
@end

@implementation WeatherHeaderView

-(id)init{
    self = [super init];
    if(self){
        [self internalInit];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self internalInit];
    }
    return self;
}

- (void)internalInit {
    [[NSBundle mainBundle] loadNibNamed: @"WeatherHeaderView" owner:self options:nil];
    [self addSubview:self.content];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self.heightAnchor constraintEqualToConstant:self.content.bounds.size.height].active = true;
}

- (void)showLoadingAnimation:(CGFloat)delay {
    self.CityName.hidden = YES;
    self.TemperatureDesc.hidden = YES;
    self.Temperature.hidden = YES;
    self.TemperatureSymbol.hidden = YES;
    self.WeatherIcon.hidden = YES;
    
    [self.content.layer addSublayer:[self createPlaceholderRectLayer:self.CityName.frame]];
    [self.content.layer addSublayer:[self createPlaceholderRectLayer:self.TemperatureDesc.frame]];
    [self.content.layer addSublayer:[self createPlaceholderRectLayer:self.Temperature.frame]];
    [self.content.layer addSublayer:[self createPlaceholderCircleLayer:self.TemperatureSymbol.frame]];
    [self.content.layer addSublayer:[self createPlaceholderCircleLayer:self.WeatherIcon.frame]];
    RZViewAction *loadingAnim = [RZViewAction action:^{
        self.content.alpha = 0.3f;
    } withOptions:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat duration:1.0f];
    [UIView rz_runAction:loadingAnim];
}

- (void)hideLoadingAnimation:(CGFloat)delay {
    
}

- (CAShapeLayer *)createPlaceholderRectLayer:(CGRect)size {
    UIBezierPath *shape = [UIBezierPath bezierPathWithRoundedRect:size cornerRadius:10.0f];
    CAShapeLayer *shapeLayer = [[WeatherAppModel sharedModel] getPlaceHolderShapeLayerStyled];
    shapeLayer.path = shape.CGPath;
    return shapeLayer;
}

- (CAShapeLayer *)createPlaceholderCircleLayer:(CGRect)size {
    CGRect quad = size;
    if(size.size.width < size.size.height){
        quad.size.height = size.size.width;
    }else{
        quad.size.width = size.size.height;
    }
    UIBezierPath *shape = [UIBezierPath bezierPathWithOvalInRect:quad];
    CAShapeLayer *shapeLayer = [[WeatherAppModel sharedModel] getPlaceHolderShapeLayerStyled];
    shapeLayer.path = shape.CGPath;
    return shapeLayer;
}

@end
