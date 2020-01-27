//
//  SkeletonView.m
//  WeatherApp
//
//  Created by Luca Faggion on 02/01/2020.
//  Copyright © 2020 Luca Faggion. All rights reserved.
//

#import "SkeletonView.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CASkeletonGradient.h"

@interface SkeletonView()
@property (strong,nonatomic) NSMutableArray<UIView*>* views;
@property (strong, nonatomic) NSMutableArray<UIView*>* skeletonSubViews;

-(UIView*) createSkeletonView:(UIView*)parentView withBorder:(CGFloat)border;
-(void) destroySkeletonView:(NSUInteger)index;
@end

@implementation SkeletonView

-(instancetype)init{
    self = [super init];
    if(self){
        _views = [[NSMutableArray alloc] init];
        _skeletonSubViews = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) addView:(UIView*)view{
    [self addView:view withBorder:5];
}

-(void) addView:(UIView*)view withBorder:(CGFloat)border{
    [self.views addObject:view];
    [self.skeletonSubViews addObject:[self createSkeletonView:view withBorder:border]];
}

-(UIView*) createSkeletonView:(UIView*)parentView withBorder:(CGFloat)border{
    CGRect frame = CGRectMake(0, 0, parentView.frame.size.width, parentView.frame.size.height);
    UIView* skeletonView = [[UIView alloc] initWithFrame:frame];
    [parentView addSubview:skeletonView];
    skeletonView.hidden = TRUE;
    skeletonView.layer.cornerRadius = border;
    skeletonView.layer.masksToBounds = YES;
    
    CASkeletonGradient* skeletonLayer = [CASkeletonGradient layer];
    [skeletonLayer setUpLayer];
    skeletonLayer.frame = frame;
    [skeletonView.layer insertSublayer:skeletonLayer atIndex:0];
    [skeletonLayer animateSkeleton];
    
    return skeletonView;
}

-(void) removeView:(UIView*)view{
    NSUInteger index = [self.views indexOfObject:view];
    [self.views removeObject:view];
    [self destroySkeletonView:index];
}

-(void) destroySkeletonView:(NSUInteger)index{
    [self.skeletonSubViews[index] removeFromSuperview];
}

-(void) displaySkeletonsWithUpdate:(Boolean)update{
    if(update){
        for (int i = 0; i < self.views.count; i++) {
            CGRect frame = CGRectMake(0, 0, self.views[i].frame.size.width, self.views[i].frame.size.height);
            self.skeletonSubViews[i].layer.frame = frame;
            self.skeletonSubViews[i].hidden = false;
        }
    }else{
        for (int i = 0; i< self.views.count; i++) {
            self.skeletonSubViews[i].hidden = false;
        }
    }
}

-(void) displaySkeletons{
    [self displaySkeletonsWithUpdate:NO];
}

-(void) stopDisplaySkeletons{
    for (int i = 0; i < self.views.count; i++) {
        CASkeletonGradient* skeletonGradient = (CASkeletonGradient*)[self.skeletonSubViews[i].layer.sublayers objectAtIndex:0];
        [skeletonGradient stopSkeletonAnimated:^(){
            for (int i = 0; i< self.views.count; i++) {
                self.skeletonSubViews[i].hidden = true;
            }
        }];
    }
}

@end
