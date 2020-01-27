//
//  CASkeletonGradient.m
//  WeatherApp
//
//  Created by Luca Faggion on 02/01/2020.
//  Copyright © 2020 Luca Faggion. All rights reserved.
//
#import "CASkeletonGradient.h"

typedef struct {
    CGFloat start;
    CGFloat end;
} CASkeletonPosition;

static CASkeletonPosition createPosition(CGFloat offset){
    CASkeletonPosition position;
    position.start = 0 + offset;
    position.end = 1 + offset;
    return position;
}

NSString *kSkeletonAnimationKey = @"CASkeleton.SlidingAnimation";
NSString *kSkeletonAnimationKeyOut = @"CASkeleton.FadeOutAnim";

@interface CASkeletonGradient()
@property (strong,nonatomic) UIColor* color1;
@property (strong,nonatomic) UIColor* color2;
@property (strong,nonatomic) SkeletonCallback callback;
@end

@implementation CASkeletonGradient

- (void) setUpLayer{
    self.color1 = [UIColor colorWithWhite:1 alpha:0.7];
    self.color2 = [UIColor colorWithWhite:.8 alpha:0.9];
    self.colors = @[(id)self.color1.CGColor, (id)self.color2.CGColor, (id)self.color1.CGColor, (id)self.color2.CGColor, (id)self.color1.CGColor];
    CASkeletonPosition startPointTransition = createPosition(0);
    CASkeletonPosition endPointTransition = createPosition(1);
    CASkeletonPosition seamPointTransition = createPosition(0.5);
    CASkeletonPosition backSeamPointTransition = createPosition(-0.5);
    CASkeletonPosition backStartPointTransition = createPosition(-1);
    self.locations =[NSArray arrayWithObjects:
                    [NSNumber numberWithFloat:backStartPointTransition.start],
                    [NSNumber numberWithFloat:backSeamPointTransition.start],
                    [NSNumber numberWithFloat:startPointTransition.start],
                    [NSNumber numberWithFloat:seamPointTransition.start],
                    [NSNumber numberWithFloat:endPointTransition.start],nil];
    self.startPoint = CGPointMake(0, 0.5);
    self.endPoint = CGPointMake(1, 0.5);
}

- (void) animateSkeleton
{
    CASkeletonPosition startPointTransition = createPosition(0);
    CASkeletonPosition endPointTransition = createPosition(1);
    CASkeletonPosition seamPointTransition = createPosition(0.5);
    CASkeletonPosition backSeamPointTransition = createPosition(-0.5);
    CASkeletonPosition backStartPointTransition = createPosition(-1);

    CABasicAnimation *startPointAnim = [CABasicAnimation animationWithKeyPath:@"locations"];
    startPointAnim.fromValue = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:backStartPointTransition.start],
                                [NSNumber numberWithFloat:backSeamPointTransition.start],
                                [NSNumber numberWithFloat:startPointTransition.start],
                                [NSNumber numberWithFloat:seamPointTransition.start],
                                [NSNumber numberWithFloat:endPointTransition.start],nil];
    startPointAnim.toValue = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:backStartPointTransition.end],
                              [NSNumber numberWithFloat:backSeamPointTransition.end],
                              [NSNumber numberWithFloat:startPointTransition.end],
                              [NSNumber numberWithFloat:seamPointTransition.end],
                              [NSNumber numberWithFloat:endPointTransition.end],nil];

    startPointAnim.duration = 1;
    startPointAnim.repeatCount = HUGE_VALF;
    startPointAnim.removedOnCompletion = false;

    [self addAnimation:startPointAnim forKey:kSkeletonAnimationKey];
}

- (void)stopSkeleton
{
    [self removeAnimationForKey:kSkeletonAnimationKey];
}

- (void) stopSkeletonAnimated:(SkeletonCallback)completion{
    self.callback = completion;
    UIColor* color1_out = [UIColor colorWithWhite:1 alpha:0.0];
    UIColor* color2_out = [UIColor colorWithWhite:.8 alpha:0.0];
    CABasicAnimation *fadeanim = [CABasicAnimation animationWithKeyPath:@"colors"];
    fadeanim.fromValue = @[(id)self.color1.CGColor, (id)self.color2.CGColor, (id)self.color1.CGColor, (id)self.color2.CGColor, (id)self.color1.CGColor];
    fadeanim.toValue = @[(id)color1_out.CGColor, (id)color2_out.CGColor, (id)color1_out.CGColor, (id)color2_out.CGColor, (id)color1_out.CGColor];
    fadeanim.duration = 1.0f;
    fadeanim.removedOnCompletion = TRUE;
    fadeanim.delegate = self;
    [self addAnimation:fadeanim forKey:kSkeletonAnimationKeyOut];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.callback();
}

@end
